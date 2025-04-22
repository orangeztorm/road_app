// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart' as google;
// import 'package:permission_handler/permission_handler.dart';
// import 'package:http/http.dart' as http;
// import 'package:location/location.dart';
// import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
// import 'package:turf/turf.dart' as turf;
// import 'package:road_app/app/__app.dart';
// import 'package:road_app/cores/__cores.dart';
// import 'package:road_app/features/road_app/presentation/_presentation.dart';

// const String _mapboxStyle =
//     'mapbox://styles/roadapp2025/cm9odqm4j003o01qr285hdeyv';
// const String _directionsUrl =
//     'https://api.mapbox.com/directions/v5/mapbox/driving';
// const String _mapboxToken = AppConstants.mapBoxToken;

// class MapboxPotholeScreen extends StatefulWidget {
//   final google.LatLng? destination;
//   const MapboxPotholeScreen({super.key, this.destination});

//   @override
//   State<MapboxPotholeScreen> createState() => _MapboxPotholeScreenState();
// }

// class _MapboxPotholeScreenState extends State<MapboxPotholeScreen> {
//   MapboxMap? _mapboxMap;
//   PointAnnotationManager? _annotationManager;
//   final Location _location = Location();
//   google.LatLng? _currentLocation;
//   google.LatLng? _destination;
//   Timer? _trackingTimer;
//   static const double _alertDistance = 200.0;
//   final Set<String> _notifiedPotholeIds = {};
//   final List<String> _instructions = [];

//   final nearbyPotholeBloc = getIt<NearbyPotholeBloc>();
//   final nearbyPotholeCubit = getIt<NearbyPotholeCubit>();

//   @override
//   void initState() {
//     super.initState();
//     _destination = widget.destination;
//     _initializeLocation();
//   }

//   Future<void> _initializeLocation() async {
//     if (!await _location.serviceEnabled() &&
//         !await _location.requestService()) {
//       return;
//     }
//     final loc = await _location.getLocation();
//     setState(() {
//       _currentLocation = google.LatLng(loc.latitude!, loc.longitude!);
//     });

//     nearbyPotholeCubit.updateLatLng(
//       RequiredNum.dirty(loc.latitude!),
//       RequiredNum.dirty(loc.longitude!),
//     );
//     nearbyPotholeBloc.add(FetchNearbyPotholes(nearbyPotholeCubit.state));

//     _startLiveTracking();
//   }

//   Future<Uint8List> _loadPng(String assetPath) async {
//     final data = await rootBundle.load(assetPath);
//     return data.buffer.asUint8List();
//   }

//   Future<void> _onMapCreated(MapboxMap mapboxMap) async {
//     _mapboxMap = mapboxMap;

//     // enable the user puck
//     if (await Permission.locationWhenInUse.request().isGranted) {
//       await mapboxMap.location.updateSettings(
//         LocationComponentSettings(enabled: true, pulsingEnabled: true),
//       );
//     }

//     // set up annotation manager for markers
//     _annotationManager =
//         await mapboxMap.annotations.createPointAnnotationManager();

//     // center on current location if available
//     if (_currentLocation != null) {
//       await mapboxMap.flyTo(
//         CameraOptions(
//           center: Point(
//             coordinates: Position(
//               _currentLocation!.longitude,
//               _currentLocation!.latitude,
//             ),
//           ),
//           zoom: 14.5,
//         ),
//         MapAnimationOptions(duration: 800),
//       );
//     }
//   }

//   /// Called once the style is fully loaded — use this to add your route line
//   Future<void> _onStyleLoaded(StyleLoadedEventData _) async {
//     if (_currentLocation == null || _destination == null) return;

//     // 1. Fetch the route GeoJSON from Mapbox Directions API
//     final url = Uri.parse(
//       '$_directionsUrl/'
//       '${_currentLocation!.longitude},${_currentLocation!.latitude};'
//       '${_destination!.longitude},${_destination!.latitude}'
//       '?geometries=geojson&steps=true&access_token=$_mapboxToken',
//     );
//     final res = await http.get(url);
//     final body = json.decode(res.body);
//     final coords = body['routes'][0]['geometry']['coordinates'];

