import 'package:flutter/material.dart';
import '../../../res/color/app_color.dart';
import '../../../res/fonts/app_fonts.dart';

class StepProgressIndicator extends StatelessWidget {
  final int steps;
  final int goal;

  const StepProgressIndicator({
    super.key,
    required this.steps,
    required this.goal,
  });

  @override
  Widget build(BuildContext context) {
    double progress = steps / goal;
    int percentage = (progress * 100).toInt();

    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: 220,
            width: 220,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 16,
              backgroundColor: AppColors.surfaceLight,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
              strokeCap: StrokeCap.round,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'TODAY',
                style: AppFonts.labelSmall.copyWith(
                  color: AppColors.textMuted,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                steps.toString().replaceAllMapped(
                    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},'),
                style: AppFonts.displayLarge.copyWith(
                  fontSize: 48,
                  fontWeight: AppFonts.black_w,
                ),
              ),
              Text(
                '/ ${goal.toString().replaceAllMapped(RegExp(r"(\d{1,3})(?=(\d{3})+(?!\d))"), (Match m) => "${m[1]},")} steps',
                style: AppFonts.bodySmall.copyWith(color: AppColors.textMuted),
              ),
              const SizedBox(height: 8),
              Text(
                '$percentage%',
                style: AppFonts.headlineSmall.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
