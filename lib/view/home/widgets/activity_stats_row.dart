import 'package:flutter/material.dart';
import '../../../res/color/app_color.dart';
import '../../../res/fonts/app_fonts.dart';

class ActivityStatsRow extends StatelessWidget {
  final String km;
  final String kcal;
  final String min;

  const ActivityStatsRow({
    super.key,
    required this.km,
    required this.kcal,
    required this.min,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildStatCard(km, 'KM'),
        const SizedBox(width: 12),
        _buildStatCard(kcal, 'KCAL'),
        const SizedBox(width: 12),
        _buildStatCard(min, 'MIN'),
      ],
    );
  }

  Widget _buildStatCard(String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: AppFonts.headlineMedium.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppFonts.labelSmall.copyWith(
                color: AppColors.textMuted,
                fontSize: 10,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