//     // 2. Build a FeatureCollection around the LineString
//     final featureCollection = {
//       "type": "FeatureCollection",
//       "features": [
//         {
//           "type": "Feature",
//           "geometry": {
//             "type": "LineString",
//             "coordinates": coords,
//           }
//         }
//       ]
//     };
//     final geojsonString = json.encode(featureCollection);

//     // 3. Add source & layer to the map style
//     await _mapboxMap!.style.addSource(
//       GeoJsonSource(id: "route-src", data: geojsonString),
//     );

//     await _mapboxMap!.style.addLayer(
//       LineLayer(
//         id: "route-layer",
//         sourceId: "route-src",
//         lineColor: Colors.orange.value,
//         lineWidth: 5.0,
//         lineOpacity: 0.5,
//       ),
//     );

//     // 4. Now add your destination icon and step instructions
//     await _addDestinationMarker();
//     _instructions.clear();
//     final steps = body['routes'][0]['legs'][0]['steps'] as List;
//     for (final step in steps) {
//       _instructions.add(step['maneuver']['instruction']);
//     }

//     // 5. Finally render any fetched pothole markers
//     _renderFetchedPotholes();
//   }

//   Future<void> _addDestinationMarker() async {
//     if (_destination == null) return;
//     final data = await _loadPng('assets/destination.png');
//     await _annotationManager?.create(
//       PointAnnotationOptions(
//         geometry: Point(
//           coordinates:
//               Position(_destination!.longitude, _destination!.latitude),
//         ),
//         image: data,
//         iconSize: 1.5,
//       ),
//     );
//   }

//   void _renderFetchedPotholes() async {
//     final iconData = await _loadPng('assets/r_pot.png');
//     final potholes = nearbyPotholeBloc.state.potholes;
//     await _annotationManager?.deleteAll();

//     for (final p in potholes) {
//       final lon = p.geometry.coordinates[0];
//       final lat = p.geometry.coordinates[1];
//       await _annotationManager?.create(
//         PointAnnotationOptions(
//           geometry: Point(coordinates: Position(lon, lat)),
//           image: iconData,
//           iconSize: 0.075,
//           iconOffset: [0.0, 50.0],
//         ),
//       );
//     }
//   }

//   void _startLiveTracking() {
//     _trackingTimer = Timer.periodic(const Duration(seconds: 5), (_) async {
//       final loc = await _location.getLocation();
//       final userPos = google.LatLng(loc.latitude!, loc.longitude!);

//       // pan camera
//       await _mapboxMap?.flyTo(
//         CameraOptions(
//           center: Point(
//             coordinates: Position(userPos.longitude, userPos.latitude),
//           ),
//           zoom: 14.5,
//         ),
//         MapAnimationOptions(duration: 600),
//       );

//       _checkProximityToPotholes(userPos);
//     });
//   }

//   void _checkProximityToPotholes(google.LatLng userLoc) {
//     final userPt = turf.Point(
//       coordinates: turf.Position(userLoc.longitude, userLoc.latitude),
//     );
//     for (final p in nearbyPotholeBloc.state.potholes) {
//       if (_notifiedPotholeIds.contains(p.id)) continue;
//       final pPt = turf.Point(
//         coordinates:
//             turf.Position(p.geometry.coordinates[0], p.geometry.coordinates[1]),
//       );
//       final dist = turf.distance(userPt, pPt, turf.Unit.meters);
//       if (dist <= _alertDistance) {
//         _notifiedPotholeIds.add(p.id);
//         _showInAppAlert(dist.toInt(), p.id);
//       }
//     }
//   }

