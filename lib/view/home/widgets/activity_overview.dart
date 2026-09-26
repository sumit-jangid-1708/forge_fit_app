import 'package:flutter/material.dart';
import '../../../res/color/app_color.dart';
import '../../../res/fonts/app_fonts.dart';

class ActivityOverview extends StatelessWidget {
  const ActivityOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ACTIVITY OVERVIEW',
            style: AppFonts.labelSmall.copyWith(
              color: AppColors.textMuted,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              // Rings Section
              Expanded(
                flex: 4,
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      _buildRing(110, 0.8, AppColors.ringMove),
                      _buildRing(82, 0.6, AppColors.ringExercise),
                      _buildRing(54, 0.45, AppColors.ringStand),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 24),
              // Labels Section
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    _buildMetricRow('MOVE', '487', '/ 600 cal', AppColors.ringMove),
                    const SizedBox(height: 16),
                    _buildMetricRow('EXERCISE', '38', '/ 45 min', AppColors.ringExercise),
                    const SizedBox(height: 16),
                    _buildMetricRow('STAND', '10', '/ 12 hrs', AppColors.ringStand),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRing(double size, double value, Color color) {
    return SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(
        value: value,
        strokeWidth: 10,
        backgroundColor: color.withOpacity(0.1),
        valueColor: AlwaysStoppedAnimation<Color>(color),
        strokeCap: StrokeCap.round,
      ),
    );
  }

  Widget _buildMetricRow(String label, String value, String total, Color color) {
    return Row(
      children: [
        Container(
          height: 8,
          width: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.5),
                blurRadius: 4,
                spreadRadius: 1,
              )
            ],
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: AppFonts.labelSmall.copyWith(fontSize: 9, color: AppColors.textMuted),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  value,
                  style: AppFonts.headlineSmall.copyWith(fontSize: 18),
                ),
                const SizedBox(width: 4),
                Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Text(
                    total,
                    style: AppFonts.bodySmall.copyWith(color: AppColors.textMuted, fontSize: 11),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
