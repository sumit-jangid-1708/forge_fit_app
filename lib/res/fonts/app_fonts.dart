import 'package:flutter/material.dart';
import '../color/app_color.dart';

/// ForgeFit Typography System
/// Primary Font: Helvetica Neue (via HelveticaNeue asset)
/// Fallback: SF Pro / Roboto
class AppFonts {
  AppFonts._();

  // ─── Font Family ──────────────────────────────────────────────
  static const String primary        = 'HelveticaNeue';
  static const String fallback       = 'Roboto';

  // ─── Font Asset Paths ─────────────────────────────────────────
  static const String thin           = 'assets/fonts/HelveticaNeue-Thin.ttf';
  static const String light          = 'assets/fonts/HelveticaNeue-Light.ttf';
  static const String regular        = 'assets/fonts/HelveticaNeue-Regular.ttf';
  static const String medium         = 'assets/fonts/HelveticaNeue-Medium.ttf';
  static const String bold           = 'assets/fonts/HelveticaNeue-Bold.ttf';
  static const String heavy          = 'assets/fonts/HelveticaNeue-Heavy.ttf';
  static const String black          = 'assets/fonts/HelveticaNeue-Black.ttf';

  // ─── Font Weights ─────────────────────────────────────────────
  static const FontWeight thin_w       = FontWeight.w100;
  static const FontWeight light_w      = FontWeight.w300;
  static const FontWeight regular_w    = FontWeight.w400;
  static const FontWeight medium_w     = FontWeight.w500;
  static const FontWeight semiBold_w   = FontWeight.w600;
  static const FontWeight bold_w       = FontWeight.w700;
  static const FontWeight extraBold_w  = FontWeight.w800;
  static const FontWeight black_w      = FontWeight.w900;

  // ─── Text Styles ──────────────────────────────────────────────

  /// Hero / App name — 44px Black
  static const TextStyle displayLarge = TextStyle(
    fontFamily: primary,
    fontSize: 44,
    fontWeight: black_w,
    color: AppColors.textPrimary,
    letterSpacing: -1.5,
    height: 1.0,
  );

  /// Page title — 32px ExtraBold
  static const TextStyle displayMedium = TextStyle(
    fontFamily: primary,
    fontSize: 32,
    fontWeight: extraBold_w,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
    height: 1.15,
  );

  /// Section heading — 24px ExtraBold
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: primary,
    fontSize: 24,
    fontWeight: extraBold_w,
    color: AppColors.textPrimary,
    letterSpacing: -0.3,
    height: 1.2,
  );

  /// Card title — 20px Bold
  static const TextStyle headlineMedium = TextStyle(
    fontFamily: primary,
    fontSize: 20,
    fontWeight: bold_w,
    color: AppColors.textPrimary,
    letterSpacing: -0.2,
    height: 1.2,
  );

  /// Sub-section title — 18px Bold
  static const TextStyle headlineSmall = TextStyle(
    fontFamily: primary,
    fontSize: 18,
    fontWeight: bold_w,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  /// Label / item title — 16px SemiBold
  static const TextStyle titleLarge = TextStyle(
    fontFamily: primary,
    fontSize: 16,
    fontWeight: semiBold_w,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  /// Secondary label — 15px Medium
  static const TextStyle titleMedium = TextStyle(
    fontFamily: primary,
    fontSize: 15,
    fontWeight: medium_w,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  /// Small label — 14px Medium
  static const TextStyle titleSmall = TextStyle(
    fontFamily: primary,
    fontSize: 14,
    fontWeight: medium_w,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  /// Body text — 14px Regular
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: primary,
    fontSize: 14,
    fontWeight: regular_w,
    color: AppColors.textSecondary,
    height: 1.6,
  );

  /// Secondary body — 13px Regular
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: primary,
    fontSize: 13,
    fontWeight: regular_w,
    color: AppColors.textSecondary,
    height: 1.6,
  );

  /// Caption text — 12px Regular
  static const TextStyle bodySmall = TextStyle(
    fontFamily: primary,
    fontSize: 12,
    fontWeight: regular_w,
    color: AppColors.textMuted,
    height: 1.5,
  );

  /// Tag / badge — 11px Bold uppercase
  static const TextStyle labelLarge = TextStyle(
    fontFamily: primary,
    fontSize: 11,
    fontWeight: bold_w,
    color: AppColors.primary,
    letterSpacing: 2.5,
  );

  /// Micro label — 10px Bold uppercase
  static const TextStyle labelMedium = TextStyle(
    fontFamily: primary,
    fontSize: 10,
    fontWeight: bold_w,
    color: AppColors.textMuted,
    letterSpacing: 2.0,
  );

  /// Tiny tag — 9px Bold uppercase
  static const TextStyle labelSmall = TextStyle(
    fontFamily: primary,
    fontSize: 9,
    fontWeight: bold_w,
    color: AppColors.textMuted,
    letterSpacing: 1.5,
  );

  /// Stat number — 36px Black
  static const TextStyle statLarge = TextStyle(
    fontFamily: primary,
    fontSize: 36,
    fontWeight: black_w,
    color: AppColors.textPrimary,
    letterSpacing: -1.0,
    height: 1.0,
  );

  /// Button text — 16px ExtraBold
  static const TextStyle button = TextStyle(
    fontFamily: primary,
    fontSize: 16,
    fontWeight: extraBold_w,
    color: AppColors.white,
    letterSpacing: 0.5,
  );
}