//   void _showInAppAlert(int distance, String potholeId) {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text("⚠️ Pothole Alert"),
//         content: Text("Pothole $potholeId is $distance meters ahead!"),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text("Dismiss"),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _trackingTimer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<NearbyPotholeBloc, NearbyPotholeState>(
//       bloc: nearbyPotholeBloc,
//       listener: (_, state) {
//         if (state.status.isSuccess) {
//           _renderFetchedPotholes();
//         }
//       },
//       child: Scaffold(
//         appBar: AppBar(title: const Text('Mapbox Pothole Navigator')),
//         body: _currentLocation == null
//             ? const Center(child: CircularProgressIndicator())
//             : Column(
//                 children: [
//                   Expanded(
//                     child: MapWidget(
//                       key: const ValueKey("mapWidget"),
//                       styleUri: _mapboxStyle,
//                       textureView: true,
//                       cameraOptions: CameraOptions(
//                         center: Point(
//                           coordinates: Position(
//                             _currentLocation!.longitude,
//                             _currentLocation!.latitude,
//                           ),
//                         ),
//                         zoom: 14.0,
//                       ),
//                       onMapCreated: _onMapCreated,
//                       onStyleLoadedListener: _onStyleLoaded,
//                     ),
//                   ),
//                   Container(
//                     padding: const EdgeInsets.all(12),
//                     color: Colors.white,
//                     height: 120,
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: _instructions.length,
//                       itemBuilder: (_, idx) => Container(
//                         margin: const EdgeInsets.symmetric(horizontal: 8),
//                         padding: const EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                           color: Colors.blue[50],
//                           borderRadius: BorderRadius.circular(8),
//                           border: Border.all(color: Colors.blueAccent),
//                         ),
//                         child: Center(
//                           child: Text(
//                             _instructions[idx],
//                             style: const TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () async {
//             final loc = await _location.getLocation();
//             await _mapboxMap?.flyTo(
//               CameraOptions(
//                 center: Point(
//                   coordinates: Position(loc.longitude!, loc.latitude!),
//                 ),
//                 zoom: 14.5,
//               ),
//               MapAnimationOptions(duration: 600),
//             );
//           },
//           child: const Icon(Icons.my_location),
//         ),
//       ),
//     );
//   }
// }

// 2

// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart' as google;
// import 'package:permission_handler/permission_handler.dart';
// import 'package:http/http.dart' as http;
// import 'package:location/location.dart';
// import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:turf/turf.dart' as turf;
// import 'package:road_app/app/__app.dart';
// import 'package:road_app/cores/__cores.dart';
// import 'package:road_app/features/road_app/presentation/_presentation.dart';

// const String _mapboxStyle =
//     'mapbox://styles/roadapp2025/cm9odqm4j003o01qr285hdeyv';
// const String _directionsUrl =
//     'https://api.mapbox.com/directions/v5/mapbox/driving';
// const String _mapboxToken = AppConstants.mapBoxToken;

// class MapboxPotholeScreen extends StatefulWidget {
//   final google.LatLng? destination;
//   const MapboxPotholeScreen({super.key, this.destination});

//   @override
//   State<MapboxPotholeScreen> createState() => _MapboxPotholeScreenState();
// }

// class _MapboxPotholeScreenState extends State<MapboxPotholeScreen> {
//   MapboxMap? _mapboxMap;
//   PointAnnotationManager? _annotationManager;
//   final Location _location = Location();
//   google.LatLng? _currentLocation;
//   google.LatLng? _destination;
//   Timer? _trackingTimer;
//   static const double _alertDistance = 300.0;
//   final Set<String> _notifiedPotholeIds = {};
//   final List<String> _instructions = [];

//   // Local notifications
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//   bool _showPopup = false;
//   int _popupDistance = 0;

//   final nearbyPotholeBloc = getIt<NearbyPotholeBloc>();
//   final nearbyPotholeCubit = getIt<NearbyPotholeCubit>();

//   @override
//   void initState() {
//     super.initState();
//     _destination = widget.destination;
//     _initializeLocation();

//     // Initialize local notifications plugin
//     const androidInitSettings =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     flutterLocalNotificationsPlugin.initialize(
//       const InitializationSettings(android: androidInitSettings),
//     );
//   }

