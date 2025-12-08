import 'package:drawwithme/features/ar_viewer/application/ports/sensor_service_port.dart';
import 'package:drawwithme/features/ar_viewer/domain/orientation_data.dart';

class UpdateOrientation {
  final SensorServicePort _sensorService;

  UpdateOrientation(this._sensorService);

  Stream<OrientationData> get orientationStream => _sensorService.orientationStream;

  void start() => _sensorService.startListening();
  void stop() => _sensorService.stopListening();
  void dispose() => _sensorService.dispose();
}
