import 'package:flutter/material.dart';
import '../../../res/color/app_color.dart';
import '../../../res/fonts/app_fonts.dart';

class BadgeTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isEarned;
  final bool isLocked;

  const BadgeTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.isEarned = false,
    this.isLocked = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isEarned ? AppColors.primary.withOpacity(0.3) : AppColors.border,
          width: 1,
        ),
      ),
      child: Stack(
        children: [
          if (isEarned)
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 10),
              ),
            ),
          if (isLocked)
            const Positioned(
              top: 12,
              right: 12,
              child: Icon(Icons.lock_outline_rounded, color: AppColors.textMuted, size: 16),
            ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Hexagonal Background for Icon
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: isEarned ? AppColors.primary.withOpacity(0.1) : AppColors.background,
                    shape: BoxShape.circle, // Simplified from hexagon for now
                    border: Border.all(
                      color: isEarned ? AppColors.primary : AppColors.border,
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    icon,
                    color: isEarned ? AppColors.primary : AppColors.textMuted.withOpacity(0.5),
                    size: 28,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: AppFonts.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isEarned ? AppColors.textPrimary : AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: AppFonts.bodySmall.copyWith(
                    fontSize: 10,
                    color: AppColors.textMuted,
                  ),
                ),
                if (isEarned) ...[
                  const SizedBox(height: 8),
                  Text(
                    'EARNED',
                    style: AppFonts.labelSmall.copyWith(
                      color: AppColors.primary,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