//   Future<void> _initializeLocation() async {
//     if (!await _location.serviceEnabled() &&
//         !await _location.requestService()) {
//       return;
//     }
//     final loc = await _location.getLocation();
//     setState(() {
//       _currentLocation = google.LatLng(loc.latitude!, loc.longitude!);
//     });

//     nearbyPotholeCubit.updateLatLng(
//       RequiredNum.dirty(loc.latitude!),
//       RequiredNum.dirty(loc.longitude!),
//     );
//     nearbyPotholeBloc.add(FetchNearbyPotholes(nearbyPotholeCubit.state));

//     _startLiveTracking();
//   }

//   Future<Uint8List> _loadPng(String assetPath) async {
//     final data = await rootBundle.load(assetPath);
//     return data.buffer.asUint8List();
//   }

//   Future<void> _onMapCreated(MapboxMap mapboxMap) async {
//     _mapboxMap = mapboxMap;

//     if (await Permission.locationWhenInUse.request().isGranted) {
//       await mapboxMap.location.updateSettings(
//         LocationComponentSettings(enabled: true, pulsingEnabled: true),
//       );
//     }

//     _annotationManager =
//         await mapboxMap.annotations.createPointAnnotationManager();

//     if (_currentLocation != null) {
//       await mapboxMap.flyTo(
//         CameraOptions(
//           center: Point(
//             coordinates: Position(
//               _currentLocation!.longitude,
//               _currentLocation!.latitude,
//             ),
//           ),
//           zoom: 14.5,
//         ),
//         MapAnimationOptions(duration: 800),
//       );
//     }
//   }

//   Future<void> _onStyleLoaded(StyleLoadedEventData _) async {
//     if (_currentLocation == null || _destination == null) return;

//     final url = Uri.parse(
//       '$_directionsUrl/'
//       '${_currentLocation!.longitude},${_currentLocation!.latitude};'
//       '${_destination!.longitude},${_destination!.latitude}'
//       '?geometries=geojson&steps=true&access_token=$_mapboxToken',
//     );
//     final res = await http.get(url);
//     final body = json.decode(res.body);
//     final coords = body['routes'][0]['geometry']['coordinates'];

//     final featureCollection = {
//       "type": "FeatureCollection",
//       "features": [
//         {
//           "type": "Feature",
//           "geometry": {
//             "type": "LineString",
//             "coordinates": coords,
//           }
//         }
//       ]
//     };
//     final geojsonString = json.encode(featureCollection);

//     await _mapboxMap!.style.addSource(
//       GeoJsonSource(id: "route-src", data: geojsonString),
//     );
//     await _mapboxMap!.style.addLayer(
//       LineLayer(
//         id: "route-layer",
//         sourceId: "route-src",
//         lineColor: Colors.orange.value,
//         lineWidth: 5.0,
//         lineOpacity: 0.5,
//       ),
//     );

//     await _addDestinationMarker();
//     _instructions.clear();
//     final steps = body['routes'][0]['legs'][0]['steps'] as List;
//     setState(() {});
//     for (final step in steps) {
//       _instructions.add(step['maneuver']['instruction']);
//     }

//     _renderFetchedPotholes();
//   }

//   Future<void> _addDestinationMarker() async {
//     if (_destination == null) return;
//     final data = await _loadPng('assets/destination.png');
//     await _annotationManager?.create(
//       PointAnnotationOptions(
//         geometry: Point(
//           coordinates:
//               Position(_destination!.longitude, _destination!.latitude),
//         ),
//         image: data,
//         iconSize: 1.5,
//       ),
//     );
//   }

//   void _renderFetchedPotholes() async {
//     final iconData = await _loadPng('assets/r_pot.png');
//     final potholes = nearbyPotholeBloc.state.potholes;
//     await _annotationManager?.deleteAll();

//     for (final p in potholes) {
//       final lon = p.geometry.coordinates[0];
//       final lat = p.geometry.coordinates[1];
//       await _annotationManager?.create(
//         PointAnnotationOptions(
//           geometry: Point(coordinates: Position(lon, lat)),
//           image: iconData,
//           iconSize: 0.075,
//           iconOffset: [0.0, 50.0],
//         ),
//       );
//     }
//   }

