// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'dart:developer';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraCapturePage extends StatefulWidget {
  static const String routeName = '/camera-capture-page';
  const CameraCapturePage({super.key});

  @override
  _CameraCapturePageState createState() => _CameraCapturePageState();
}

class _CameraCapturePageState extends State<CameraCapturePage> {
  CameraController? _cameraController;
  List<CameraDescription>? cameras;
  bool _isCapturing = false;
  Timer? _timer;
  List<String> dummyImages = []; // Store dummy images

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    if (cameras!.isNotEmpty) {
      _cameraController =
          CameraController(cameras![0], ResolutionPreset.medium);
      await _cameraController!.initialize();
      if (mounted) setState(() {}); // Refresh UI when camera is initialized
    }
  }

  void _startCapturing() {
    if (_cameraController == null || !_cameraController!.value.isInitialized)
      return;

    setState(() => _isCapturing = true);

    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      _captureImage();
    });
  }

  void _captureImage() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized)
      return;

    // For now, we're adding a dummy image (replace this with actual captured image path)
    setState(() {
      dummyImages.add("https://via.placeholder.com/150"); // Dummy image URL
    });

    log("Image Captured!");
  }

  void _stopCapturing() {
    _timer?.cancel();
    setState(() => _isCapturing = false);

    // Navigate to the image list page
  }

  @override
  void dispose() {
    _timer?.cancel();
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Capture Images")),
      body: Column(
        children: [
          Expanded(child: CameraPreview(_cameraController!)), // Camera preview
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _isCapturing ? null : _startCapturing,
                child: const Text("Start"),
              ),
              ElevatedButton(
                onPressed: _isCapturing ? _stopCapturing : null,
                child: const Text("Stop"),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
