import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../res/app_strings/app_strings.dart';
import '../../res/color/app_color.dart';
import '../../res/fonts/app_fonts.dart';
import '../../view_models/controllers/weight_tracker_controller.dart';
import 'widgets/recent_weight_log_tile.dart';
import 'widgets/weight_progress_chart.dart';
import 'widgets/weight_stat_box.dart';

class WeightTrackerScreen extends StatelessWidget {
  const WeightTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WeightTrackerController());

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

              const SizedBox(height: 24),

              // ── Header ─────────────────────────────────────
              Text(
                AppStrings.bodyStats,
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
                      text:  'Weight ',
                      style: AppFonts.displayMedium.copyWith(
                        fontWeight: AppFonts.black_w,
                        fontSize:   36,
                      ),
                    ),
                    TextSpan(
                      text:  'Tracker',
                      style: AppFonts.displayMedium.copyWith(
                        color:      AppColors.primary,
                        fontWeight: AppFonts.black_w,
                        fontSize:   36,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // ── Chart — Obx se dynamic ─────────────────────
              Obx(() => WeightProgressChart(
                currentWeight: controller.currentWeight.value,
                lostKg:        controller.lostKg,
                lostPercent:   controller.lostPercent,
                chartPoints:   controller.chartPoints,
              )),

              const SizedBox(height: 24),

              // ── Stats Row ──────────────────────────────────
              Obx(() => Row(
                children: [
                  WeightStatBox(
                    value: controller.startWeight.value > 0
                        ? controller.startWeight.value.toStringAsFixed(1)
                        : '--',
                    label: AppStrings.startKg,
                  ),
                  const SizedBox(width: 12),
                  WeightStatBox(
                    value: controller.goalWeight.value > 0
                        ? controller.goalWeight.value.toStringAsFixed(1)
                        : '--',
                    label: AppStrings.goalKg,
                  ),
                  const SizedBox(width: 12),
                  WeightStatBox(
                    value: controller.goalWeight.value > 0
                        ? controller.toGoKg.toStringAsFixed(1)
                        : '--',
                    label: AppStrings.toGoKg,
                  ),
                ],
              )),

              const SizedBox(height: 32),

              // ── Recent Logs ────────────────────────────────
              Text(
                AppStrings.recentLogs,
                style: AppFonts.labelSmall.copyWith(
                  color:        AppColors.textMuted,
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
                        'No entries yet — log your first weight! ⚖️',
                        style: AppFonts.bodyMedium.copyWith(
                          color: AppColors.textMuted,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
                return Column(
                  children: controller.logs.take(7).map((entry) {
                    return RecentWeightLogTile(
                      date:   entry.date,
                      time:   entry.time,
                      weight: entry.weight.toStringAsFixed(1),
                      diff:   entry.diff,
                      isLoss: entry.isLoss,
                    );
                  }).toList(),
                );
              }),

              const SizedBox(height: 24),

              // ── Log Button ─────────────────────────────────
              GestureDetector(
                onTap: controller.showLogWeightDialog,
                child: Container(
                  width:  double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color:        AppColors.primary,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color:      AppColors.primary.withOpacity(0.4),
                        blurRadius: 15,
                        offset:     const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      AppStrings.logTodayWeight,
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
}