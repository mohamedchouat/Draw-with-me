import 'package:drawwithme/features/ar_viewer/domain/orientation_data.dart';

abstract class SensorServicePort {
  Stream<OrientationData> get orientationStream;
  void startListening();
  void stopListening();
  void dispose();
}
