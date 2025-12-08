import 'package:flutter/material.dart';

class ControlPanel extends StatelessWidget {
  final double opacity;
  final double scale;
  final bool isLocked;
  final VoidCallback onPickImage;
  final ValueChanged<double> onOpacityChanged;
  final ValueChanged<double> onScaleChanged;
  final VoidCallback onReset;
  final VoidCallback onToggleLock;

  const ControlPanel({
    super.key,
    required this.opacity,
    required this.scale,
    required this.isLocked,
    required this.onPickImage,
    required this.onOpacityChanged,
    required this.onScaleChanged,
    required this.onReset,
    required this.onToggleLock,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.photo_library, color: Colors.white, size: 20),
            onPressed: onPickImage,
            tooltip: 'Pick Image',
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
          ),
          const SizedBox(width: 4),
          IconButton(
            icon: Icon(
              isLocked ? Icons.lock : Icons.lock_open,
              color: isLocked ? Colors.orange : Colors.white,
              size: 20,
            ),
            onPressed: onToggleLock,
            tooltip: isLocked ? 'Unlock' : 'Lock',
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
          ),
          const SizedBox(width: 8),
          _buildMiniSlider(
            icon: Icons.opacity,
            value: opacity,
            onChanged: isLocked ? null : onOpacityChanged,
          ),
          const SizedBox(width: 8),
          _buildMiniSlider(
            icon: Icons.zoom_in,
            value: (scale - 0.5) / 2.5,
            onChanged: isLocked ? null : (v) => onScaleChanged(0.5 + v * 2.5),
          ),
          const SizedBox(width: 4),
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: isLocked ? Colors.white38 : Colors.white,
              size: 20,
            ),
            onPressed: isLocked ? null : onReset,
            tooltip: 'Reset',
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniSlider({
    required IconData icon,
    required double value,
    required ValueChanged<double>? onChanged,
  }) {
    final isDisabled = onChanged == null;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: isDisabled ? Colors.white38 : Colors.white70, size: 16),
        SizedBox(
          width: 80,
          height: 20,
          child: SliderTheme(
            data: SliderThemeData(
              trackHeight: 3,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 12),
              activeTrackColor: isDisabled ? Colors.grey : Colors.blue,
              inactiveTrackColor: Colors.white24,
              thumbColor: isDisabled ? Colors.grey : Colors.white,
            ),
            child: Slider(
              value: value,
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
