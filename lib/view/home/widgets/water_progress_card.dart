import 'package:flutter/material.dart';
import '../../../res/color/app_color.dart';
import '../../../res/fonts/app_fonts.dart';
import '../../../res/app_strings/app_strings.dart';
import 'water_wave_painter.dart';

class WaterProgressCard extends StatelessWidget {
  final double intake;
  final double goal;
  final double progress;

  const WaterProgressCard({
    super.key,
    required this.intake,
    required this.goal,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    double progress = intake / goal;
    int percentage = (progress * 100).toInt();

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.todayIntake,
                      style: AppFonts.labelSmall.copyWith(
                        color: AppColors.textMuted,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          intake.toStringAsFixed(1),
                          style: AppFonts.displayLarge.copyWith(fontSize: 48),
                        ),
                        const SizedBox(width: 8),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Text(
                            'L',
                            style: AppFonts.headlineMedium.copyWith(color: AppColors.textMuted),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'of ${goal.toStringAsFixed(1)} L',
                      style: AppFonts.bodySmall.copyWith(color: AppColors.textMuted),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.info.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.check_circle_rounded, color: AppColors.info, size: 14),
                          const SizedBox(width: 6),
                          Text(
                            '$percentage% of daily goal',
                            style: AppFonts.labelSmall.copyWith(
                              color: AppColors.info,
                              letterSpacing: 0,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Circular Wave Progress
              SizedBox(
                height: 120,
                width: 120,
                child: CustomPaint(
                  painter: WaterWavePainter(progress),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          // Horizontal Progress Bar
          Row(
            children: [
              Text(
                '0 L',
                style: AppFonts.labelSmall.copyWith(fontSize: 10, color: AppColors.textMuted),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E1E1E),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return Container(
                          height: 6,
                          width: constraints.maxWidth * progress,
                          decoration: BoxDecoration(
                            color: AppColors.info,
                            borderRadius: BorderRadius.circular(3),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.info.withOpacity(0.5),
                                blurRadius: 10,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${goal.toStringAsFixed(1)} L',
                style: AppFonts.labelSmall.copyWith(fontSize: 10, color: AppColors.textMuted),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