//   void _startLiveTracking() {
//     _trackingTimer = Timer.periodic(const Duration(seconds: 5), (_) async {
//       final loc = await _location.getLocation();
//       final userPos = google.LatLng(loc.latitude!, loc.longitude!);

//       await _mapboxMap?.flyTo(
//         CameraOptions(
//           center: Point(
//             coordinates: Position(userPos.longitude, userPos.latitude),
//           ),
//           zoom: 14.5,
//         ),
//         MapAnimationOptions(duration: 600),
//       );

//       _checkProximityToPotholes(userPos);
//     });
//   }

//   void _checkProximityToPotholes(google.LatLng userLoc) {
//     final userPt = turf.Point(
//       coordinates: turf.Position(userLoc.longitude, userLoc.latitude),
//     );

//     for (final p in nearbyPotholeBloc.state.potholes) {
//       final id = p.id;
//       final pPt = turf.Point(
//         coordinates: turf.Position(
//           p.geometry.coordinates[0],
//           p.geometry.coordinates[1],
//         ),
//       );
//       final dist = turf.distance(userPt, pPt, turf.Unit.meters).toInt();

//       if (dist <= _alertDistance) {
//         if (!_notifiedPotholeIds.contains(id)) {
//           _notifiedPotholeIds.add(id);
//           _showLocalNotification(dist, id);
//         } else {
//           setState(() {
//             _popupDistance = dist;
//           });
//         }
//       } else {
//         if (_notifiedPotholeIds.remove(id)) {
//           _cancelNotification(id);
//         }
//       }
//     }
//   }

//   Future<void> _showLocalNotification(int distance, String potholeId) async {
//     final notificationId = potholeId.hashCode;
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
//       playSound: true,
//     );

//     await flutterLocalNotificationsPlugin.show(
//       notificationId,
//       '⚠️ Pothole Ahead',
//       'Pothole is $distance meters ahead',
//       const NotificationDetails(android: androidDetails),
//       payload: potholeId,
//     );
//   }

//   Future<void> _cancelNotification(String potholeId) async {
//     final notificationId = potholeId.hashCode;
//     await flutterLocalNotificationsPlugin.cancel(notificationId);
//     setState(() {
//       _showPopup = false;
//     });
//   }

