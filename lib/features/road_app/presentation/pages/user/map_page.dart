

// FULL MapScreen Code with Debug Support
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:location/location.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'package:road_app/app/__app.dart';
import 'package:road_app/cores/__cores.dart';
import 'package:road_app/features/road_app/presentation/_presentation.dart';

// Full Fixed MapScreen Code

class TrackablePothole {
  final String id;
  final LatLng position;
  final LatLng projectedPoint;
  final double distanceFromStart;
  bool notified;

  TrackablePothole({
    required this.id,
    required this.position,
    required this.projectedPoint,
    required this.distanceFromStart,
    this.notified = false,
  });

  @override
  String toString() =>
      'Pothole(id: $id, pos: $position, projected: $projectedPoint, distFromStart: $distanceFromStart, notified: $notified)';
}

class ProjectionResult {
  final LatLng point;
  final int index;
  ProjectionResult(this.point, this.index);
}

enum DistanceAlgorithm {
  haversine,
  vincenty,
}

class MapScreen extends StatefulWidget {
  final LatLng? destination;
  final String? destinationAddress;

  const MapScreen({super.key, this.destination, this.destinationAddress});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final nearbyPotholeBloc = getIt<NearbyPotholeBloc>();
  final nearbyPotholeCubit = getIt<NearbyPotholeCubit>();
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  final String _googleMapsApiKey = AppConstants.googleApiKey;
  GoogleMapController? _mapController;

  LatLng? _currentLocation;
  LatLng? _destination;
  String? _mapStyle;

  List<LatLng> _routePolyline = [];
  List<TrackablePothole> _trackablePotholes = [];
  Set<String> notifiedPotholeIds = {};
  Map<String, Marker> _potholeMarkers = {};

  bool _showPopup = false;
  int? _popupDistance;

  static const double _notificationDistance = 200.0;

  @override
  void initState() {
    super.initState();
    _loadMapStyle();
    _initializeNotifications();
    if (widget.destination != null) _destination = widget.destination;
    _startLocationTracking();
  }

  Future<void> _loadMapStyle() async {
    final style = await rootBundle
        .loadString('assets/assets/map_styles/navigation_style.json');
    setState(() => _mapStyle = style);
  }

  Future<void> _initializeNotifications() async {
    const settings = InitializationSettings(
      android: AndroidInitializationSettings('ic_launcher'),
    );
    await flutterLocalNotificationsPlugin.initialize(settings);
  }

  Future<void> _startLocationTracking() async {
    final location = Location();

    if (!await location.serviceEnabled() && !await location.requestService()) {
      return;
    }
    if (await location.hasPermission() == PermissionStatus.denied &&
        await location.requestPermission() != PermissionStatus.granted) return;

    final loc = await location.getLocation();
    _currentLocation = LatLng(loc.latitude!, loc.longitude!);

    if (_currentLocation != null && _destination != null) {
      await _rebuildRouteAndPotholes();
    }

    _startPotholePolling();

    location.onLocationChanged.listen((loc) {
      final userLocation = LatLng(loc.latitude!, loc.longitude!);
      _onUserLocationChanged(userLocation);
    });
  }

  void _startPotholePolling() {
    Timer.periodic(const Duration(seconds: 1000), (_) async {
      try {
        final loc = await Location().getLocation();
        nearbyPotholeCubit.updateLatLng(
          RequiredNum.dirty(loc.latitude!),
          RequiredNum.dirty(loc.longitude!),
        );
        nearbyPotholeBloc.add(FetchNearbyPotholes(nearbyPotholeCubit.state));
      } catch (e) {
        debugPrint('Polling error: $e');
      }
    });
  }

  double _calculateDistance(LatLng a, LatLng b,
      {DistanceAlgorithm algo = DistanceAlgorithm.haversine}) {
    switch (algo) {
      case DistanceAlgorithm.haversine:
        return _haversineDistance(a, b);
      case DistanceAlgorithm.vincenty:
        return _vincentyDistance(a, b);
    }
  }

  Future<void> _rebuildRouteAndPotholes() async {
    if (_currentLocation == null || _destination == null) return;

    _routePolyline = await _getRoutePolyline(
      origin: _currentLocation!,
      destination: _destination!,
    );

    final potholes = nearbyPotholeBloc.state.potholes;
    final List<TrackablePothole> filtered = [];

    debugPrint("\n--- PROCESSING POTHOLES ---");

    for (final pothole in potholes) {
      final pos = LatLng(pothole.geometry.coordinates.last,
          pothole.geometry.coordinates.first);
      final proj = _projectOnPolyline(pos, _routePolyline);
      final distFromRoute = _calculateDistance(pos, proj.point);

      if (distFromRoute <= 30.0) {
        final distFromStart =
            _getDistanceAlongPolyline(_routePolyline, proj.index);
        final trackable = TrackablePothole(
          id: pothole.id.toString(),
          position: pos,
          projectedPoint: proj.point,
          distanceFromStart: distFromStart,
        );
        filtered.add(trackable);
        debugPrint(trackable.toString());
      }
    }

    setState(() {
      _trackablePotholes = filtered;
      _potholeMarkers = {
        for (final p in filtered)
          p.id: Marker(
            markerId: MarkerId(p.id),
            position: p.position,
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          ),
      };
    });
  }

