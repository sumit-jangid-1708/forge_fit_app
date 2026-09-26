import 'package:flutter/material.dart';
import '../res/color/app_color.dart';
import '../res/fonts/app_fonts.dart';
import 'app_alerts.dart';

class Utils {
  Utils._();

  // ─── Focus Management ─────────────────────────────────────────
  static void fieldFocusChange(
      BuildContext context,
      FocusNode current,
      FocusNode nextFocus,
      ) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static void hideKeyboard(BuildContext context) =>
      FocusScope.of(context).unfocus();

  // ─── Validation ───────────────────────────────────────────────
  static bool isEmailValid(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
      caseSensitive: false,
    );
    return emailRegex.hasMatch(email.trim());
  }

  static bool isPasswordValid(String password) => password.length >= 8;

  static bool isNameValid(String name) => name.trim().length >= 2;

  static bool isPhoneValid(String phone) {
    final phoneRegex = RegExp(r'^[0-9]{10}$');
    return phoneRegex.hasMatch(phone.trim());
  }

  // ─── Toast ────────────────────────────────────────────────────
  static void snackBar(String title, String message) =>
      AppAlerts.info(message);

  // ─── ForgeFit InputDecoration ─────────────────────────────────
  static InputDecoration forgefitInputDecoration({
    required String hint,
    required IconData icon,
    Widget? suffixWidget,
    String? label,
  }) {
    return InputDecoration(
      hintText:         hint,
      labelText:        label,
      prefixIcon:       Icon(icon, color: AppColors.textMuted, size: 20),
      suffixIcon:       suffixWidget,
      filled:           true,
      fillColor:        AppColors.surface,
      hintStyle:        AppFonts.bodyLarge.copyWith(color: AppColors.textMuted),
      labelStyle:       AppFonts.labelMedium.copyWith(
        color:          AppColors.textMuted,
        letterSpacing:  1.5,
      ),
      contentPadding:   const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      border:           OutlineInputBorder(
        borderRadius:   BorderRadius.circular(16),
        borderSide:     const BorderSide(color: AppColors.border),
      ),
      enabledBorder:    OutlineInputBorder(
        borderRadius:   BorderRadius.circular(16),
        borderSide:     const BorderSide(color: AppColors.border),
      ),
      focusedBorder:    OutlineInputBorder(
        borderRadius:   BorderRadius.circular(16),
        borderSide:     const BorderSide(color: AppColors.primary, width: 1.5),
      ),
      errorBorder:      OutlineInputBorder(
        borderRadius:   BorderRadius.circular(16),
        borderSide:     const BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius:   BorderRadius.circular(16),
        borderSide:     const BorderSide(color: AppColors.error, width: 1.5),
      ),
    );
  }

  // ─── Greeting based on time ───────────────────────────────────
  static String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning,';
    if (hour < 17) return 'Good afternoon,';
    return 'Good evening,';
  }

  // ─── Number Formatting ────────────────────────────────────────
  static String formatSteps(int steps) {
    if (steps >= 1000) {
      return '${(steps / 1000).toStringAsFixed(1)}k';
    }
    return steps.toString();
  }

  static String formatWeight(double kg) => '${kg.toStringAsFixed(1)} kg';

  static String formatWater(double liters) => '${liters.toStringAsFixed(1)} L';

  static String formatCalories(int cal) => '$cal kcal';

  // ─── Date Formatting ──────────────────────────────────────────
  static String formatDate(DateTime dt) {
    const months = [
      'Jan','Feb','Mar','Apr','May','Jun',
      'Jul','Aug','Sep','Oct','Nov','Dec',
    ];
    const days = ['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'];
    return '${days[dt.weekday - 1]}, ${dt.day} ${months[dt.month - 1]}';
  }

  // ─── Page Route Transition ────────────────────────────────────
  static Route<T> fadeRoute<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (_, __, ___) => page,
      transitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (_, animation, __, child) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
          child:   child,
        );
      },
    );
  }

  static Route<T> slideUpRoute<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (_, __, ___) => page,
      transitionDuration: const Duration(milliseconds: 350),
      transitionsBuilder: (_, animation, __, child) {
        final tween = Tween(begin: const Offset(0, 0.08), end: Offset.zero)
            .chain(CurveTween(curve: Curves.easeOutCubic));
        return FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
          child: SlideTransition(position: animation.drive(tween), child: child),
        );
      },
    );
  }
}
