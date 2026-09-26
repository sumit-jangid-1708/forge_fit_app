import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../res/color/app_color.dart';
import '../../../res/fonts/app_fonts.dart';

class TrainHeader extends StatelessWidget {
  const TrainHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // // Back Button
        // InkWell(
        //   onTap: () => Get.back(),
        //   child: Row(
        //     mainAxisSize: MainAxisSize.min,
        //     children: [
        //       const Icon(Icons.arrow_back, color: AppColors.textSecondary, size: 16),
        //       const SizedBox(width: 8),
        //       Text(
        //         'Back',
        //         style: AppFonts.bodyMedium.copyWith(color: AppColors.textSecondary),
        //       ),
        //     ],
        //   ),
        // ),
        const SizedBox(height: 24),
        // // Subtitle
        Row(
          children: [
            Text(
              'UPPER BODY',
              style: AppFonts.labelSmall.copyWith(
                color: AppColors.primary,
                letterSpacing: 1.2,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            const Text('•', style: TextStyle(color: AppColors.textMuted)),
            const SizedBox(width: 8),
            Text(
              'DAY 3',
              style: AppFonts.labelSmall.copyWith(
                color: AppColors.textMuted,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Title
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Push Power\n',
                style: AppFonts.displayMedium.copyWith(
                  fontWeight: AppFonts.black_w,
                  fontSize: 36,
                ),
              ),
              TextSpan(
                text: 'Protocol',
                style: AppFonts.displayMedium.copyWith(
                  color: AppColors.primary,
                  fontWeight: AppFonts.black_w,
                  fontSize: 36,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
