import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../res/color/app_color.dart';
import '../../res/fonts/app_fonts.dart';
import '../../view_models/controllers/dashboard_controller.dart';
import 'home_view.dart';
import 'train_view.dart';
import 'forge_view.dart';
import 'stats_view.dart';
import 'profile_view.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());

    final List<Widget> screens = [
      const HomeView(),
      const TrainView(),
      const ForgeView(),
      const StatsView(),
      const ProfileView(),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Obx(() => screens[controller.currentIndex]),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            color: const Color(0xFF111111).withOpacity(0.9),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.border, width: 1),
          ),
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, Icons.home_outlined, 'HOME', controller),
                _buildNavItem(1, Icons.fitness_center_rounded, 'TRAIN', controller),
                _buildForgeItem(2, controller),
                _buildNavItem(3, Icons.bar_chart_rounded, 'STATS', controller),
                _buildNavItem(4, Icons.person_outline_rounded, 'PROFILE', controller),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label, DashboardController controller) {
    bool isActive = controller.currentIndex == index;
    return GestureDetector(
      onTap: () => controller.changeIndex(index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Active indicator line
          Container(
            height: 3,
            width: 20,
            decoration: BoxDecoration(
              color: isActive ? AppColors.primary : Colors.transparent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 8),
          Icon(
            icon,
            color: isActive ? AppColors.primary : AppColors.textMuted,
            size: 26,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppFonts.labelSmall.copyWith(
              color: isActive ? AppColors.primary : AppColors.textMuted,
              fontSize: 9,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForgeItem(int index, DashboardController controller) {
    bool isActive = controller.currentIndex == index;
    return GestureDetector(
      onTap: () => controller.changeIndex(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 12,
                  spreadRadius: 2,
                )
              ],
            ),
            child: const Icon(
              Icons.bolt_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'FORGE',
            style: AppFonts.labelSmall.copyWith(
              color: isActive ? AppColors.primary : AppColors.textMuted,
              fontSize: 9,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
