import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../res/color/app_color.dart';
import '../../res/fonts/app_fonts.dart';
import '../../res/routes/routes_name.dart';
import 'widgets/step_count_card.dart';
import 'widgets/weekly_workouts_card.dart';
import 'widgets/weight_card.dart';

class StatsView extends StatelessWidget {
  const StatsView({super.key});

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
              
              // ── Header ─────────────────────────────────────────────
              Text(
                'ANALYTICS',
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
                      text: 'Your ',
                      style: AppFonts.displayMedium.copyWith(
                        fontWeight: AppFonts.black_w,
                        fontSize: 36,
                      ),
                    ),
                    TextSpan(
                      text: 'Progress',
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

              // ── Weekly Workouts Card ───────────────────────────────
              const WeeklyWorkoutsCard(),

              const SizedBox(height: 20),

              // ── Body Weight Card (Click to open Weight Tracker) ────
              GestureDetector(
                onTap: () => Get.toNamed(RouteName.weightTrackerScreen),
                child: const WeightCard(),
              ),

              const SizedBox(height: 20),

              // ── Step Count Card (Click to open Step Counter) ──────
              GestureDetector(
                onTap: () => Get.toNamed(RouteName.stepCounterScreen),
                child: const StepCountCard(),
              ),

              const SizedBox(height: 120), // Bottom nav space
            ],
          ),
        ),
      ),
    );
  }
}
