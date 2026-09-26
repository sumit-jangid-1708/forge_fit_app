import 'package:flutter/material.dart';
import '../../../res/color/app_color.dart';
import '../../../res/fonts/app_fonts.dart';

class InfoBadge extends StatelessWidget {
  final String text;
  final bool isOutline;
  const InfoBadge({super.key, required this.text, this.isOutline = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isOutline ? Colors.transparent : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isOutline ? AppColors.borderOrange.withOpacity(0.5) : AppColors.border,
        ),
      ),
      child: Text(
        text,
        style: AppFonts.bodySmall.copyWith(
          color: isOutline ? AppColors.primary : AppColors.textSecondary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
