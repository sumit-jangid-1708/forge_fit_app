import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../res/color/app_color.dart';
import '../../res/fonts/app_fonts.dart';
import '../../res/routes/routes_name.dart';
import '../../view_models/controllers/auth_controller.dart';
import '../../view_models/controllers/profile_controller.dart';
import 'widgets/profile_header.dart';
import 'widgets/profile_menu_item.dart';
import 'widgets/profile_stats.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    // AuthController ko inject kiya logout use karne ke liye
    final authController = Get.put(AuthController());
    final profileController = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Profile Header with Image & Glow ──────────────────────
            const ProfileHeader(),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  
                  // ── Workouts, Streak, Badges Stats ────────────────────
                  const ProfileStats(),

                  const SizedBox(height: 32),

                  // ── My Account Section ────────────────────────────────
                  Text(
                    'MY ACCOUNT',
                    style: AppFonts.labelSmall.copyWith(
                      color: AppColors.textMuted,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ProfileMenuItem(
                    icon: Icons.bar_chart_rounded,
                    title: 'Body Measurements',
                    subtitle: 'Track your physical stats',
                    onTap: () {},
                  ),
                  ProfileMenuItem(
                    icon: Icons.image_outlined,
                    title: 'Progress Photos',
                    subtitle: 'View your transformation',
                    onTap: () {
                      Get.toNamed(RouteName.progressPhotosScreen);
                    },
                  ),
                  ProfileMenuItem(
                    icon: Icons.track_changes_rounded,
                    title: 'Goals and Targets',
                    subtitle: 'Set and manage your goals',
                    onTap: () {},
                  ),

                  const SizedBox(height: 24),

                  // ── Preferences Section ───────────────────────────────
                  Text(
                    'PREFERENCES',
                    style: AppFonts.labelSmall.copyWith(
                      color: AppColors.textMuted,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ProfileMenuItem(
                    icon: Icons.notifications_none_rounded,
                    title: 'Notifications',
                    subtitle: 'Stay updated with activity',
                    onTap: () {},
                    trailing: Switch(
                      value: true,
                      onChanged: (v) {},
                      activeColor: AppColors.primary,
                    ),
                  ),
                  ProfileMenuItem(
                    icon: Icons.settings_outlined,
                    title: 'Settings',
                    subtitle: 'Customize your experience',
                    onTap: () {
                      Get.toNamed(RouteName.settingsScreen);
                    },
                  ),
                  ProfileMenuItem(
                    icon: Icons.shield_outlined,
                    title: 'Privacy and Data',
                    subtitle: 'Manage your data and privacy',
                    onTap: () {},
                  ),

                  const SizedBox(height: 32),

                  // ── Sign Out Button ───────────────────────────────────
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.error.withOpacity(0.3)),
                      gradient: LinearGradient(
                        colors: [
                          AppColors.error.withOpacity(0.05),
                          AppColors.transparent,
                        ],
                      ),
                    ),
                    child: ListTile(
                      onTap: () => authController.logout(),
                      leading: const Icon(Icons.logout_rounded, color: AppColors.error),
                      title: Text(
                        'Sign Out',
                        style: AppFonts.titleMedium.copyWith(
                          color: AppColors.error,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 120), // Bottom nav space
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
