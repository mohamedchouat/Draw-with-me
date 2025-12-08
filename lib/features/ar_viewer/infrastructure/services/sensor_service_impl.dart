import 'dart:async';
import 'dart:math';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:drawwithme/features/ar_viewer/application/ports/sensor_service_port.dart';
import 'package:drawwithme/features/ar_viewer/domain/orientation_data.dart';

class SensorServiceImpl implements SensorServicePort {
  final _orientationController = StreamController<OrientationData>.broadcast();
  
  StreamSubscription? _accelSubscription;
  StreamSubscription? _gyroSubscription;
  
  double _accelX = 0.0;
  double _accelY = 0.0;
  double _accelZ = 0.0;
  double _gyroX = 0.0;
  double _gyroY = 0.0;
  double _gyroZ = 0.0;

  @override
  Stream<OrientationData> get orientationStream => _orientationController.stream;

  @override
  void startListening() {
    _accelSubscription = accelerometerEventStream().listen((event) {
      _accelX = event.x;
      _accelY = event.y;
      _accelZ = event.z;
      _emitOrientation();
    });

    _gyroSubscription = gyroscopeEventStream().listen((event) {
      _gyroX = event.x;
      _gyroY = event.y;
      _gyroZ = event.z;
      _emitOrientation();
    });
  }

  void _emitOrientation() {
    final roll = atan2(_accelX, sqrt(_accelY * _accelY + _accelZ * _accelZ));
    final pitch = atan2(_accelY, sqrt(_accelX * _accelX + _accelZ * _accelZ));
    
    final normalizedRoll = roll / (pi / 2);
    final normalizedPitch = pitch / (pi / 2);

    _orientationController.add(OrientationData(
      roll: normalizedRoll,
      pitch: normalizedPitch,
      yaw: 0.0,
      accelX: _accelX,
      accelY: _accelY,
      accelZ: _accelZ,
      gyroX: _gyroX,
      gyroY: _gyroY,
      gyroZ: _gyroZ,
    ));
  }

  @override
  void stopListening() {
    _accelSubscription?.cancel();
    _gyroSubscription?.cancel();
    _accelSubscription = null;
    _gyroSubscription = null;
  }

  @override
  void dispose() {
    stopListening();
    _orientationController.close();
  }
}
