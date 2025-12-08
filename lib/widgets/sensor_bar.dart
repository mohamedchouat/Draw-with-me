import 'package:flutter/material.dart';
import 'package:drawwithme/features/ar_viewer/domain/orientation_data.dart';

class SensorBar extends StatelessWidget {
  final OrientationData orientation;

  const SensorBar({super.key, required this.orientation});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHorizontalBar(),
          const SizedBox(height: 8),
          _buildVerticalBar(),
          const SizedBox(height: 8),
          _buildSensorValues(),
        ],
      ),
    );
  }

  Widget _buildHorizontalBar() {
    return Column(
      children: [
        const Text(
          'Horizontal',
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
        const SizedBox(height: 4),
        Container(
          width: 200,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white24),
          ),
          child: Stack(
            children: [
              Center(
                child: Container(
                  width: 2,
                  height: 20,
                  color: Colors.white38,
                ),
              ),
              AnimatedAlign(
                duration: const Duration(milliseconds: 100),
                alignment: Alignment(orientation.horizontalBalance, 0),
                child: Container(
                  width: 16,
                  height: 16,
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: _getBalanceColor(orientation.horizontalBalance),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: _getBalanceColor(orientation.horizontalBalance)
                            .withValues(alpha: 0.5),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVerticalBar() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const RotatedBox(
          quarterTurns: 3,
          child: Text(
            'Vertical',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        const SizedBox(width: 4),
        Container(
          width: 20,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white24),
          ),
          child: Stack(
            children: [
              Center(
                child: Container(
                  width: 20,
                  height: 2,
                  color: Colors.white38,
                ),
              ),
              AnimatedAlign(
                duration: const Duration(milliseconds: 100),
                alignment: Alignment(0, orientation.verticalBalance),
                child: Container(
                  width: 16,
                  height: 16,
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: _getBalanceColor(orientation.verticalBalance),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: _getBalanceColor(orientation.verticalBalance)
                            .withValues(alpha: 0.5),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSensorValues() {
    return Column(
      children: [
        Text(
          'Roll: ${(orientation.roll * 90).toStringAsFixed(1)}°',
          style: const TextStyle(color: Colors.white70, fontSize: 10),
        ),
        Text(
          'Pitch: ${(orientation.pitch * 90).toStringAsFixed(1)}°',
          style: const TextStyle(color: Colors.white70, fontSize: 10),
        ),
        if (orientation.isLevel)
          const Text(
            '✓ LEVEL',
            style: TextStyle(
              color: Colors.green,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    );
  }

  Color _getBalanceColor(double value) {
    final absValue = value.abs();
    if (absValue < 0.05) return Colors.green;
    if (absValue < 0.15) return Colors.yellow;
    if (absValue < 0.3) return Colors.orange;
    return Colors.red;
  }
}