  Future<void> _onUserLocationChanged(LatLng location) async {
    setState(() => _currentLocation = location);
    _mapController?.animateCamera(CameraUpdate.newLatLng(location));

    if (_routePolyline.isEmpty) return;

    final projection = _projectOnPolyline(location, _routePolyline);
    final userDist =
        _getDistanceAlongPolyline(_routePolyline, projection.index);

    debugPrint("[USER] Pos: $location, DistAlongRoute: $userDist m");

    _checkAndNotifyPothole(userDist);
  }

  void _checkAndNotifyPothole(double userDist) {
    for (final pothole in _trackablePotholes) {
      final distanceToPothole = pothole.distanceFromStart - userDist;

      debugPrint("Checking pothole ${pothole.id} → $distanceToPothole m ahead");

      if (distanceToPothole <= _notificationDistance &&
          distanceToPothole > 0 &&
          !notifiedPotholeIds.contains(pothole.id)) {
        notifiedPotholeIds.add(pothole.id);
        _showPotholeNotification(distanceToPothole.round(), pothole.id);
      }
    }
  }

  Future<void> _showPotholeNotification(int distance, String id) async {
    setState(() {
      _showPopup = true;
      _popupDistance = distance;
    });

    await flutterLocalNotificationsPlugin.show(
      0,
      'Pothole Alert 🚨',
      '$distance meters ahead!',
      const NotificationDetails(
        android: AndroidNotificationDetails('channel_id', 'Pothole Alerts',
            importance: Importance.max, priority: Priority.high),
      ),
    );

    await Future.delayed(const Duration(seconds: 6));
    setState(() => _showPopup = false);
  }

