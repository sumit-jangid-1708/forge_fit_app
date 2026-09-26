// lib/view/home/widgets/profile_stats.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../res/color/app_color.dart';
import '../../../res/fonts/app_fonts.dart';
import '../../../res/routes/routes_name.dart';
import '../../../view_models/controllers/profile_controller.dart';

class ProfileStats extends StatelessWidget {
  const ProfileStats({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();

    return Obx(() => Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color:        AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(24),
        border:       Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // ✅ Workouts — Hive se
          _buildStatItem(
            value:  controller.workoutsCount.value.toString(),
            label:  'WORKOUTS',
            onTap:  () {},
          ),
          _buildDivider(),
          // ✅ Streak — Hive se
          _buildStatItem(
            value:  controller.streakCount.value.toString(),
            label:  'STREAK',
            onTap:  () => Get.toNamed(RouteName.badgesScreen),
          ),
          _buildDivider(),
          // ✅ Badges — Hive se
          _buildStatItem(
            value:  controller.badgesCount.value.toString(),
            label:  'BADGES',
            onTap:  () => Get.toNamed(RouteName.badgesScreen),
          ),
        ],
      ),
    ));
  }

  Widget _buildStatItem({
    required String value,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            value,
            style: AppFonts.headlineLarge.copyWith(
              fontSize:   24,
              fontWeight: AppFonts.black_w,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppFonts.labelSmall.copyWith(
              color:    AppColors.textMuted,
              fontSize: 10,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 2,
            width:  20,
            decoration: BoxDecoration(
              color:        AppColors.primary,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 40,
      width:  1,
      color:  AppColors.border,
    );
  }
}