import 'package:flutter/material.dart';
import '../../../res/color/app_color.dart';
import '../../../res/fonts/app_fonts.dart';

class WorkoutProgress extends StatelessWidget {
  final int completed;
  final int total;
  const WorkoutProgress({super.key, required this.completed, required this.total});

  @override
  Widget build(BuildContext context) {
    double progress = completed / total;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Progress',
              style: AppFonts.bodyMedium.copyWith(color: AppColors.textMuted),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '$completed / $total',
                    style: AppFonts.titleMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: ' done',
                    style: AppFonts.bodySmall.copyWith(color: AppColors.textMuted),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Stack(
          children: [
            Container(
              height: 4,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Container(
              height: 4,
              width: MediaQuery.of(context).size.width * 0.8 * progress,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(2),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.5),
                    blurRadius: 4,
                    spreadRadius: 1,
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