  Future<List<LatLng>> _getRoutePolyline({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final result = await PolylinePoints().getRouteBetweenCoordinates(
      request: PolylineRequest(
        origin: PointLatLng(origin.latitude, origin.longitude),
        destination: PointLatLng(destination.latitude, destination.longitude),
        mode: TravelMode.driving, // 🚨 Add this line
      ),
      googleApiKey: _googleMapsApiKey,
    );

    return result.points.map((p) => LatLng(p.latitude, p.longitude)).toList();
  }

  double _haversineDistance(LatLng a, LatLng b) {
    const R = 6371000; // Earth radius in meters
    final dLat = _degToRad(b.latitude - a.latitude);
    final dLon = _degToRad(b.longitude - a.longitude);
    final lat1 = _degToRad(a.latitude);
    final lat2 = _degToRad(b.latitude);

    final aCalc = sin(dLat / 2) * sin(dLat / 2) +
        sin(dLon / 2) * sin(dLon / 2) * cos(lat1) * cos(lat2);
    final c = 2 * atan2(sqrt(aCalc), sqrt(1 - aCalc));

    return R * c;
  }

  double _vincentyDistance(LatLng a, LatLng b) {
    const double aEarth = 6378137.0; // semi-major axis (meters)
    const double f = 1 / 298.257223563; // flattening
    const double bEarth = (1 - f) * aEarth;

    final phi1 = _degToRad(a.latitude);
    final phi2 = _degToRad(b.latitude);
    final U1 = atan((1 - f) * tan(phi1));
    final U2 = atan((1 - f) * tan(phi2));
    final L = _degToRad(b.longitude - a.longitude);

    double lambda = L;
    double lambdaPrev;
    int iterLimit = 100;
    double cos2SigmaM, sinSigma, cosSigma, sigma;
    double sinLambda, cosLambda;

    do {
      sinLambda = sin(lambda);
      cosLambda = cos(lambda);
      final sinU1 = sin(U1), cosU1 = cos(U1);
      final sinU2 = sin(U2), cosU2 = cos(U2);
      final sinSq = pow(cosU2 * sinLambda, 2) +
          pow(cosU1 * sinU2 - sinU1 * cosU2 * cosLambda, 2);
      sinSigma = sqrt(sinSq);
      cosSigma = sinU1 * sinU2 + cosU1 * cosU2 * cosLambda;
      sigma = atan2(sinSigma, cosSigma);
      final sinAlpha = cosU1 * cosU2 * sinLambda / sinSigma;
      final cosSqAlpha = 1 - sinAlpha * sinAlpha;
      cos2SigmaM = cosSigma - 2 * sinU1 * sinU2 / cosSqAlpha;

      final C = f / 16 * cosSqAlpha * (4 + f * (4 - 3 * cosSqAlpha));
      lambdaPrev = lambda;
      lambda = L +
          (1 - C) *
              f *
              sinAlpha *
              (sigma +
                  C *
                      sinSigma *
                      (cos2SigmaM +
                          C * cosSigma * (-1 + 2 * cos2SigmaM * cos2SigmaM)));
    } while ((lambda - lambdaPrev).abs() > 1e-12 && --iterLimit > 0);

    if (iterLimit == 0) return _haversineDistance(a, b); // fallback

    final uSq =
        cos2SigmaM * (aEarth * aEarth - bEarth * bEarth) / (bEarth * bEarth);
    final A = 1 + uSq / 16384 * (4096 + uSq * (-768 + uSq * (320 - 175 * uSq)));
    final B = uSq / 1024 * (256 + uSq * (-128 + uSq * (74 - 47 * uSq)));
    final deltaSigma = B *
        sinSigma *
        (cos2SigmaM +
            B /
                4 *
                (cosSigma * (-1 + 2 * cos2SigmaM * cos2SigmaM) -
                    B /
                        6 *
                        cos2SigmaM *
                        (-3 + 4 * sinSigma * sinSigma) *
                        (-3 + 4 * cos2SigmaM * cos2SigmaM)));

    final s = bEarth * A * (sigma - deltaSigma);

    return s; // Distance in meters
  }

  double _degToRad(double deg) => deg * pi / 180;

  ProjectionResult _projectOnPolyline(LatLng point, List<LatLng> polyline) {
    double minDist = double.infinity;
    int index = 0;
    LatLng closest = polyline.first;

    for (int i = 0; i < polyline.length - 1; i++) {
      final proj = _projectPointOnSegment(point, polyline[i], polyline[i + 1]);
      final dist = _calculateDistance(point, proj);
      if (dist < minDist) {
        minDist = dist;
        index = i;
        closest = proj;
      }
    }

    return ProjectionResult(closest, index);
  }

  LatLng _projectPointOnSegment(LatLng p, LatLng a, LatLng b) {
    final dx = b.longitude - a.longitude;
    final dy = b.latitude - a.latitude;
    if (dx == 0 && dy == 0) return a;

    final t =
        ((p.longitude - a.longitude) * dx + (p.latitude - a.latitude) * dy) /
            (dx * dx + dy * dy);
    if (t < 0) return a;
    if (t > 1) return b;
    return LatLng(a.latitude + t * dy, a.longitude + t * dx);
  }

  double _getDistanceAlongPolyline(List<LatLng> polyline, int upToIndex) {
    double distance = 0;
    for (int i = 0; i < upToIndex; i++) {
      distance += _calculateDistance(polyline[i], polyline[i + 1]);
    }
    return distance;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NearbyPotholeBloc, NearbyPotholeState>(
      bloc: nearbyPotholeBloc,
      listener: (context, state) {
        if (state.status.isSuccess) {
          _rebuildRouteAndPotholes();
        } else {
          debugPrint("Error loading potholes: ${state.failure?.message}");
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Pothole Navigator')),
        body: _currentLocation == null
            ? const Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  GoogleMap(
                    style: _mapStyle,
                    onMapCreated: (c) => _mapController = c,
                    initialCameraPosition: CameraPosition(
                      target: _currentLocation!,
                      zoom: 15,
                    ),
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    onTap: (pos) => _setDestination(pos),
                    markers: {
                      if (_destination != null)
                        Marker(
                            markerId: const MarkerId('destination'),
                            position: _destination!),
                      ..._potholeMarkers.values,
                    },
                    polylines: {
                      if (_routePolyline.isNotEmpty)
                        Polyline(
                          polylineId: const PolylineId('route'),
                          points: _routePolyline,
                          width: 8,
                          color: Colors.indigo,
                          jointType: JointType.round,
                          startCap: Cap.roundCap,
                          endCap: Cap.roundCap,
                        )
                    },
                  ),
                  if (_showPopup && _popupDistance != null)
                    Positioned(
                      top: 80,
                      left: 20,
                      right: 20,
                      child: Material(
                        elevation: 8,
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              const Icon(Icons.warning, color: Colors.white),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  '⚠️ Pothole $_popupDistance meters ahead!',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
      ),
    );
  }

  void _setDestination(LatLng destination) async {
    setState(() => _destination = destination);
    await _rebuildRouteAndPotholes();
  }
}
