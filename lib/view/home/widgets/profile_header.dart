// lib/view/home/widgets/profile_header.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../res/color/app_color.dart';
import '../../../res/fonts/app_fonts.dart';
import '../../../view_models/controllers/profile_controller.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ ProfileController find karo — ProfileView ne inject kiya hoga
    final controller = Get.put(ProfileController());

    return Container(
      width: double.infinity,
      height: 220,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image:     AssetImage('assets/images/beast.png'),
          fit:       BoxFit.cover,
          alignment: Alignment.topRight,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin:  Alignment.centerLeft,
            end:    Alignment.centerRight,
            colors: [
              AppColors.background,
              AppColors.background.withOpacity(0.8),
              AppColors.background.withOpacity(0.2),
            ],
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Obx(() => Row(
          children: [
            // ── Avatar ──────────────────────────────────────
            Container(
              height: 80,
              width:  80,
              decoration: BoxDecoration(
                shape:     BoxShape.circle,
                border:    Border.all(color: AppColors.primary, width: 2),
                boxShadow: [
                  BoxShadow(
                    color:       AppColors.primary.withOpacity(0.5),
                    blurRadius:  20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: CircleAvatar(
                backgroundColor: AppColors.surfaceLight,
                // ✅ Naam ka pehla letter
                child: Text(
                  controller.avatarLetter.value,
                  style: const TextStyle(
                    fontSize:   32,
                    fontWeight: FontWeight.bold,
                    color:      Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 20),

            // ── User Info ────────────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment:  MainAxisAlignment.center,
                children: [
                  // ✅ Hive se naam
                  Text(
                    controller.userName.value.isEmpty
                        ? 'Champion'
                        : controller.userName.value,
                    style: AppFonts.headlineLarge.copyWith(
                      fontSize:   28,
                      fontWeight: AppFonts.black_w,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        width:  2,
                        height: 12,
                        color:  AppColors.primary,
                      ),
                      const SizedBox(width: 8),
                      // ✅ Hive se goal
                      Expanded(
                        child: Text(
                          controller.userGoal.value.isEmpty
                              ? 'Set your goal'
                              : '${controller.userGoal.value} · Advanced',
                          style: AppFonts.bodySmall.copyWith(
                            color: AppColors.textMuted,
                          ),
                          maxLines:  1,
                          overflow:  TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // ✅ Streak dynamic
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical:   6,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.borderOrange),
                      color:  AppColors.primary.withOpacity(0.05),
                    ),
                    child: Text(
                      controller.streakCount.value == 0
                          ? 'Start your streak 🔥'
                          : '${controller.streakCount.value}-day streak 🔥',
                      style: AppFonts.labelSmall.copyWith(
                        color:       AppColors.primary,
                        fontSize:    10,
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}