//   @override
//   void dispose() {
//     _trackingTimer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<NearbyPotholeBloc, NearbyPotholeState>(
//       bloc: nearbyPotholeBloc,
//       listener: (_, state) {
//         if (state.status.isSuccess) {
//           _renderFetchedPotholes();
//         }
//       },
//       child: Scaffold(
//         appBar: AppBar(title: const Text('Mapbox Pothole Navigator')),
//         body: Stack(
//           children: [
//             if (_currentLocation == null)
//               const Center(child: CircularProgressIndicator())
//             else
//               Column(
//                 children: [
//                   Expanded(
//                     child: MapWidget(
//                       key: const ValueKey("mapWidget"),
//                       styleUri: _mapboxStyle,
//                       textureView: true,
//                       cameraOptions: CameraOptions(
//                         center: Point(
//                           coordinates: Position(
//                             _currentLocation!.longitude,
//                             _currentLocation!.latitude,
//                           ),
//                         ),
//                         zoom: 14.0,
//                       ),
//                       onMapCreated: _onMapCreated,
//                       onStyleLoadedListener: _onStyleLoaded,
//                     ),
//                   ),
//                   Container(
//                     padding: const EdgeInsets.all(12),
//                     color: Colors.white,
//                     height: 120,
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: _instructions.length,
//                       itemBuilder: (_, idx) => Container(
//                         margin: const EdgeInsets.symmetric(horizontal: 8),
//                         padding: const EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                           color: Colors.blue[50],
//                           borderRadius: BorderRadius.circular(8),
//                           border: Border.all(color: Colors.blueAccent),
//                         ),
//                         child: Center(
//                           child: Text(
//                             _instructions[idx],
//                             style: const TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             if (_showPopup)
//               Positioned(
//                 top: 0,
//                 left: 0,
//                 right: 0,
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(vertical: 8),
//                   color: Colors.orangeAccent,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Icon(Icons.warning, color: Colors.white),
//                       const SizedBox(width: 8),
//                       Text(
//                         'Pothole in $_popupDistance m',
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//           ],
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () async {
//             // _showLocalNotification(0, 'test');
//             final loc = await _location.getLocation();
//             await _mapboxMap?.flyTo(
//               CameraOptions(
//                 center: Point(
//                   coordinates: Position(loc.longitude!, loc.latitude!),
//                 ),
//                 zoom: 14.5,
//               ),
//               MapAnimationOptions(duration: 600),
//             );
//           },
//           child: const Icon(Icons.my_location),
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as google;
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:turf/turf.dart' as turf;
import 'package:road_app/app/__app.dart';
import 'package:road_app/cores/__cores.dart';
import 'package:road_app/features/road_app/presentation/_presentation.dart';

const String _mapboxStyle =
    'mapbox://styles/roadapp2025/cm9odqm4j003o01qr285hdeyv';
const String _directionsUrl =
    'https://api.mapbox.com/directions/v5/mapbox/driving';
const String _mapboxToken = AppConstants.mapBoxToken;

/// alert when ≤ this distance (metres)
const int _alertDistance = 300;

/// clear the banner/notification once the pothole is *behind* you
/// and at least this far away (metres)
const int _clearanceMetres = 20;

class MapboxPotholeScreen extends StatefulWidget {
  final google.LatLng? destination;
  const MapboxPotholeScreen({super.key, this.destination});

  @override
  State<MapboxPotholeScreen> createState() => _MapboxPotholeScreenState();
}

class _MapboxPotholeScreenState extends State<MapboxPotholeScreen> {
  MapboxMap? _mapboxMap;
  PointAnnotationManager? _annotationManager;
  final Location _location = Location();
  google.LatLng? _currentLocation;
  google.LatLng? _destination;
  Timer? _trackingTimer;

  final Set<String> _notifiedPotholeIds = {};
  final List<String> _instructions = [];

  // Local notifications
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  bool _showPopup = false;
  int _popupDistance = 0;

  final nearbyPotholeBloc = getIt<NearbyPotholeBloc>();
  final nearbyPotholeCubit = getIt<NearbyPotholeCubit>();

  @override
  void initState() {
    super.initState();
    _destination = widget.destination;
    _initializeLocation();

    // Local‑notification setup
    const androidInitSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(android: androidInitSettings),
    );
  }

  // ───────────────────────── LOCATION INIT ──────────────────────────
  Future<void> _initializeLocation() async {
    if (!await _location.serviceEnabled() &&
        !await _location.requestService()) {
      return;
    }
    final loc = await _location.getLocation();
    setState(() {
      _currentLocation = google.LatLng(loc.latitude!, loc.longitude!);
    });

    nearbyPotholeCubit.updateLatLng(
      RequiredNum.dirty(loc.latitude!),
      RequiredNum.dirty(loc.longitude!),
    );
    nearbyPotholeBloc.add(FetchNearbyPotholes(nearbyPotholeCubit.state));

    _startLiveTracking();
  }

  // ───────────────────────── MAP SETUP ──────────────────────────
  Future<void> _onMapCreated(MapboxMap mapboxMap) async {
    _mapboxMap = mapboxMap;

    if (await Permission.locationWhenInUse.request().isGranted) {
      await mapboxMap.location.updateSettings(
        LocationComponentSettings(enabled: true, pulsingEnabled: true),
      );
    }

    _annotationManager =
        await mapboxMap.annotations.createPointAnnotationManager();

    if (_currentLocation != null) {
      await mapboxMap.flyTo(
        CameraOptions(
          center: Point(
            coordinates: Position(
              _currentLocation!.longitude,
              _currentLocation!.latitude,
            ),
          ),
          zoom: 14.5,
        ),
        MapAnimationOptions(duration: 800),
      );
    }
  }

  Future<void> _onStyleLoaded(StyleLoadedEventData _) async {
    if (_currentLocation == null || _destination == null) return;

    final url = Uri.parse(
      '$_directionsUrl/'
      '${_currentLocation!.longitude},${_currentLocation!.latitude};'
      '${_destination!.longitude},${_destination!.latitude}'
      '?geometries=geojson&steps=true&access_token=$_mapboxToken',
    );
    final res = await http.get(url);
    final body = json.decode(res.body);

    // ─── Route line ───────────────────────────────────────────────
    final coords = body['routes'][0]['geometry']['coordinates'];
    final featureCollection = {
      "type": "FeatureCollection",
      "features": [
        {
          "type": "Feature",
          "geometry": {"type": "LineString", "coordinates": coords}
        }
      ]
    };

    final geojsonString = json.encode(featureCollection);

    await _mapboxMap!.style
        .addSource(GeoJsonSource(id: "route-src", data: geojsonString));
    await _mapboxMap!.style.addLayer(
      LineLayer(
        id: "route-layer",
        sourceId: "route-src",
        lineColor: Colors.orange.value,
        lineWidth: 5.0,
        lineOpacity: 0.5,
      ),
    );

    await _addDestinationMarker();

    // turn‑by‑turn instructions
    _instructions
      ..clear()
      ..addAll(
        (body['routes'][0]['legs'][0]['steps'] as List)
            .map((s) => s['maneuver']['instruction'] as String),
      );
    setState(() {});
    _renderFetchedPotholes();
  }

  // ───────────────────────── MARKERS ──────────────────────────
  Future<Uint8List> _loadPng(String assetPath) async {
    final data = await rootBundle.load(assetPath);
    return data.buffer.asUint8List();
  }

  Future<void> _addDestinationMarker() async {
    if (_destination == null) return;
    final data = await _loadPng('assets/destination.png');
    await _annotationManager?.create(
      PointAnnotationOptions(
        geometry: Point(
            coordinates:
                Position(_destination!.longitude, _destination!.latitude)),
        image: data,
        iconSize: 1.5,
      ),
    );
  }

  void _renderFetchedPotholes() async {
    final iconData = await _loadPng('assets/r_pot.png');
    final potholes = nearbyPotholeBloc.state.potholes;
    await _annotationManager?.deleteAll();

    for (final p in potholes) {
      final lon = p.geometry.coordinates[0];
      final lat = p.geometry.coordinates[1];
      await _annotationManager?.create(
        PointAnnotationOptions(
          geometry: Point(coordinates: Position(lon, lat)),
          image: iconData,
          iconSize: 0.075,
          iconOffset: [0.0, 50.0],
        ),
      );
    }
  }

  // ───────────────────────── LIVE‑TRACKING LOOP ──────────────────────────
  void _startLiveTracking() {
    _trackingTimer = Timer.periodic(const Duration(seconds: 5), (_) async {
      final loc = await _location.getLocation();
      final userPos = google.LatLng(loc.latitude!, loc.longitude!);

      await _mapboxMap?.flyTo(
        CameraOptions(
          center: Point(
            coordinates: Position(userPos.longitude, userPos.latitude),
          ),
          zoom: 14.5,
        ),
        MapAnimationOptions(duration: 600),
      );

      _checkProximityToPotholes(userPos);
    });
  }

  // ───────────────────────── PROXIMITY / ALERT LOGIC ──────────────────────────
  void _checkProximityToPotholes(google.LatLng userLoc) async {
    final userPt = turf.Point(
      coordinates: turf.Position(userLoc.longitude, userLoc.latitude),
    );

    final heading = (await _location.getLocation()).heading ?? 0;

    String? closestId;
    int? closestDist;

    for (final p in nearbyPotholeBloc.state.potholes) {
      final id = p.id;
      final pPt = turf.Point(
        coordinates: turf.Position(
          p.geometry.coordinates[0],
          p.geometry.coordinates[1],
        ),
      );

      final dist = turf.distance(userPt, pPt, turf.Unit.meters).toInt();
      final bearing = turf.bearing(userPt, pPt);
      final angle = (bearing - heading).abs() % 360;
      final isAhead = angle < 90 || angle > 270; // front 180°

      // ── already active notification? ───────────────────────────
      if (_notifiedPotholeIds.contains(id)) {
        final isBehind = !isAhead;
        if (isBehind && dist >= _clearanceMetres) {
          _cancelNotification(id);
          _notifiedPotholeIds.remove(id);
          if (_notifiedPotholeIds.isEmpty && mounted) {
            setState(() => _showPopup = false);
          }
        } else {
          if (mounted) setState(() => _popupDistance = dist);
        }
      }

      // ── candidate for NEW alert ────────────────────────────────
      if (isAhead && dist <= _alertDistance) {
        if (closestDist == null || dist < closestDist) {
          closestDist = dist;
          closestId = id;
        }
      }
    }

    if (closestId != null && !_notifiedPotholeIds.contains(closestId)) {
      _notifiedPotholeIds
        ..clear()
        ..add(closestId);
      _showLocalNotification(closestDist!, closestId);
    }
  }

  Future<void> _showLocalNotification(int distance, String potholeId) async {
    final notificationId = potholeId.hashCode;

    if (mounted) {
      setState(() {
        _popupDistance = distance;
        _showPopup = true;
      });
    }

    const androidDetails = AndroidNotificationDetails(
      'pothole_alert_channel',
      'Pothole Alerts',
      channelDescription: 'Alerts about upcoming potholes',
      importance: Importance.max,
      priority: Priority.high,
      ongoing: true,
      playSound: true,
    );

    await flutterLocalNotificationsPlugin.show(
      notificationId,
      '⚠️ Pothole Ahead',
      'Pothole is $distance m ahead',
      const NotificationDetails(android: androidDetails),
      payload: potholeId,
    );
  }

  Future<void> _cancelNotification(String potholeId) async {
    await flutterLocalNotificationsPlugin.cancel(potholeId.hashCode);
  }

  // ───────────────────────── LIFECYCLE ──────────────────────────
  @override
  void dispose() {
    _trackingTimer?.cancel();
    super.dispose();
  }

  // ───────────────────────── UI ──────────────────────────
  @override
  Widget build(BuildContext context) {
    return BlocListener<NearbyPotholeBloc, NearbyPotholeState>(
      bloc: nearbyPotholeBloc,
      listener: (_, state) {
        if (state.status.isSuccess) _renderFetchedPotholes();
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Mapbox Pothole Navigator')),
        body: Stack(
          children: [
            if (_currentLocation == null)
              const Center(child: CircularProgressIndicator())
            else
              Column(
                children: [
                  Expanded(
                    child: MapWidget(
                      key: const ValueKey("mapWidget"),
                      styleUri: _mapboxStyle,
                      textureView: true,
                      cameraOptions: CameraOptions(
                        center: Point(
                          coordinates: Position(
                            _currentLocation!.longitude,
                            _currentLocation!.latitude,
                          ),
                        ),
                        zoom: 14.0,
                      ),
                      onMapCreated: _onMapCreated,
                      onStyleLoadedListener: _onStyleLoaded,
                    ),
                  ),
                  // ── instruction scroller ───────────────────────
                  Container(
                    padding: const EdgeInsets.all(12),
                    color: Colors.white,
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _instructions.length,
                      itemBuilder: (_, idx) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.blueAccent),
                        ),
                        child: Center(
                          child: Text(
                            _instructions[idx],
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            // ── banner ───────────────────────────────────────
            if (_showPopup)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  color: Colors.orangeAccent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.warning, color: Colors.white),
                      const SizedBox(width: 8),
                      Text(
                        'Pothole in $_popupDistance m',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final loc = await _location.getLocation();
            await _mapboxMap?.flyTo(
              CameraOptions(
                center: Point(
                  coordinates: Position(loc.longitude!, loc.latitude!),
                ),
                zoom: 14.5,
              ),
              MapAnimationOptions(duration: 600),
            );
          },
          child: const Icon(Icons.my_location),
        ),
      ),
    );
  }
}
