import 'package:flutter/material.dart';

/// ForgeFit Brand Color Palette
/// Theme: Dark Luxury · Futuristic · Premium
class AppColors {
  AppColors._(); // prevent instantiation

  // ─── Brand Core ───────────────────────────────────────────────
  static const Color primary       = Color(0xFFFF6129); // Main orange
  static const Color secondary     = Color(0xFFFC3B00); // Deep orange-red
  static const Color accent        = Color(0xFFFF7145); // Soft orange glow

  // ─── Backgrounds ──────────────────────────────────────────────
  static const Color background    = Color(0xFF000000); // Pure black
  static const Color surface       = Color(0xFF121212); // Card background
  static const Color surfaceLight  = Color(0xFF1A1A1A); // Elevated surface
  static const Color surfaceMid    = Color(0xFF0E0E0E); // Deeper card

  // ─── Text ─────────────────────────────────────────────────────
  static const Color textPrimary   = Color(0xFFFFFFFF); // White
  static const Color textSecondary = Color(0x99FFFFFF); // 60% white
  static const Color textMuted     = Color(0x4DFFFFFF); // 30% white
  static const Color textHint      = Color(0x33FFFFFF); // 20% white

  // ─── Borders & Dividers ───────────────────────────────────────
  static const Color border        = Color(0x0FFFFFFF); // 6% white
  static const Color borderStrong  = Color(0x1AFFFFFF); // 10% white
  static const Color borderOrange  = Color(0x4DFF6129); // 30% orange

  // ─── Gradients ────────────────────────────────────────────────
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, secondary],
  );

  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF150800), background],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1F0A00), Color(0xFF0F0500)],
  );

  static const LinearGradient glowGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0x33FF6129), Color(0x00000000)],
  );

  // ─── Semantic ─────────────────────────────────────────────────
  static const Color success       = Color(0xFF4CAF50);
  static const Color error         = Color(0xFFFC3B00);
  static const Color warning       = Color(0xFFFF9800);
  static const Color info          = Color(0xFF1E90FF); // Water blue

  // ─── Ring Colors (Activity) ───────────────────────────────────
  static const Color ringMove      = primary;
  static const Color ringExercise  = accent;
  static const Color ringStand     = secondary;

  // ─── Utility ──────────────────────────────────────────────────
  static const Color black         = Color(0xFF000000);
  static const Color white         = Color(0xFFFFFFFF);
  static const Color transparent   = Color(0x00000000);

  // ─── Glow Shadows ─────────────────────────────────────────────
  static List<BoxShadow> get primaryGlow => [
    BoxShadow(
      color: primary.withOpacity(0.35),
      blurRadius: 24,
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: Colors.black.withOpacity(0.4),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
  ];
}
