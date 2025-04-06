// import 'dart:async';
// import 'dart:convert';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:http/http.dart' as http;
// import 'package:location/location.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';

// import 'package:road_app/app/__app.dart';
// import 'package:road_app/cores/__cores.dart';
// import 'package:road_app/features/road_app/presentation/_presentation.dart';

// class TrackablePothole {
//   final String id;
//   final LatLng position;
//   final LatLng projectedPoint;
//   final double distanceFromStart;
//   bool notified;

//   TrackablePothole({
//     required this.id,
//     required this.position,
//     required this.projectedPoint,
//     required this.distanceFromStart,
//     this.notified = false,
//   });
// }

// class ProjectionResult {
//   final LatLng point;
//   final int index;

//   ProjectionResult(this.point, this.index);
// }

// class MapScreen extends StatefulWidget {
//   final LatLng? destination;
//   final String? destinationAddress;

//   const MapScreen({Key? key, this.destination, this.destinationAddress})
//       : super(key: key);

//   @override
//   State<MapScreen> createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   GoogleMapController? _mapController;
//   final NearbyPotholeBloc nearbyPotholeBloc = getIt<NearbyPotholeBloc>();
//   final NearbyPotholeCubit nearbyPotholeCubit = getIt<NearbyPotholeCubit>();
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//   final String _googleMapsApiKey = AppConstants.googleApiKey;

//   LatLng? _currentLocation;
//   LatLng? _destination;
//   List<LatLng> _routePolyline = [];

//   List<TrackablePothole> _trackablePotholes = [];
//   Set<String> _notifiedPotholeIds = {};
//   Map<String, Marker> _potholeMarkers = {};
//   TrackablePothole? _activePotholeTracker;
//   Timer? _notificationLoopTimer;

//   int? _popupDistance;
//   bool _showPopup = false;

//   static const double _notificationDistance = 200.0;

//   @override
//   void initState() {
//     super.initState();
//     _initializeNotifications();
//     if (widget.destination != null) _destination = widget.destination;
//     _initLocationTracking();
//     _startPotholePolling();
//   }

//   Future<void> _initializeNotifications() async {
//     const androidSettings = AndroidInitializationSettings('ic_launcher');
//     const initSettings = InitializationSettings(android: androidSettings);
//     await flutterLocalNotificationsPlugin.initialize(initSettings);
//   }

//   void _startPotholePolling() {
//     final location = Location();
//     Timer.periodic(const Duration(seconds: 30), (timer) async {
//       try {
//         final loc = await location.getLocation();
//         nearbyPotholeCubit.updateLatLng(
//           RequiredNum.dirty(loc.latitude!),
//           RequiredNum.dirty(loc.longitude!),
//         );
//         nearbyPotholeBloc.add(FetchNearbyPotholes(nearbyPotholeCubit.state));
//       } catch (e) {
//         debugPrint('Polling error: $e');
//       }
//     });
//   }

//   Future<void> _initLocationTracking() async {
//     final location = Location();
//     if (!await location.serviceEnabled()) {
//       if (!await location.requestService()) return;
//     }
//     if (await location.hasPermission() == PermissionStatus.denied) {
//       if (await location.requestPermission() != PermissionStatus.granted)
//         return;
//     }

//     final loc = await location.getLocation();
//     _currentLocation = LatLng(loc.latitude!, loc.longitude!);
//     if (_currentLocation != null && _destination != null) {
//       await _rebuildRouteAndPotholes();
//     }

//     location.onLocationChanged.listen((loc) async {
//       final userLoc = LatLng(loc.latitude!, loc.longitude!);
//       await _updateUserLocation(userLoc);
//     });
//   }

//   Future<void> _rebuildRouteAndPotholes() async {
//     if (_currentLocation == null || _destination == null) return;

//     _routePolyline = await _getRoutePolyline(
//       origin: _currentLocation!,
//       destination: _destination!,
//     );

//     final fetched = nearbyPotholeBloc.state.potholes;
//     final List<TrackablePothole> filtered = [];

//     for (final pothole in fetched) {
//       final LatLng latLng = LatLng(
//         pothole.geometry.coordinates.last,
//         pothole.geometry.coordinates.first,
//       );

