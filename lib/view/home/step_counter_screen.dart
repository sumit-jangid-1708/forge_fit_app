import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../res/app_strings/app_strings.dart';
import '../../res/color/app_color.dart';
import '../../res/fonts/app_fonts.dart';
import '../../view_models/controllers/step_counter_controller.dart';
import 'widgets/activity_stats_row.dart';
import 'widgets/hourly_activity_chart.dart';
import 'widgets/step_progress_indicator.dart';

class StepCounterScreen extends StatelessWidget {
  const StepCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StepCounterController());

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
                  Row(
                    children: [
                      // ✅ Reset Button
                      GestureDetector(
                        onTap: controller.resetSteps,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color:        AppColors.surfaceLight,
                            borderRadius: BorderRadius.circular(12),
                            border:       Border.all(color: AppColors.border),
                          ),
                          child: const Icon(
                            Icons.refresh_rounded,
                            color: AppColors.error,
                            size:  18,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // ✅ Goal change button
                      GestureDetector(
                        onTap: controller.showGoalDialog,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color:        AppColors.surfaceLight,
                            borderRadius: BorderRadius.circular(12),
                            border:       Border.all(color: AppColors.border),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.track_changes_rounded,
                                color: AppColors.primary,
                                size:  16,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Set Goal',
                                style: AppFonts.labelSmall.copyWith(
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ── Header ─────────────────────────────────────
              Text(
                AppStrings.activity,
                style: AppFonts.labelSmall.copyWith(
                  color:        AppColors.primary,
                  letterSpacing: 2,
                  fontWeight:   FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:  'Step ',
                      style: AppFonts.displayMedium.copyWith(
                        fontWeight: AppFonts.black_w,
                        fontSize:   36,
                      ),
                    ),
                    TextSpan(
                      text:  'Counter',
                      style: AppFonts.displayMedium.copyWith(
                        color:      AppColors.primary,
                        fontWeight: AppFonts.black_w,
                        fontSize:   36,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // ── Step Progress Ring — Obx ───────────────────
              Obx(() => StepProgressIndicator(
                steps: controller.steps.value,
                goal:  controller.goal.value,
              )),

              const SizedBox(height: 40),

              // ── Stats Row — Obx ────────────────────────────
              Obx(() => ActivityStatsRow(
                km:   controller.km,
                kcal: controller.kcal,
                min:  controller.min,
              )),

              const SizedBox(height: 32),

              // ── Hourly Chart — Obx ─────────────────────────
              Obx(() => HourlyActivityChart(
                data:          controller.hourlyData,
                peakHourIndex: controller.peakHourIndex,
              )),

              const SizedBox(height: 24),

              // ── Goal Remaining Banner — Obx ────────────────
              Obx(() => Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color:        AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(24),
                  border:       Border.all(
                    color: AppColors.borderOrange.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color:  AppColors.primary.withOpacity(0.1),
                        shape:  BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.track_changes_rounded,
                        color: AppColors.primary,
                        size:  24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ✅ Goal reached check
                          controller.remaining == 0
                              ? Text(
                            '🎉 Goal Reached!',
                            style: AppFonts.titleLarge.copyWith(
                              color:      AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                              : RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '${controller.remainingFormatted} ',
                                  style: AppFonts.titleLarge.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text:  AppStrings.moreStepsGoal,
                                  style: AppFonts.bodySmall.copyWith(
                                    color: AppColors.textMuted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            AppStrings.keepItUp,
                            style: AppFonts.bodySmall.copyWith(
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),

              const SizedBox(height: 16),

              // ── Test Button — remove in production ─────────
              // Real pedometer se replace karo baad mein
              Container(
                width:  double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  color:        AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(20),
                  border:       Border.all(color: AppColors.border),
                ),
                child: TextButton.icon(
                  onPressed: () => controller.addSteps(500),
                  icon: const Icon(Icons.add, color: AppColors.primary),
                  label: Text(
                    '+ 500 Steps (Test)',
                    style: AppFonts.button.copyWith(
                      color:    AppColors.primary,
                      fontSize: 14,
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
}
