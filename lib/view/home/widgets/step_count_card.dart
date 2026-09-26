import 'package:flutter/material.dart';
import '../../../res/color/app_color.dart';
import '../../../res/fonts/app_fonts.dart';

class StepCountCard extends StatelessWidget {
  const StepCountCard({super.key});

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
            'STEP COUNT',
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
                '8,432',
                style: AppFonts.displayLarge.copyWith(fontSize: 36),
              ),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  'steps',
                  style: AppFonts.bodyLarge.copyWith(color: AppColors.textMuted),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '84% of daily goal (10,000)',
            style: AppFonts.bodySmall.copyWith(color: AppColors.textMuted),
          ),
          const SizedBox(height: 24),
          // Gradient Progress Bar
          Stack(
            children: [
              Container(
                height: 6,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              Container(
                height: 6,
                width: MediaQuery.of(context).size.width * 0.6, // 84% approximately
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(3),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.4),
                      blurRadius: 8,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('0', style: AppFonts.labelSmall.copyWith(fontSize: 9)),
              Text('5,000', style: AppFonts.labelSmall.copyWith(fontSize: 9)),
              Text('10,000', style: AppFonts.labelSmall.copyWith(fontSize: 9)),
            ],
          ),
        ],
      ),
    );
  }
}