//       final projection = _projectOnPolyline(latLng, _routePolyline);
//       final distanceFromPath = _calculateDistance(latLng, projection.point);

//       if (distanceFromPath <= 30) {
//         final distFromStart =
//             _getDistanceAlongPolyline(_routePolyline, projection.index);
//         filtered.add(TrackablePothole(
//           id: pothole.id.toString(),
//           position: latLng,
//           projectedPoint: projection.point,
//           distanceFromStart: distFromStart,
//         ));
//       }
//     }

//     _trackablePotholes = filtered;
//     _activePotholeTracker = null;

//     _potholeMarkers.clear();
//     for (var pothole in _trackablePotholes) {
//       _potholeMarkers[pothole.id] = Marker(
//         markerId: MarkerId(pothole.id),
//         position: pothole.position,
//         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
//         infoWindow: const InfoWindow(title: "Pothole Detected"),
//       );
//     }

//     setState(() {});
//   }

//   Future<void> _updateUserLocation(LatLng userLocation) async {
//     setState(() => _currentLocation = userLocation);
//     _mapController?.animateCamera(CameraUpdate.newLatLng(_currentLocation!));

//     if (_routePolyline.isEmpty || _destination == null) return;

//     final proj = _projectOnPolyline(userLocation, _routePolyline);
//     final dist = _calculateDistance(userLocation, proj.point);

//     if (dist > 50) {
//       await _rebuildRouteAndPotholes();
//     } else {
//       checkAndNotifyNextPothole(userLocation);
//     }
//   }

//   void checkAndNotifyNextPothole(LatLng userLocation) {
//     final userProj = _projectOnPolyline(userLocation, _routePolyline);
//     final userDist = _getDistanceAlongPolyline(_routePolyline, userProj.index);

//     if (_activePotholeTracker != null) {
//       if (userDist > _activePotholeTracker!.distanceFromStart + 50) {
//         _notificationLoopTimer?.cancel();
//         _notificationLoopTimer = null;
//         setState(() {
//           _showPopup = false;
//           _popupDistance = null;
//           _activePotholeTracker = null;
//         });
//       }
//       return;
//     }

//     for (final pothole in _trackablePotholes) {
//       if (pothole.notified) continue;

//       final distToPothole = pothole.distanceFromStart - userDist;
//       if (distToPothole > 0 && distToPothole <= _notificationDistance) {
//         pothole.notified = true;
//         _notifiedPotholeIds.add(pothole.id);
//         setState(() => _activePotholeTracker = pothole);

//         _notificationLoopTimer = Timer.periodic(
//           const Duration(seconds: 5),
//           (timer) {
//             final currentDist = pothole.distanceFromStart -
//                 _getDistanceAlongPolyline(_routePolyline, userProj.index);
//             if (currentDist > 0 && currentDist <= _notificationDistance) {
//               _showLocalNotification(
//                 currentDist.round(),
//                 "Pothole Ahead",
//                 "You’re ${currentDist.round()}m from a pothole!",
//               );
//             }
//           },
//         );

//         break;
//       }
//     }
//   }

//   Future<void> _showLocalNotification(
//       int distance, String title, String body) async {
//     setState(() {
//       _popupDistance = distance;
//       _showPopup = true;
//     });

//     const androidDetails = AndroidNotificationDetails(
//       'pothole_alert_channel',
//       'Pothole Alerts',
//       channelDescription: 'Alerts about upcoming potholes',
//       importance: Importance.max,
//       priority: Priority.high,
//       ongoing: true,
//       autoCancel: false,
//     );

//     const platformDetails = NotificationDetails(android: androidDetails);
//     await flutterLocalNotificationsPlugin.show(
//         999, title, body, platformDetails);
//   }

//   Future<List<LatLng>> _getRoutePolyline(
//       {required LatLng origin, required LatLng destination}) async {
//     final url = Uri.parse(
//       'https://maps.googleapis.com/maps/api/directions/json?origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&mode=driving&key=$_googleMapsApiKey',
//     );
//     final response = await http.get(url);
//     final data = json.decode(response.body);
//     final encoded = data['routes'][0]['overview_polyline']['points'];
//     return PolylinePoints()
//         .decodePolyline(encoded)
//         .map((e) => LatLng(e.latitude, e.longitude))
//         .toList();
//   }

