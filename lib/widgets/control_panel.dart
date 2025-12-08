import 'package:flutter/material.dart';

class ControlPanel extends StatelessWidget {
  final double opacity;
  final double scale;
  final VoidCallback onPickImage;
  final ValueChanged<double> onOpacityChanged;
  final ValueChanged<double> onScaleChanged;
  final VoidCallback onReset;

  const ControlPanel({
    super.key,
    required this.opacity,
    required this.scale,
    required this.onPickImage,
    required this.onOpacityChanged,
    required this.onScaleChanged,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.photo_library, color: Colors.white),
                onPressed: onPickImage,
                tooltip: 'Pick Image',
              ),
              IconButton(
                icon: const Icon(Icons.refresh, color: Colors.white),
                onPressed: onReset,
                tooltip: 'Reset Position',
              ),
            ],
          ),
          const SizedBox(height: 8),
          _buildSlider(
            label: 'Opacity',
            value: opacity,
            onChanged: onOpacityChanged,
            icon: Icons.opacity,
          ),
          const SizedBox(height: 8),
          _buildSlider(
            label: 'Zoom',
            value: (scale - 0.5) / 2.5,
            onChanged: (v) => onScaleChanged(0.5 + v * 2.5),
            icon: Icons.zoom_in,
          ),
        ],
      ),
    );
  }

  Widget _buildSlider({
    required String label,
    required double value,
    required ValueChanged<double> onChanged,
    required IconData icon,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white70, size: 20),
        const SizedBox(width: 8),
        SizedBox(
          width: 150,
          child: Slider(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.blue,
            inactiveColor: Colors.white24,
          ),
        ),
        SizedBox(
          width: 40,
          child: Text(
            '${(value * 100).toInt()}%',
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ),
      ],
    );
  }
}
