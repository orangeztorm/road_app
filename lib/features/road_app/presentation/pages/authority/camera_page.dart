import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:road_app/app/__app.dart';
import 'package:road_app/cores/__cores.dart';
import 'package:road_app/features/__features.dart';

class CameraCapturePage extends StatefulWidget {
  static const String routeName = '/camera-capture-page';
  const CameraCapturePage({super.key});

  @override
  _CameraCapturePageState createState() => _CameraCapturePageState();
}

class _CameraCapturePageState extends State<CameraCapturePage> {
  CameraController? _cameraController;
  List<CameraDescription>? cameras;
  String? _capturedImagePath;
  String? _streetAddress;
  Position? _currentPosition;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _getUserLocation();
    // if (Platform.isIOS) _captureImage();
  }

  /// 🔥 Initialize camera safely
  Future<void> _initializeCamera() async {
    try {
      cameras = await availableCameras();
      if (cameras == null || cameras!.isEmpty) {
        log("No cameras available");
        return;
      }

      _cameraController =
          CameraController(cameras!.first, ResolutionPreset.high);
      await _cameraController!.initialize();
      if (!mounted) return;

      setState(() {
        _isCameraInitialized = true;
      });
    } catch (e) {
      log("Error initializing camera: $e");
      Toast.showError("Failed to initialize camera.");
    }
  }

  /// 🔥 Get user location safely
  Future<void> _getUserLocation() async {
    bool hasPermission = await _requestLocationPermission();
    if (!hasPermission) return;

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      setState(() {
        _currentPosition = position;
        _streetAddress = placemarks.isNotEmpty
            ? "${placemarks.first.street}, ${placemarks.first.locality}, ${placemarks.first.country}"
            : "Unknown location";
      });
    } catch (e) {
      log("Error getting location: $e");
      Toast.showError("Could not get location.");
    }
  }

  void _showLocationPermissionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Location Permission"),
        content: const Text("Please enable location access in app settings."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Geolocator.openAppSettings(),
            child: const Text("Open Settings"),
          ),
        ],
      ),
    );
  }

  /// 🔥 Request location permissions
  Future<bool> _requestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return false;
    }

    if (permission == LocationPermission.deniedForever) {
      _showLocationPermissionDialog();
      return false;
    }

    return true;
  }

  /// 🔥 Capture image safely
  Future<void> _captureImage() async {
    if ((!_isCameraInitialized || _cameraController == null) &&
        !Platform.isIOS) {
      Toast.showError("Camera is not ready yet.");
      return;
    }

    try {
      late XFile? imageFile;

      // if (Platform.isIOS) {
      // imageFile = await ImagePicker().pickImage(
      //   source: ImageSource.gallery,
      //   preferredCameraDevice: CameraDevice.front,
      // );
      // if (imageFile == null) {
      //   Toast.showError("No image selected.");
      //   return;
      // }
      // } else {
      imageFile = await _cameraController!.takePicture();
      // }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      setState(() {
        _capturedImagePath = imageFile!.path;
        _currentPosition = position;
        _streetAddress = placemarks.isNotEmpty
            ? "${placemarks.first.street}, ${placemarks.first.locality}, ${placemarks.first.country}"
            : "Unknown location";
      });

      log("Image Captured: $_capturedImagePath");
      log("lat: ${position.latitude}");
      log("lng: ${position.longitude}");
      log("Address: $_streetAddress");
      log("------------------------");
      _showBottomSheet();
    } catch (e) {
      log("Error capturing image: $e");
      Toast.showError("Failed to capture image.");
    }
  }

  /// 🔥 Show bottom sheet with captured image
  void _showBottomSheet() {
    BottomSheetHelper.show(
      isDismissible: false,
      context: context,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: ConfirmBottomSheet(
          address: _streetAddress,
          imagePath: _capturedImagePath,
          position: _currentPosition,
          onRetake: () {
            Navigator.pop(context);
            _captureImage();
          },
          onGoHome: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Capture Image & Location")),
      body: _isCameraInitialized
          ? Column(
              children: [
                Expanded(
                    child: CameraPreview(_cameraController!)), // Camera preview
                const SizedBox(height: 10),
                if (_streetAddress != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Current Location: $_streetAddress",
                        textAlign: TextAlign.center),
                  ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _captureImage,
                  child: const Text("Take Picture"),
                ),
                const SizedBox(height: 20),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}

class ConfirmBottomSheet extends StatelessWidget {
  final String? imagePath;
  final Position? position;
  final String? address;
  final Function()? onRetake;
  final Function()? onGoHome;

  static DetectPotholeCubit detectPotholeCubit = getIt<DetectPotholeCubit>();
  static DetectPotholeBloc detectPotholeBloc = getIt<DetectPotholeBloc>();

  const ConfirmBottomSheet({
    super.key,
    this.imagePath,
    this.position,
    this.address,
    this.onRetake,
    this.onGoHome,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("Captured Image",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        if (imagePath != null)
          Image.file(File(imagePath!), height: 200, fit: BoxFit.cover),
        const SizedBox(height: 20),
        if (position != null) ...[
          Text("Latitude: ${position!.latitude}"),
          Text("Longitude: ${position!.longitude}"),
        ],
        if (address != null) Text(address ?? ''),
        const SizedBox(height: 10),
        _buildButton(),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onRetake?.call();
              },
              child: const Text("Retake"),
            ),
            TextButton(
              onPressed: () {
                onGoHome?.call();
              },
              child: const Text("Go to Home"),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildButton() {
    return BlocConsumer<DetectPotholeBloc, DetectPotholeState>(
      bloc: detectPotholeBloc,
      listener: _detectPotholeListener,
      builder: (context, state) {
        return state.status.isLoading
            ? const LoadingIndicatorWidget()
            : Button(
                width: w(200),
                radius: sr(50),
                textSize: 14,
                onTap: _sendToBackend,
                text: 'Send To Backend',
              );
      },
    );
  }

  void _detectPotholeListener(BuildContext context, DetectPotholeState state) {
    if (state.status == DetectPotholeStatus.success) {
      final status = state.data?.data.pothole.status;
      if (status == "DETECTED") {
        Toast.useContext(context: context, message: "Pothole detected!");
      } else {
        Toast.useContext(context: context, message: "No pothole detected.");
      }
      // show bottom sheet close current one
    } else if (state.status == DetectPotholeStatus.failure) {
      Toast.useContext(
          context: context,
          message: state.failure?.message ?? "An error occured",
          type: SnackbarType.error);
    }
  }

  /// Simulate sending data to backend
  void _sendToBackend() async {
    if (imagePath == null) return;
    detectPotholeCubit.updateImage(File(imagePath!));
    detectPotholeCubit.updateLat(position?.latitude);
    detectPotholeCubit.updateLng(position?.longitude);
    detectPotholeCubit.updateAddress(address);

    detectPotholeBloc.add(DetectPothole(detectPotholeCubit.state));
  }
}
