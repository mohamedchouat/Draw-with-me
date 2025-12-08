import 'package:drawwithme/features/ar_viewer/application/ports/sensor_service_port.dart';
import 'package:drawwithme/features/ar_viewer/application/usecases/update_orientation.dart';
import 'package:drawwithme/features/ar_viewer/infrastructure/services/sensor_service_impl.dart';

class ServiceLocator {
  static final ServiceLocator _instance = ServiceLocator._internal();
  factory ServiceLocator() => _instance;
  ServiceLocator._internal();

  final Map<Type, dynamic> _services = {};

  void registerSingleton<T>(T instance) {
    _services[T] = instance;
  }

  T get<T>() {
    final service = _services[T];
    if (service == null) {
      throw Exception('Service $T not registered');
    }
    return service as T;
  }

  bool isRegistered<T>() => _services.containsKey(T);

  void reset() => _services.clear();

  static void setup() {
    final locator = ServiceLocator();
    
    final sensorService = SensorServiceImpl();
    locator.registerSingleton<SensorServicePort>(sensorService);
    
    final updateOrientation = UpdateOrientation(
      locator.get<SensorServicePort>(),
    );
    locator.registerSingleton<UpdateOrientation>(updateOrientation);
  }
}
