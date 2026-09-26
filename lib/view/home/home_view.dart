// lib/view/home/home_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../res/color/app_color.dart';
import '../../res/fonts/app_fonts.dart';
import '../../res/routes/routes_name.dart';
import '../../view_models/controllers/dashboard_controller.dart';
import '../../view_models/controllers/home_controller.dart';
import 'widgets/activity_overview.dart';
import 'widgets/metric_card.dart';
import 'widgets/streak_card.dart';
import 'widgets/workout_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ HomeController inject karo
    final homeController      = Get.put(HomeController());
    final dashboardController = Get.find<DashboardController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              // ── Top Bar ──────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.menu_rounded,
                      color: AppColors.white, size: 28),
                  GestureDetector(
                    onTap: () => Get.toNamed(RouteName.badgesScreen),
                    child: Stack(
                      children: [
                        const Icon(Icons.notifications_none_rounded,
                            color: AppColors.white, size: 28),
                        Positioned(
                          right: 4,
                          top:   4,
                          child: Container(
                            height: 8,
                            width:  8,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ── Greeting & Streak — Obx se dynamic ──────────
              Obx(() => Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          homeController.greeting.value,
                          style: AppFonts.bodyMedium.copyWith(
                            color: AppColors.textMuted,
                          ),
                        ),
                        const SizedBox(height: 4),
                        // ✅ Hive se naam aa raha hai
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: homeController.userName.value,
                                style: AppFonts.headlineLarge.copyWith(
                                  fontSize:   32,
                                  fontWeight: AppFonts.black_w,
                                ),
                              ),
                              TextSpan(
                                text: ' 👊',
                                style: AppFonts.headlineLarge.copyWith(
                                  fontSize: 28,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        // ✅ Aaj ki date dynamic
                        Text(
                          homeController.todayDate.value,
                          style: AppFonts.bodySmall.copyWith(
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // ✅ Streak dynamic
                  GestureDetector(
                    onTap: () => Get.toNamed(RouteName.badgesScreen),
                    child: StreakCard(streak: homeController.streak.value),
                  ),
                ],
              )),

              const SizedBox(height: 32),

              // ── Activity Overview ─────────────────────────────
              GestureDetector(
                onTap: () => dashboardController.changeIndex(3),
                child: const ActivityOverview(),
              ),

              const SizedBox(height: 24),

              // ── Metrics Grid — Obx se dynamic ────────────────
              Obx(() => GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount:   2,
                crossAxisSpacing: 16,
                mainAxisSpacing:  16,
                childAspectRatio: 1.1,
                children: [
                  MetricCard(
                    title:         'Steps',
                    value:         homeController.steps.value
                        .toString()
                        .replaceAllMapped(
                      RegExp(r'(\d)(?=(\d{3})+$)'),
                          (m) => '${m[1]},',
                    ),
                    unit:          '',
                    goal:          '${homeController.stepsGoal.value ~/ 1000}k',
                    progress:      homeController.stepsProgress,
                    progressColor: AppColors.primary,
                    onTap:         () => Get.toNamed(RouteName.stepCounterScreen),
                  ),
                  MetricCard(
                    title:         'Water',
                    value:         homeController.water.value
                        .toStringAsFixed(1),
                    unit:          'L',
                    goal:          '${homeController.waterGoal.value} L',
                    progress:      homeController.waterProgress,
                    progressColor: AppColors.info,
                    onTap:         () => Get.toNamed(RouteName.waterTrackerScreen),
                  ),
                  MetricCard(
                    title:         'Calories',
                    value:         homeController.calories.value
                        .toString()
                        .replaceAllMapped(
                      RegExp(r'(\d)(?=(\d{3})+$)'),
                          (m) => '${m[1]},',
                    ),
                    unit:          'kcal',
                    goal:          '${homeController.caloriesGoal.value} kcal',
                    progress:      homeController.caloriesProgress,
                    progressColor: AppColors.primary,
                    onTap:         () => dashboardController.changeIndex(3),
                  ),
                  MetricCard(
                    title:         'Sleep',
                    value:         homeController.sleep.value
                        .toStringAsFixed(1),
                    unit:          'h',
                    goal:          '${homeController.sleepGoal.value.toStringAsFixed(0)} h',
                    progress:      homeController.sleepProgress,
                    progressColor: Colors.deepPurpleAccent,
                    onTap:         () => dashboardController.changeIndex(3),
                  ),
                ],
              )),

              const SizedBox(height: 24),

              // ── Featured Workout ──────────────────────────────
              GestureDetector(
                onTap: () => dashboardController.changeIndex(1),
                child: const WorkoutCard(),
              ),

              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }
}