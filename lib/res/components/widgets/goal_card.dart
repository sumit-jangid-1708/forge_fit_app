import 'package:flutter/material.dart';
import '../../color/app_color.dart';
import '../../fonts/app_fonts.dart';

class GoalCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final bool isSelected;
  final VoidCallback onTap;

  const GoalCard({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // ✅ borderRadius ek hi jagah define karo, dono jagah same use hoga
    final radius = BorderRadius.circular(24);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        // ✅ Outer Container — sirf border aur shadow ke liye
        // Isme clipBehavior ki zaroorat nahi, kyunki andar ClipRRect hai
        decoration: BoxDecoration(
          borderRadius: radius,
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: 2,
          ),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.15),
              blurRadius: 14,
              spreadRadius: 2,
            )
          ]
              : null,
        ),
        // ✅ ClipRRect — yeh guaranteed andar ke content ko crop karega
        // AnimatedContainer/Container ke clipBehavior se zyada reliable
        child: ClipRRect(
          borderRadius: radius,
          child: Stack(
            fit: StackFit.expand,
            children: [

              // ── Layer 1: Full background image ────────────────
              Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppColors.surfaceLight,
                    child: Icon(
                      Icons.fitness_center,
                      size: 36,
                      color: AppColors.textMuted,
                    ),
                  );
                },
              ),

              // ── Layer 2: Dark gradient ──────────────────────────
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end:   Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                      AppColors.background.withOpacity(0.4),
                      AppColors.background.withOpacity(0.85),
                      AppColors.background,
                    ],
                    stops: const [0.0, 0.35, 0.6, 0.8, 1.0],
                  ),
                ),
              ),

              // ── Layer 3: Text ────────────────────────────────────
              Positioned(
                left:   16,
                right:  16,
                bottom: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppFonts.headlineSmall.copyWith(
                        fontSize:   16,
                        fontWeight: FontWeight.bold,
                        color:      AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppFonts.bodySmall.copyWith(
                        color:    AppColors.textMuted,
                        height:   1.25,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),

              // ── Layer 4: Selection check icon ────────────────────
              if (isSelected)
                Positioned(
                  top:   12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: AppColors.white,
                      size: 14,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}