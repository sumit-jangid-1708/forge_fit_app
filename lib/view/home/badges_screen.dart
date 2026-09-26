import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../res/app_strings/app_strings.dart';
import '../../res/color/app_color.dart';
import '../../res/fonts/app_fonts.dart';
import 'widgets/badge_tile.dart';

class BadgesScreen extends StatelessWidget {
  const BadgesScreen({super.key});

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

              // ── Header ───────────────────────────────────────────────
              Text(
                AppStrings.hallOfForge,
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
                      text: 'Badges',
                      style: AppFonts.displayMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: AppFonts.black_w,
                        fontSize: 36,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                AppStrings.badgeSubtitle,
                style: AppFonts.bodyLarge.copyWith(color: AppColors.textMuted),
              ),

              const SizedBox(height: 32),

              // ── Summary Card ─────────────────────────────────────────
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(color: AppColors.borderOrange.withOpacity(0.2)),
                ),
                child: Row(
                  children: [
                    Image.asset('assets/images/price.png', height: 80),
                    const SizedBox(width: 24),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.totalEarned,
                            style: AppFonts.labelSmall.copyWith(fontSize: 9, color: AppColors.textMuted),
                          ),
                          const SizedBox(height: 4),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '4 ',
                                  style: AppFonts.headlineLarge.copyWith(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: AppStrings.ofEighteen,
                                  style: AppFonts.bodySmall.copyWith(color: AppColors.textMuted),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          AppStrings.rank.toUpperCase(),
                          style: AppFonts.labelSmall.copyWith(fontSize: 9, color: AppColors.textMuted),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          AppStrings.iron,
                          style: AppFonts.headlineMedium.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // ── Earned Badges Section ────────────────────────────────
              Text(
                AppStrings.earned,
                style: AppFonts.labelSmall.copyWith(
                  color: AppColors.textMuted,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 16),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.85,
                children: const [
                  BadgeTile(
                    title: AppStrings.ironWill,
                    subtitle: AppStrings.sevenDayStreak,
                    icon: Icons.shield_rounded,
                    isEarned: true,
                  ),
                  BadgeTile(
                    title: AppStrings.firstForge,
                    subtitle: AppStrings.firstWorkout,
                    icon: Icons.bolt_rounded,
                    isEarned: true,
                  ),
                  BadgeTile(
                    title: AppStrings.onFire,
                    subtitle: AppStrings.fourteenDayStreak,
                    icon: Icons.local_fire_department_rounded,
                    isEarned: true,
                  ),
                  BadgeTile(
                    title: AppStrings.hydroHero,
                    subtitle: AppStrings.sevenDaysWater,
                    icon: Icons.opacity_rounded,
                    isEarned: true,
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // ── Locked Badges Section ────────────────────────────────
              Text(
                AppStrings.locked,
                style: AppFonts.labelSmall.copyWith(
                  color: AppColors.textMuted,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildLockedBadge(AppStrings.diamond, AppStrings.thirtyDayStreak, Icons.diamond_rounded),
                    const SizedBox(width: 16),
                    _buildLockedBadge(AppStrings.century, AppStrings.hundredWorkouts, Icons.workspace_premium_rounded),
                    const SizedBox(width: 16),
                    _buildLockedBadge(AppStrings.titan, AppStrings.eliteRank, Icons.military_tech_rounded),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLockedBadge(String title, String subtitle, IconData icon) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Icon(Icons.lock_outline_rounded, color: AppColors.textMuted, size: 16),
          ),
          Icon(icon, size: 40, color: AppColors.textMuted.withOpacity(0.3)),
          const SizedBox(height: 16),
          Text(
            title,
            style: AppFonts.titleSmall.copyWith(color: AppColors.textMuted, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: AppFonts.bodySmall.copyWith(fontSize: 9, color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}
