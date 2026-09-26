import 'package:flutter/material.dart';
import '../../../res/color/app_color.dart';
import '../../../res/fonts/app_fonts.dart';

class WeeklyWorkoutsCard extends StatelessWidget {
  const WeeklyWorkoutsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final List<double> data = [0.2, 0.4, 0.3, 0.5, 0.4, 0.8, 0.2];
    final List<String> days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

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
            'WEEKLY WORKOUTS',
            style: AppFonts.labelSmall.copyWith(
              color: AppColors.textMuted,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '5',
                style: AppFonts.displayLarge.copyWith(fontSize: 48),
              ),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    const Icon(Icons.arrow_upward_rounded, color: AppColors.primary, size: 14),
                    Text(
                      ' +1 this week',
                      style: AppFonts.bodySmall.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text(
            'sessions completed',
            style: AppFonts.bodySmall.copyWith(color: AppColors.textMuted),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(data.length, (index) {
              return Column(
                children: [
                  Container(
                    height: 80 * data[index],
                    width: 32,
                    decoration: BoxDecoration(
                      color: index == 5 ? AppColors.primary : const Color(0xFF2C1A14),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    days[index],
                    style: AppFonts.labelSmall.copyWith(
                      color: index == 5 ? AppColors.primary : AppColors.textMuted,
                      fontSize: 10,
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
