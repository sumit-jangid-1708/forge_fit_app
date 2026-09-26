import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../color/app_color.dart';
import '../fonts/app_fonts.dart';

/// ForgeFit App Theme
/// Dark Luxury · Premium · Futuristic
class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: AppFonts.primary,

      // ─── Color Scheme ──────────────────────────────────────────
      colorScheme: const ColorScheme.dark(
        primary:          AppColors.primary,
        secondary:        AppColors.secondary,
        tertiary:         AppColors.accent,
        background:       AppColors.background,
        surface:          AppColors.surface,
        onPrimary:        AppColors.white,
        onSecondary:      AppColors.white,
        onBackground:     AppColors.textPrimary,
        onSurface:        AppColors.textPrimary,
        error:            AppColors.error,
        onError:          AppColors.white,
        outline:          AppColors.border,
        surfaceVariant:   AppColors.surfaceLight,
        onSurfaceVariant: AppColors.textSecondary,
      ),

      // ─── Scaffold ──────────────────────────────────────────────
      scaffoldBackgroundColor: AppColors.background,

      // ─── AppBar ────────────────────────────────────────────────
      appBarTheme: const AppBarTheme(
        backgroundColor:  AppColors.background,
        foregroundColor:  AppColors.textPrimary,
        elevation:        0,
        scrolledUnderElevation: 0,
        centerTitle:      false,
        titleTextStyle:   AppFonts.headlineMedium,
        iconTheme:        IconThemeData(color: AppColors.textPrimary, size: 24),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor:           AppColors.transparent,
          statusBarIconBrightness:  Brightness.light,
          statusBarBrightness:      Brightness.dark,
        ),
      ),

      // ─── Bottom Navigation ─────────────────────────────────────
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor:      AppColors.surface,
        selectedItemColor:    AppColors.primary,
        unselectedItemColor:  AppColors.textMuted,
        showSelectedLabels:   true,
        showUnselectedLabels: true,
        type:                 BottomNavigationBarType.fixed,
        elevation:            0,
        selectedLabelStyle:   TextStyle(
          fontFamily:   AppFonts.primary,
          fontSize:     9,
          fontWeight:   FontWeight.w800,
          letterSpacing: 1.0,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily:   AppFonts.primary,
          fontSize:     9,
          fontWeight:   FontWeight.w600,
          letterSpacing: 1.0,
        ),
      ),

      // ─── Card ──────────────────────────────────────────────────
      cardTheme: CardThemeData(
        color:        AppColors.surface,
        elevation:    0,
        shape:        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side:         const BorderSide(color: AppColors.border, width: 1),
        ),
        margin:       const EdgeInsets.all(0),
      ),

      // ─── Elevated Button ───────────────────────────────────────
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor:  AppColors.primary,
          foregroundColor:  AppColors.white,
          elevation:        0,
          shadowColor:      AppColors.transparent,
          minimumSize:      const Size(double.infinity, 56),
          padding:          const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          shape:            RoundedRectangleBorder(
            borderRadius:   BorderRadius.circular(24),
          ),
          textStyle:        AppFonts.button,
        ),
      ),

      // ─── Outlined Button ───────────────────────────────────────
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor:  AppColors.textSecondary,
          side:             const BorderSide(color: AppColors.borderStrong, width: 1),
          minimumSize:      const Size(double.infinity, 54),
          padding:          const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape:            RoundedRectangleBorder(
            borderRadius:   BorderRadius.circular(24),
          ),
          textStyle:        AppFonts.titleMedium,
        ),
      ),

      // ─── Text Button ───────────────────────────────────────────
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor:  AppColors.primary,
          textStyle:        AppFonts.titleSmall.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      // ─── Input / TextField ─────────────────────────────────────
      inputDecorationTheme: InputDecorationTheme(
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
      ),

      // ─── Divider ───────────────────────────────────────────────
      dividerTheme: const DividerThemeData(
        color:      AppColors.border,
        thickness:  1,
        space:      1,
      ),

      // ─── Icon ──────────────────────────────────────────────────
      iconTheme: const IconThemeData(
        color:  AppColors.textSecondary,
        size:   24,
      ),

      // ─── Chip ──────────────────────────────────────────────────
      chipTheme: ChipThemeData(
        backgroundColor:     AppColors.surfaceLight,
        selectedColor:       AppColors.primary.withOpacity(0.2),
        labelStyle:          AppFonts.labelMedium.copyWith(
          color:             AppColors.textSecondary,
          letterSpacing:     0.5,
        ),
        side:                const BorderSide(color: AppColors.border),
        shape:               RoundedRectangleBorder(
          borderRadius:      BorderRadius.circular(20),
        ),
        padding:             const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      ),

      // ─── Dialog ────────────────────────────────────────────────
      dialogTheme: DialogThemeData(
        backgroundColor:  AppColors.surface,
        elevation:        0,
        shape:            RoundedRectangleBorder(
          borderRadius:   BorderRadius.circular(24),
        ),
        titleTextStyle:   AppFonts.headlineSmall,
        contentTextStyle: AppFonts.bodyLarge,
      ),

      // ─── SnackBar ──────────────────────────────────────────────
      snackBarTheme: SnackBarThemeData(
        backgroundColor:  AppColors.surfaceLight,
        contentTextStyle: AppFonts.bodyMedium.copyWith(color: AppColors.textPrimary),
        shape:            RoundedRectangleBorder(
          borderRadius:   BorderRadius.circular(16),
        ),
        behavior:         SnackBarBehavior.floating,
      ),

      // ─── Progress Indicator ────────────────────────────────────
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color:              AppColors.primary,
        linearTrackColor:   AppColors.surfaceLight,
        circularTrackColor: AppColors.surfaceLight,
      ),

      // ─── Slider ────────────────────────────────────────────────
      sliderTheme: const SliderThemeData(
        activeTrackColor:   AppColors.primary,
        inactiveTrackColor: AppColors.surfaceLight,
        thumbColor:         AppColors.primary,
        overlayColor:       Color(0x1AFF6129),
      ),

      // ─── Switch ────────────────────────────────────────────────
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          return states.contains(MaterialState.selected)
              ? AppColors.white
              : AppColors.textMuted;
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          return states.contains(MaterialState.selected)
              ? AppColors.primary
              : AppColors.surfaceLight;
        }),
      ),

      // ─── Text Theme ────────────────────────────────────────────
      textTheme: const TextTheme(
        displayLarge:   AppFonts.displayLarge,
        displayMedium:  AppFonts.displayMedium,
        headlineLarge:  AppFonts.headlineLarge,
        headlineMedium: AppFonts.headlineMedium,
        headlineSmall:  AppFonts.headlineSmall,
        titleLarge:     AppFonts.titleLarge,
        titleMedium:    AppFonts.titleMedium,
        titleSmall:     AppFonts.titleSmall,
        bodyLarge:      AppFonts.bodyLarge,
        bodyMedium:     AppFonts.bodyMedium,
        bodySmall:      AppFonts.bodySmall,
        labelLarge:     AppFonts.labelLarge,
        labelMedium:    AppFonts.labelMedium,
        labelSmall:     AppFonts.labelSmall,
      ),
    );
  }
}