//   double _calculateDistance(LatLng a, LatLng b) {
//     const R = 6371000;
//     final dLat = _degToRad(b.latitude - a.latitude);
//     final dLon = _degToRad(b.longitude - a.longitude);
//     final lat1 = _degToRad(a.latitude);
//     final lat2 = _degToRad(b.latitude);
//     final aCalc = sin(dLat / 2) * sin(dLat / 2) +
//         sin(dLon / 2) * sin(dLon / 2) * cos(lat1) * cos(lat2);
//     final c = 2 * atan2(sqrt(aCalc), sqrt(1 - aCalc));
//     return R * c;
//   }

//   double _degToRad(double deg) => deg * pi / 180;

//   ProjectionResult _projectOnPolyline(LatLng point, List<LatLng> polyline) {
//     double minDist = double.infinity;
//     int index = 0;
//     LatLng closest = polyline.first;
//     for (int i = 0; i < polyline.length - 1; i++) {
//       final p = _projectPointOnSegment(point, polyline[i], polyline[i + 1]);
//       final dist = _calculateDistance(point, p);
//       if (dist < minDist) {
//         minDist = dist;
//         index = i;
//         closest = p;
//       }
//     }
//     return ProjectionResult(closest, index);
//   }

//   LatLng _projectPointOnSegment(LatLng p, LatLng a, LatLng b) {
//     final dx = b.longitude - a.longitude;
//     final dy = b.latitude - a.latitude;
//     if (dx == 0 && dy == 0) return a;
//     final t =
//         ((p.longitude - a.longitude) * dx + (p.latitude - a.latitude) * dy) /
//             (dx * dx + dy * dy);
//     if (t < 0) return a;
//     if (t > 1) return b;
//     return LatLng(a.latitude + t * dy, a.longitude + t * dx);
//   }

//   double _getDistanceAlongPolyline(List<LatLng> polyline, int upToIndex) {
//     double distance = 0;
//     for (int i = 0; i < upToIndex; i++) {
//       distance += _calculateDistance(polyline[i], polyline[i + 1]);
//     }
//     return distance;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<NearbyPotholeBloc, NearbyPotholeState>(
//       bloc: nearbyPotholeBloc,
//       listener: (context, state) async {
//         if (state.status.isSuccess) {
//           await _rebuildRouteAndPotholes();
//         } else {
//           debugPrint("Failed to fetch potholes: ${state.failure?.message}");
//         }
//       },
//       child: Scaffold(
//         appBar: AppBar(title: const Text('Route and Pothole Detection')),
//         body: _currentLocation == null
//             ? const Center(child: CircularProgressIndicator())
//             : Stack(
//                 children: [
//                   GoogleMap(
//                     initialCameraPosition:
//                         CameraPosition(target: _currentLocation!, zoom: 15),
//                     onMapCreated: (controller) => _mapController = controller,
//                     myLocationEnabled: true,
//                     myLocationButtonEnabled: true,
//                     onTap: (pos) => _setDestination(pos),
//                     markers: {
//                       if (_destination != null)
//                         Marker(
//                             markerId: const MarkerId('destination'),
//                             position: _destination!),
//                       ..._potholeMarkers.values,
//                     },
//                     polylines: {
//                       if (_routePolyline.isNotEmpty)
//                         Polyline(
//                           polylineId: const PolylineId('route'),
//                           points: _routePolyline,
//                           width: 5,
//                           color: Colors.blue,
//                         ),
//                     },
//                   ),
//                   if (_showPopup && _popupDistance != null)
//                     Positioned(
//                       top: 80,
//                       left: 20,
//                       right: 20,
//                       child: Material(
//                         elevation: 8,
//                         borderRadius: BorderRadius.circular(12),
//                         color: Colors.red,
//                         child: Padding(
//                           padding: const EdgeInsets.all(16),
//                           child: Row(
//                             children: [
//                               const Icon(Icons.warning, color: Colors.white),
//                               const SizedBox(width: 10),
//                               Expanded(
//                                 child: Text(
//                                   '⚠️ Pothole $_popupDistance meters ahead!',
//                                   style: const TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//       ),
//     );
//   }

//   void _setDestination(LatLng destination) async {
//     _destination = destination;
//     await _rebuildRouteAndPotholes();
//   }
// }
