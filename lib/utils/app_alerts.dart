import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../res/color/app_color.dart';
import '../res/fonts/app_fonts.dart';

class AppAlerts {
  AppAlerts._();

  // ─── Private Toast Helper ────────────────────────────────────
  static void _showToast({
    required String message,
    required Color bgColor,
    required IconData icon,
  }) {
    Get.rawSnackbar(
      messageText: Text(
        message,
        textAlign: TextAlign.center,
        style: AppFonts.bodyMedium.copyWith(color: AppColors.white),
      ),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: bgColor.withOpacity(0.9),
      borderRadius: 30,
      margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      duration: const Duration(seconds: 2),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
      icon: Icon(icon, color: AppColors.white, size: 18),
      mainButton: null,
      shouldIconPulse: false,
    );
  }

  // ─── Error Toast ─────────────────────────────────────────────
  static void error(String message) {
    _showToast(
      message: message,
      bgColor: const Color(0xFFE53935),
      icon: Icons.error_outline_rounded,
    );
  }

  // ─── Success Toast ───────────────────────────────────────────
  static void success(String message) {
    _showToast(
      message: message,
      bgColor: const Color(0xFF43A047),
      icon: Icons.check_circle_outline_rounded,
    );
  }

  // ─── Info Toast ──────────────────────────────────────────────
  static void info(String message) {
    _showToast(
      message: message,
      bgColor: AppColors.surfaceLight,
      icon: Icons.info_outline_rounded,
    );
  }

  // ─── Loading Dialog ───────────────────────────────────────────
  static void showLoading({String msg = 'Please wait...'}) {
    if (Get.isDialogOpen ?? false) return;
    Get.dialog(
      barrierDismissible: false,
      PopScope(
        canPop: false,
        child: Center(
          child: Container(
            padding:      const EdgeInsets.all(28),
            decoration:   BoxDecoration(
              color:        AppColors.surface,
              borderRadius: BorderRadius.circular(24),
              border:       Border.all(color: AppColors.border),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  width: 40, height: 40,
                  child: CircularProgressIndicator(
                    color:       AppColors.primary,
                    strokeWidth: 3,
                  ),
                ),
                const SizedBox(height: 16),
                Text(msg, style: AppFonts.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static void hideLoading() {
    if (Get.isDialogOpen ?? false) Get.back();
  }

  // ─── Confirm Dialog ───────────────────────────────────────────
  static Future<bool> confirm({
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText  = 'Cancel',
    bool   isDanger    = false,
  }) async {
    final result = await Get.dialog<bool>(
      AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(title, style: AppFonts.headlineSmall),
        content: Text(message, style: AppFonts.bodyLarge),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text(cancelText, style: AppFonts.titleSmall.copyWith(
              color: AppColors.textMuted,
            )),
          ),
          ElevatedButton(
            onPressed: () => Get.back(result: true),
            style: ElevatedButton.styleFrom(
              backgroundColor: isDanger ? AppColors.error : AppColors.primary,
              minimumSize:     const Size(80, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(confirmText, style: AppFonts.button.copyWith(fontSize: 14)),
          ),
        ],
      ),
    );
    return result ?? false;
  }
}
