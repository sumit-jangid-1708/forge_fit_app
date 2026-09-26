// lib/view/trackers/water_tracker_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../res/app_strings/app_strings.dart';
import '../../res/color/app_color.dart';
import '../../res/fonts/app_fonts.dart';
import '../../view_models/controllers/water_tracker_controller.dart';
import 'widgets/water_log_tile.dart';
import 'widgets/water_progress_card.dart';

class WaterTrackerScreen extends StatelessWidget {
  const WaterTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Controller inject karo
    final controller = Get.put(WaterTrackerController());

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              // ── Top Bar ────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color:        AppColors.surfaceLight,
                        borderRadius: BorderRadius.circular(12),
                        border:       Border.all(color: AppColors.border),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: AppColors.white,
                        size:  16,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.more_vert_rounded,
                    color: AppColors.textMuted,
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ── Header ─────────────────────────────────────
              Text(
                AppStrings.water.toUpperCase(),
                style: AppFonts.labelSmall.copyWith(
                  color:        AppColors.info,
                  letterSpacing: 2,
                  fontWeight:   FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:  'Water ',
                      style: AppFonts.displayMedium.copyWith(
                        fontWeight: AppFonts.black_w,
                        fontSize:   36,
                      ),
                    ),
                    TextSpan(
                      text:  'Tracker',
                      style: AppFonts.displayMedium.copyWith(
                        color:      AppColors.info,
                        fontWeight: AppFonts.black_w,
                        fontSize:   36,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                AppStrings.stayHydrated,
                style: AppFonts.bodyLarge.copyWith(
                  color: AppColors.textMuted,
                ),
              ),

              const SizedBox(height: 32),

              // ── Progress Card — Obx se dynamic ─────────────
              Obx(() => WaterProgressCard(
                intake:   controller.totalIntake.value,
                goal:     controller.dailyGoal.value,
                progress: controller.progress,
              )),

              const SizedBox(height: 32),

              // ── Today's Log — Obx se dynamic ───────────────
              Text(
                AppStrings.todaysLog,
                style: AppFonts.labelSmall.copyWith(
                  color:        AppColors.info,
                  letterSpacing: 1.5,
                  fontWeight:   FontWeight.w800,
                ),
              ),
              const SizedBox(height: 16),

              Obx(() {
                if (controller.logs.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Center(
                      child: Text(
                        'No entries yet — add your first drink! 💧',
                        style: AppFonts.bodyMedium.copyWith(
                          color: AppColors.textMuted,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
                return Column(
                  children: controller.logs.map((entry) {
                    return WaterLogTile(
                      time:             entry.time,
                      label:            entry.label,
                      amount:           '${entry.amount.toInt()} ml',
                      indicatorColor:   entry.color,
                    );
                  }).toList(),
                );
              }),

              const SizedBox(height: 32),

              // ── Quick Add Buttons ───────────────────────────
              Text(
                AppStrings.quickAdd,
                style: AppFonts.labelSmall.copyWith(
                  color:        AppColors.info,
                  letterSpacing: 1.5,
                  fontWeight:   FontWeight.w800,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildQuickAddButton('+ 250ml', 250, controller),
                  _buildQuickAddButton('+ 500ml', 500, controller),
                  _buildQuickAddButton('+ 750ml', 750, controller),
                ],
              ),

              const SizedBox(height: 32),

              // ── Custom Amount Button ────────────────────────
              GestureDetector(
                onTap: controller.showCustomAmountDialog,
                child: Container(
                  width:  double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color:        AppColors.info.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color:      AppColors.info.withOpacity(0.3),
                        blurRadius: 15,
                        offset:     const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      AppStrings.addCustomAmount,
                      style: AppFonts.button.copyWith(
                        color:    Colors.white,
                        fontSize: 16,
                      ),
                    ),
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

  Widget _buildQuickAddButton(
      String label,
      double ml,
      WaterTrackerController controller,
      ) {
    return GestureDetector(
      onTap: () => controller.addWater(ml),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color:        AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(16),
          border:       Border.all(color: AppColors.info.withOpacity(0.3)),
        ),
        child: Text(
          label,
          style: AppFonts.labelSmall.copyWith(
            color:        AppColors.info,
            fontWeight:   FontWeight.bold,
            letterSpacing: 0,
          ),
        ),
      ),
    );
  }
}