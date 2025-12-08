import 'package:flutter/material.dart';

class HorizontalBalanceBar extends StatelessWidget {
  final double balance;

  const HorizontalBalanceBar({super.key, required this.balance});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${(balance * 90).toStringAsFixed(1)}°',
            style: const TextStyle(color: Colors.white70, fontSize: 10),
          ),
          const SizedBox(width: 8),
          Container(
            width: 180,
            height: 16,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white24),
            ),
            child: Stack(
              children: [
                Center(
                  child: Container(width: 2, height: 16, color: Colors.white38),
                ),
                AnimatedAlign(
                  duration: const Duration(milliseconds: 100),
                  alignment: Alignment(balance, 0),
                  child: Container(
                    width: 14,
                    height: 14,
                    margin: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: _getBalanceColor(balance),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: _getBalanceColor(balance).withValues(alpha: 0.5),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
