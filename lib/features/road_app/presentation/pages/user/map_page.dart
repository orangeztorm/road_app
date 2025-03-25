import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:road_app/app/locator.dart';
import 'package:road_app/cores/__cores.dart';
import 'package:road_app/cores/push_notification/notification_service.dart';
import 'package:road_app/features/__features.dart';

class MapPage extends StatefulWidget {
  static const String routeName = '/map_page';
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with TickerProviderStateMixin {
  String? _currentNotifiedPothole;
  int _notificationId = 1; // Unique notification ID
  final Set<String> _notifiedPotholeIds = {};

  Marker? _lastNotifiedPothole;
  OverlayEntry? _overlayEntry;
  final NotificationService _notificationService = NotificationService();
  final NearbyPotholeBloc nearbyPotholeBloc = getIt<NearbyPotholeBloc>();
  final NearbyPotholeCubit nearbyPotholeCubit = getIt<NearbyPotholeCubit>();
  GoogleMapController? _mapController;
  LatLng? _currentPosition;
  StreamSubscription<LocationData>? _locationSubscription;
  Set<Marker> _markers = {}; // Only fetched potholes will be here
  final double _alertRadius = 350.0;
  late AnimationController _animationController;
  late Animation<double> _animation;
  Location location = Location();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _initializeServices();
    _setupNotifications();
    _initLocation();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  Future<void> _showLivePotholeNotification(int distance) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'pothole_alert_channel',
      'Pothole Alerts',
      importance: Importance.max,
      priority: Priority.high,
      ongoing: true, // Keeps it sticky
      autoCancel: false, // Prevents user from swiping it away
    );

