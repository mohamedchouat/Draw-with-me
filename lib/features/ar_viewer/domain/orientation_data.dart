class OrientationData {
  final double roll;
  final double pitch;
  final double yaw;
  final double accelX;
  final double accelY;
  final double accelZ;
  final double gyroX;
  final double gyroY;
  final double gyroZ;

  const OrientationData({
    this.roll = 0.0,
    this.pitch = 0.0,
    this.yaw = 0.0,
    this.accelX = 0.0,
    this.accelY = 0.0,
    this.accelZ = 0.0,
    this.gyroX = 0.0,
    this.gyroY = 0.0,
    this.gyroZ = 0.0,
  });

  bool get isLevel {
    const threshold = 0.1;
    return roll.abs() < threshold && pitch.abs() < threshold;
  }

  double get horizontalBalance => roll.clamp(-1.0, 1.0);
  double get verticalBalance => pitch.clamp(-1.0, 1.0);

  OrientationData copyWith({
    double? roll,
    double? pitch,
    double? yaw,
    double? accelX,
    double? accelY,
    double? accelZ,
    double? gyroX,
    double? gyroY,
    double? gyroZ,
  }) {
    return OrientationData(
      roll: roll ?? this.roll,
      pitch: pitch ?? this.pitch,
      yaw: yaw ?? this.yaw,
      accelX: accelX ?? this.accelX,
      accelY: accelY ?? this.accelY,
      accelZ: accelZ ?? this.accelZ,
      gyroX: gyroX ?? this.gyroX,
      gyroY: gyroY ?? this.gyroY,
      gyroZ: gyroZ ?? this.gyroZ,
    );
  }
}
