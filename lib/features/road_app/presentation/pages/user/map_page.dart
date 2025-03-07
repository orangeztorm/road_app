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
  final NotificationService _notificationService = NotificationService();
  final NearbyPotholeBloc nearbyPotholeBloc = getIt<NearbyPotholeBloc>();
  final NearbyPotholeCubit nearbyPotholeCubit = getIt<NearbyPotholeCubit>();
  GoogleMapController? _mapController;
  LatLng? _currentPosition;
  StreamSubscription<LocationData>? _locationSubscription;
  Set<Marker> _markers = {}; // Only fetched potholes will be here
  final double _alertRadius = 50.0;
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
      interval: 1000,
      distanceFilter: 10,
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
      double movementThreshold =
          10.0; // Fetch potholes only if moved by 10m or more
      if (_calculateDistance(
              _currentPosition!.latitude,
              _currentPosition!.longitude,
              newPosition.latitude,
              newPosition.longitude) >
          movementThreshold) {
        _animateMarker(_currentPosition!, newPosition);

        // Fetch new potholes when user moves significantly
        nearbyPotholeCubit.updateLatLng(RequiredNum.dirty(newPosition.latitude),
            RequiredNum.dirty(newPosition.longitude));
        nearbyPotholeBloc.add(FetchNearbyPotholes(nearbyPotholeCubit.state));
      }
    }

    if (_mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.newLatLng(newPosition),
      );
    }

    _checkForNearbyPotholes();
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

  void _checkForNearbyPotholes() {
    if (_currentPosition == null || _markers.isEmpty) return;

    for (Marker marker in _markers) {
      // Skip if it's the user's location marker
      if (marker.markerId.value == 'userLocation') continue;

      double distance = _calculateDistance(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
        marker.position.latitude,
        marker.position.longitude,
      );

      print(
          '🔍 Checking distance to marker ${marker.markerId.value}: ${distance.toStringAsFixed(2)}m');

      if (distance <= _alertRadius) {
        print('⚠️ Alert triggered: Pothole within $_alertRadius meters!');
        _showNotification(
            "🚨 Warning! Pothole detected within $_alertRadius meters.");
        break; // Exit after first alert
      }
    }
  }

  Future<void> _showNotification(String message) async {
    try {
      await _notificationService.showPotholeAlert(
        title: 'Pothole Alert!',
        body: 'Warning: Pothole detecte ahead',
      );
    } catch (e) {
      print(e);
    }

    // Also show in-app notification
    // if (mounted) {
    //   Toast.useContext(
    //     context: context,
    //     message: 'Pothole detected ahead',
    //     type: SnackbarType.info,
    //   );
    // }
    // Toast.useContext(context: context, message: message);
    // const AndroidNotificationDetails androidDetails =
    //     AndroidNotificationDetails(
    //   'pothole_channel',
    //   'Pothole Alerts',
    //   importance: Importance.high,
    //   priority: Priority.high,
    // );

    // const NotificationDetails platformDetails =
    //     NotificationDetails(android: androidDetails);

    // await flutterLocalNotificationsPlugin.show(
    //   0,
    //   'Pothole Alert!',
    //   message,
    //   platformDetails,
    // );
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

  double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     _showNotification('Test notification');
      //     // if (_currentPosition != null) {
      //     //   _mapController!.animateCamera(
      //     //     CameraUpdate.newLatLng(_currentPosition!),
      //     //   );
      //     // }
      //   },
      //   child: const Icon(Icons.my_location),
      // ),
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
