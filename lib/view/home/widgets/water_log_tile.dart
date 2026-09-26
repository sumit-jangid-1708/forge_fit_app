import 'package:flutter/material.dart';
import '../../../res/color/app_color.dart';
import '../../../res/fonts/app_fonts.dart';

class WaterLogTile extends StatelessWidget {
  final String time;
  final String label;
  final String amount;
  final Color indicatorColor;

  const WaterLogTile({
    super.key,
    required this.time,
    required this.label,
    required this.amount,
    required this.indicatorColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            // Left Indicator Bar
            Container(
              width: 4,
              decoration: BoxDecoration(
                color: indicatorColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Time
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                time,
                style: AppFonts.bodySmall.copyWith(
                  color: AppColors.textMuted,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 24),
            // Label
            Expanded(
              child: Text(
                label,
                style: AppFonts.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Amount
            Text(
              amount,
              style: AppFonts.titleMedium.copyWith(
                color: AppColors.info,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 12),
            const Icon(Icons.arrow_forward_ios_rounded, color: AppColors.textMuted, size: 14),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