    const NotificationDetails platformDetails =
        NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      _notificationId,
      '🚨 Pothole Alert!',
      'Pothole ahead! ',
      platformDetails,
    );
  }

  /// Function to remove the notification once user moves past
  Future<void> _removeNotification() async {
    await flutterLocalNotificationsPlugin.cancel(_notificationId);
  }

  void _showPopupNotification(int distance) {
    if (_overlayEntry != null) return; // Prevent duplicates

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 150.0,
        left: 10.0,
        right: 10.0,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.warning_amber_rounded, color: Colors.white),
                Expanded(
                  child: Text(
                    '🚧 Pothole ahead!.',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  /// Function to remove the in-app notification
  void _removePopupNotification() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  Future<void> _setupNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _initializeServices() async {
    await _notificationService.initialize();
  }

  Future<void> _initLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }

    location.changeSettings(
      accuracy: LocationAccuracy.high,
      interval: 500,
      distanceFilter: 5,
    );

    LocationData locationData = await location.getLocation();
    _updatePosition(locationData);

    _locationSubscription = location.onLocationChanged.listen(_updatePosition);
  }

  void _updatePosition(LocationData locationData) async {
    LatLng newPosition =
        LatLng(locationData.latitude!, locationData.longitude!);

    if (_currentPosition == null) {
      setState(() {
        _currentPosition = newPosition;
      });
    } else {
      _animateMarker(_currentPosition!, newPosition);

      // Fetch new potholes when user moves significantly
      nearbyPotholeCubit.updateLatLng(RequiredNum.dirty(newPosition.latitude),
          RequiredNum.dirty(newPosition.longitude));
      nearbyPotholeBloc.add(FetchNearbyPotholes(nearbyPotholeCubit.state));
    }

    if (_mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.newLatLng(newPosition),
      );
    }

    _checkForNearbyPotholes(newPosition);
  }

  void _animateMarker(LatLng startPosition, LatLng endPosition) {
    _animationController.reset();

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        final double lat = ui.lerpDouble(
          startPosition.latitude,
          endPosition.latitude,
          _animation.value,
        )!;
        final double lng = ui.lerpDouble(
          startPosition.longitude,
          endPosition.longitude,
          _animation.value,
        )!;

        setState(() {
          _currentPosition = LatLng(lat, lng);
        });
      });

    _animationController.forward();
  }

  Future<bool> _isMovingTowardPothole(LatLng userPos, LatLng potholePos) async {
    double bearingToPothole = _calculateBearing(
      userPos.latitude,
      userPos.longitude,
      potholePos.latitude,
      potholePos.longitude,
    );

    // Get user's movement heading
    LocationData locationData = await location.getLocation();
    double? userBearing = locationData.heading;

    // ✅ If heading is null, estimate movement direction from last position
    if (userBearing == null || userBearing == 0.0) {
      debugPrint("⚠️ Heading is null, estimating direction...");
      if (_currentPosition != null) {
        userBearing = _calculateBearing(
          _currentPosition!.latitude,
          _currentPosition!.longitude,
          userPos.latitude,
          userPos.longitude,
        );
      } else {
        return false; // No valid movement detected
      }
    }

    // ✅ Determine if user is moving toward the pothole
    double angleDifference = (bearingToPothole - userBearing).abs();
    bool isMovingForward = angleDifference < 60;

    debugPrint(
        "📍 Bearing to pothole: $bearingToPothole°, User heading: $userBearing°, Angle diff: $angleDifference°, Moving forward: $isMovingForward");

    return isMovingForward;
  }

  double _calculateBearing(double lat1, double lon1, double lat2, double lon2) {
    double dLon = _degreesToRadians(lon2 - lon1);
    double y = sin(dLon) * cos(_degreesToRadians(lat2));
    double x = cos(_degreesToRadians(lat1)) * sin(_degreesToRadians(lat2)) -
        sin(_degreesToRadians(lat1)) * cos(_degreesToRadians(lat2)) * cos(dLon);
    double bearing = atan2(y, x);
    return (bearing * 180 / pi + 360) % 360;
  }

  double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

  Future<void> _checkForNearbyPotholes(LatLng userPosition) async {
    if (_currentPosition == null || _markers.isEmpty) {
      debugPrint("🚨 No position or markers found.");
      return;
    }

    debugPrint("🔍 Checking for potholes within $_alertRadius meters...");

    // If there's a current pothole, check if it's passed
    if (_currentNotifiedPothole != null) {
      Marker? lastPothole = _markers.firstWhere(
        (m) => m.markerId.value == _currentNotifiedPothole,
        orElse: () => const Marker(markerId: MarkerId('')),
      );

      if (lastPothole.markerId.value.isNotEmpty) {
        double distanceFromLast = _calculateDistance(
          _currentPosition!.latitude,
          _currentPosition!.longitude,
          lastPothole.position.latitude,
          lastPothole.position.longitude,
        );

        if (distanceFromLast > 50) {
          // ✅ User has passed the last pothole, reset it
          debugPrint("✅ Passed last pothole, looking for next...");
          _currentNotifiedPothole = null;
          _removeNotification();
          _removePopupNotification();
        }
      }
    }

    // Find the next pothole in front
    List<Marker> potholesAhead = _markers.where((marker) {
      if (marker.markerId.value == 'userLocation') return false;

      double distance = _calculateDistance(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
        marker.position.latitude,
        marker.position.longitude,
      );

      return distance <= _alertRadius;
    }).toList();

    if (potholesAhead.isNotEmpty) {
      potholesAhead.sort((a, b) {
        double distanceA = _calculateDistance(
          _currentPosition!.latitude,
          _currentPosition!.longitude,
          a.position.latitude,
          a.position.longitude,
        );
        double distanceB = _calculateDistance(
          _currentPosition!.latitude,
          _currentPosition!.longitude,
          b.position.latitude,
          b.position.longitude,
        );
        return distanceA.compareTo(distanceB);
      });

      Marker nearestPothole = potholesAhead.first;
      double nearestDistance = _calculateDistance(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
        nearestPothole.position.latitude,
        nearestPothole.position.longitude,
      );

      if (_currentNotifiedPothole == null && nearestDistance <= 200) {
        debugPrint('🚨 Pothole detected ahead ');
        _showLivePotholeNotification(nearestDistance.round());
        _showPopupNotification(nearestDistance.round());
        _currentNotifiedPothole =
            nearestPothole.markerId.value; // Store pothole ID
      }
    }
  }

  double _calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371000;
    double dLat = _degreesToRadians(lat2 - lat1);
    double dLon = _degreesToRadians(lon2 - lon1);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(lat1)) *
            cos(_degreesToRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c;
  }

  @override
  void dispose() {
    _locationSubscription?.cancel();
    _animationController.dispose();
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pothole Map'),
      ),
      body: _currentPosition == null
          ? const Center(child: CircularProgressIndicator())
          : BlocConsumer<NearbyPotholeBloc, NearbyPotholeState>(
              bloc: nearbyPotholeBloc,
              listener: _nearbyPotholeListener,
              builder: (context, state) {
                return GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _currentPosition!,
                    zoom: 15,
                  ),
                  markers: _markers, // Only potholes from API
                  myLocationEnabled: true, // No need for blue marker
                  myLocationButtonEnabled: true,
                  compassEnabled: true,
                  onMapCreated: (GoogleMapController controller) {
                    setState(() {
                      _mapController = controller;
                    });
                  },
                );
              },
            ),
    );
  }

  void _nearbyPotholeListener(BuildContext context, NearbyPotholeState state) {
    if (state.status.isSuccess) {
      setState(() {
        _markers.clear(); // Overwrite existing markers
        for (var pothole in state.potholes) {
          _markers.add(
            Marker(
              markerId: MarkerId(pothole.id.toString()), // Unique pothole ID
              position: LatLng(pothole.geometry.coordinates.last,
                  pothole.geometry.coordinates.first),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueRed),
              infoWindow: const InfoWindow(title: "Pothole Detected"),
            ),
          );
        }
      });
    }
  }
}
