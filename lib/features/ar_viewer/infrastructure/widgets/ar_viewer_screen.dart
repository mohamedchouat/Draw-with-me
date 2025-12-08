import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:drawwithme/features/ar_viewer/adapters/ar_viewer_presenter.dart';
import 'package:drawwithme/widgets/sensor_bar.dart';
import 'package:drawwithme/widgets/control_panel.dart';

class ARViewerScreen extends StatefulWidget {
  const ARViewerScreen({super.key});

  @override
  State<ARViewerScreen> createState() => _ARViewerScreenState();
}

class _ARViewerScreenState extends State<ARViewerScreen> with WidgetsBindingObserver {
  CameraController? _cameraController;
  bool _isCameraInitialized = false;
  bool _isCameraPermissionGranted = false;
  String? _errorMessage;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeCamera();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ARViewerPresenter>().start();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      _cameraController?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initializeCamera();
    }
  }

  Future<void> _initializeCamera() async {
    final status = await Permission.camera.request();
    _isCameraPermissionGranted = status.isGranted;

    if (!_isCameraPermissionGranted) {
      setState(() {
        _errorMessage = 'Camera permission denied';
      });
      return;
    }

    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        setState(() {
          _errorMessage = 'No cameras available';
        });
        return;
      }

      final backCamera = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );

      _cameraController = CameraController(
        backCamera,
        ResolutionPreset.high,
        enableAudio: false,
      );

      await _cameraController!.initialize();

      if (mounted) {
        setState(() {
          _isCameraInitialized = true;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error initializing camera: $e';
      });
    }
  }

  Future<void> _pickImage() async {
    final presenter = context.read<ARViewerPresenter>();
    
    final XFile? pickedFile = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      presenter.setOverlayImage(File(pickedFile.path));
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            _buildCameraPreview(),
            _buildOverlayImage(),
            _buildSensorBar(),
            _buildControlPanel(),
          ],
        ),
      ),
    );
  }

  Widget _buildCameraPreview() {
    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, color: Colors.red, size: 48),
            const SizedBox(height: 16),
            Text(
              _errorMessage!,
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => openAppSettings(),
              child: const Text('Open Settings'),
            ),
          ],
        ),
      );
    }

    if (!_isCameraInitialized || _cameraController == null) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    return CameraPreview(_cameraController!);
  }

  Widget _buildOverlayImage() {
    return Consumer<ARViewerPresenter>(
      builder: (context, presenter, child) {
        if (presenter.overlayImage == null) {
          return const SizedBox.shrink();
        }

        return Positioned.fill(
          child: GestureDetector(
            onScaleUpdate: (details) {
              if (details.scale != 1.0) {
                presenter.setImageScale(presenter.imageScale * details.scale);
              } else {
                presenter.updateImageOffset(details.focalPointDelta);
              }
            },
            child: Transform.translate(
              offset: presenter.imageOffset,
              child: Transform.scale(
                scale: presenter.imageScale,
                child: Opacity(
                  opacity: presenter.imageOpacity,
                  child: Image.file(
                    presenter.overlayImage!,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSensorBar() {
    return Positioned(
      top: 16,
      right: 16,
      child: Consumer<ARViewerPresenter>(
        builder: (context, presenter, child) {
          return SensorBar(orientation: presenter.orientation);
        },
      ),
    );
  }

  Widget _buildControlPanel() {
    return Positioned(
      bottom: 16,
      left: 16,
      right: 16,
      child: Consumer<ARViewerPresenter>(
        builder: (context, presenter, child) {
          return Center(
            child: ControlPanel(
              opacity: presenter.imageOpacity,
              scale: presenter.imageScale,
              onPickImage: _pickImage,
              onOpacityChanged: presenter.setImageOpacity,
              onScaleChanged: presenter.setImageScale,
              onReset: presenter.resetImagePosition,
            ),
          );
        },
      ),
    );
  }
}
