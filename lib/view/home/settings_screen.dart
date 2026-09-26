import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../res/app_strings/app_strings.dart';
import '../../res/color/app_color.dart';
import '../../res/fonts/app_fonts.dart';
import '../../view_models/controllers/auth_controller.dart';
import 'widgets/settings_unit_toggle.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              
              // ── Back Button ──────────────────────────────────────────
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

              // ── Title Section ─────────────────────────────────────────
              Text(
                AppStrings.preferences,
                style: AppFonts.labelSmall.copyWith(
                  color: AppColors.primary,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                AppStrings.settings,
                style: AppFonts.displayMedium.copyWith(
                  fontWeight: AppFonts.black_w,
                  fontSize: 36,
                ),
              ),

              const SizedBox(height: 32),

              // ── Notifications Section ─────────────────────────────────
              _buildSectionTitle(AppStrings.notifications),
              Container(
                decoration: _sectionDecoration(),
                child: Column(
                  children: [
                    _buildSettingItem(
                      title: AppStrings.workoutReminders,
                      subtitle: 'Get reminded about your workouts',
                      colorBar: AppColors.primary,
                      trailing: _buildSwitch(true),
                    ),
                    _buildDivider(),
                    _buildSettingItem(
                      title: AppStrings.hydrationAlerts,
                      subtitle: 'Stay reminded to drink water',
                      colorBar: AppColors.info,
                      trailing: _buildSwitch(true),
                    ),
                    _buildDivider(),
                    _buildSettingItem(
                      title: AppStrings.achievementAlerts,
                      subtitle: 'Get notified for your achievements',
                      colorBar: AppColors.primary,
                      trailing: _buildSwitch(true),
                    ),
                    _buildDivider(),
                    _buildSettingItem(
                      title: AppStrings.weeklySummary,
                      subtitle: 'Receive your weekly progress summary',
                      colorBar: AppColors.textMuted,
                      trailing: _buildSwitch(false),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // ── Units and Display Section ─────────────────────────────
              _buildSectionTitle(AppStrings.unitsDisplay),
              Container(
                decoration: _sectionDecoration(),
                child: Column(
                  children: [
                    _buildSettingItem(
                      title: AppStrings.weightUnit,
                      subtitle: 'Select your preferred weight unit',
                      trailing: SettingsUnitToggle(
                        firstValue: 'kg',
                        secondValue: 'lbs',
                        isFirstSelected: true,
                        onToggle: (v) {},
                      ),
                    ),
                    _buildDivider(),
                    _buildSettingItem(
                      title: AppStrings.heightUnit,
                      subtitle: 'Select your preferred height unit',
                      trailing: SettingsUnitToggle(
                        firstValue: 'cm',
                        secondValue: 'ft',
                        isFirstSelected: true,
                        onToggle: (v) {},
                      ),
                    ),
                    _buildDivider(),
                    _buildSettingItem(
                      title: AppStrings.darkMode,
                      subtitle: 'Switch between light and dark theme',
                      trailing: _buildSwitch(true),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // ── Account Section ───────────────────────────────────────
              _buildSectionTitle('ACCOUNT'),
              Container(
                decoration: _sectionDecoration(),
                child: Column(
                  children: [
                    _buildSettingItem(
                      title: 'Sign Out',
                      subtitle: 'Log out of your account',
                      colorBar: AppColors.error,
                      titleColor: AppColors.error,
                      showArrow: true,
                      onTap: () => authController.logout(),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ── Danger Zone ───────────────────────────────────────────
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppColors.border),
                ),
                child: _buildSettingItem(
                  title: AppStrings.clearAllData,
                  subtitle: 'This action cannot be undone',
                  colorBar: AppColors.error,
                  titleColor: AppColors.error,
                  showArrow: true,
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 16),
      child: Text(
        title,
        style: AppFonts.labelSmall.copyWith(
          color: AppColors.textMuted,
          letterSpacing: 1.5,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  BoxDecoration _sectionDecoration() {
    return BoxDecoration(
      color: AppColors.surfaceLight,
      borderRadius: BorderRadius.circular(24),
      border: Border.all(color: AppColors.border),
    );
  }

  Widget _buildSettingItem({
    required String title,
    required String subtitle,
    Color? colorBar,
    Widget? trailing,
    Color? titleColor,
    bool showArrow = true,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            if (colorBar != null) ...[
              Container(
                width: 2,
                height: 24,
                decoration: BoxDecoration(
                  color: colorBar,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
              const SizedBox(width: 16),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppFonts.titleMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: titleColor ?? AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: AppFonts.bodySmall.copyWith(color: AppColors.textMuted),
                  ),
                ],
              ),
            ),
            if (trailing != null) ...[
              trailing,
              const SizedBox(width: 12),
            ],
            if (showArrow)
              const Icon(Icons.arrow_forward_ios_rounded, color: AppColors.textMuted, size: 14),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitch(bool value) {
    return Transform.scale(
      scale: 0.8,
      child: Switch(
        value: value,
        onChanged: (v) {},
        activeColor: Colors.white,
        activeTrackColor: AppColors.primary,
        inactiveThumbColor: Colors.white,
        inactiveTrackColor: const Color(0xFF333333),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      color: AppColors.border,
      indent: 16,
      endIndent: 16,
    );
  }
}
