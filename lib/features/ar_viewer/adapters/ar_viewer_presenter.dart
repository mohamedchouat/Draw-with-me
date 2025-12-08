import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:drawwithme/features/ar_viewer/application/usecases/update_orientation.dart';
import 'package:drawwithme/features/ar_viewer/domain/orientation_data.dart';
import 'package:drawwithme/injections.dart';

class ARViewerPresenter extends ChangeNotifier {
  final UpdateOrientation _updateOrientation = 
      ServiceLocator().get<UpdateOrientation>();

  OrientationData _orientation = const OrientationData();
  File? _overlayImage;
  double _imageOpacity = 0.5;
  double _imageScale = 1.0;
  Offset _imageOffset = Offset.zero;
  bool _isLocked = false;
  
  StreamSubscription? _orientationSubscription;

  OrientationData get orientation => _orientation;
  File? get overlayImage => _overlayImage;
  double get imageOpacity => _imageOpacity;
  double get imageScale => _imageScale;
  Offset get imageOffset => _imageOffset;
  bool get isLocked => _isLocked;

  void start() {
    _updateOrientation.start();
    _orientationSubscription = _updateOrientation.orientationStream.listen((data) {
      _orientation = data;
      notifyListeners();
    });
  }

  void stop() {
    _orientationSubscription?.cancel();
    _updateOrientation.stop();
  }

  void setOverlayImage(File? image) {
    _overlayImage = image;
    notifyListeners();
  }

  void setImageOpacity(double opacity) {
    if (_isLocked) return;
    _imageOpacity = opacity.clamp(0.0, 1.0);
    notifyListeners();
  }

  void setImageScale(double scale) {
    if (_isLocked) return;
    _imageScale = scale.clamp(0.5, 3.0);
    notifyListeners();
  }

  void updateImageOffset(Offset delta) {
    if (_isLocked) return;
    _imageOffset += delta;
    notifyListeners();
  }

  void resetImagePosition() {
    if (_isLocked) return;
    _imageOffset = Offset.zero;
    _imageScale = 1.0;
    notifyListeners();
  }

  void toggleLock() {
    _isLocked = !_isLocked;
    notifyListeners();
  }

  @override
  void dispose() {
    _orientationSubscription?.cancel();
    _updateOrientation.dispose();
    super.dispose();
  }
}
