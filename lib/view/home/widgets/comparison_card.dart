import 'package:flutter/material.dart';
import '../../../res/color/app_color.dart';
import '../../../res/fonts/app_fonts.dart';
import '../../../res/app_strings/app_strings.dart';

class ComparisonCard extends StatelessWidget {
  const ComparisonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: AppColors.borderOrange.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.beforeVsNow,
                style: AppFonts.labelSmall.copyWith(
                  color: AppColors.textMuted,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                AppStrings.sixMonths,
                style: AppFonts.labelSmall.copyWith(
                  color: AppColors.primary,
                  fontSize: 10,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              // Before Photo Placeholder
              Expanded(
                child: _buildPhotoBox(
                  AppStrings.jan2024,
                  '85.6 kg',
                  Icons.person_outline_rounded,
                  false,
                ),
              ),
              const SizedBox(width: 1), // Vertical divider line space
              Container(width: 1, height: 180, color: AppColors.border),
              const SizedBox(width: 1),
              // Now Photo Placeholder
              Expanded(
                child: _buildPhotoBox(
                  AppStrings.jun2024,
                  '82.4 kg',
                  Icons.fitness_center_rounded,
                  true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoBox(String date, String weight, IconData icon, bool isNow) {
    return Column(
      children: [
        if (isNow)
          Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'NOW',
                style: AppFonts.labelSmall.copyWith(
                  color: AppColors.primary,
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        const SizedBox(height: 10),
        Icon(
          icon,
          size: 60,
          color: isNow ? AppColors.primary.withOpacity(0.5) : AppColors.textMuted.withOpacity(0.3),
        ),
        const SizedBox(height: 30),
        Text(
          date,
          style: AppFonts.labelSmall.copyWith(fontSize: 10, color: AppColors.textMuted),
        ),
        const SizedBox(height: 4),
        Text(
          weight,
          style: AppFonts.headlineSmall.copyWith(
            color: isNow ? AppColors.primary : AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
