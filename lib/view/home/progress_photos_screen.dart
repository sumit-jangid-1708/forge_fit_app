import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../res/app_strings/app_strings.dart';
import '../../res/color/app_color.dart';
import '../../res/fonts/app_fonts.dart';
import 'widgets/comparison_card.dart';

class ProgressPhotosScreen extends StatelessWidget {
  const ProgressPhotosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              // ── Top Bar ──────────────────────────────────────────────
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.white, size: 16),
                ),
              ),

              const SizedBox(height: 24),

              // ── Header ───────────────────────────────────────────────
              Text(
                AppStrings.transformation,
                style: AppFonts.labelSmall.copyWith(
                  color: AppColors.primary,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Progress ',
                      style: AppFonts.displayMedium.copyWith(
                        fontWeight: AppFonts.black_w,
                        fontSize: 36,
                      ),
                    ),
                    TextSpan(
                      text: 'Photos',
                      style: AppFonts.displayMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: AppFonts.black_w,
                        fontSize: 36,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // ── Comparison Card ──────────────────────────────────────
              const ComparisonCard(),

              const SizedBox(height: 32),

              // ── All Photos Grid ──────────────────────────────────────
              Text(
                AppStrings.allPhotos,
                style: AppFonts.labelSmall.copyWith(
                  color: AppColors.textMuted,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 16),
              
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.85,
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  List<String> months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
                  bool isLast = index == 5;
                  return _buildMonthPhotoTile(months[index], isLast);
                },
              ),

              const SizedBox(height: 24),

              // ── Next Check-in Banner ─────────────────────────────────
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppStrings.nextCheckIn,
                      style: AppFonts.bodyMedium.copyWith(color: AppColors.textSecondary),
                    ),
                    Text(
                      AppStrings.inThreeDays,
                      style: AppFonts.titleMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // ── Take New Photo Button ────────────────────────────────
              Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.4),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('📸', style: TextStyle(fontSize: 20)),
                      const SizedBox(width: 12),
                      Text(
                        AppStrings.takeNewPhoto,
                        style: AppFonts.button.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMonthPhotoTile(String month, bool isCurrent) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isCurrent ? AppColors.primary.withOpacity(0.5) : AppColors.border,
          width: isCurrent ? 1.5 : 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isCurrent ? Icons.fitness_center_rounded : Icons.person_outline_rounded,
            size: 32,
            color: isCurrent ? AppColors.primary.withOpacity(0.6) : AppColors.textMuted.withOpacity(0.3),
          ),
          const SizedBox(height: 12),
          Text(
            month,
            style: AppFonts.labelSmall.copyWith(fontSize: 10, color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}
