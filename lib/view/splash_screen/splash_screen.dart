import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../res/app_strings/app_strings.dart';
import '../../res/color/app_color.dart';
import '../../res/fonts/app_fonts.dart';
import '../../view_models/controllers/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [

          // ── Layer 1: Background glow ───────────────────────
          _buildGlowBackground(size),

          // ── Layer 2: Main content ──────────────────────────
          Center(
            child: AnimatedBuilder(
              animation: controller.animationController,
              builder: (context, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    // ── Logo ──────────────────────────────────
                    SlideTransition(
                      position: controller.slideAnimation,
                      child: ScaleTransition(
                        scale: controller.scaleAnimation,
                        child: _buildLogo(),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // ── Tagline ───────────────────────────────
                    FadeTransition(
                      opacity: controller.fadeAnimation,
                      child: _buildTagline(),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════
  // WIDGETS
  // ══════════════════════════════════════════════════

  // 🌟 Background orange radial glow
  Widget _buildGlowBackground(Size size) {
    return Positioned(
      left: size.width  * 0.5 - 150,
      top:  size.height * 0.5 - 150,
      child: Container(
        width:  500,
        height: 500,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              AppColors.primary.withOpacity(0.25),
              AppColors.secondary.withOpacity(0.08),
              Colors.transparent,
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
      ),
    );
  }

  // 🔤 FORGEFIT
  Widget _buildLogo() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'FORGE',
          style: AppFonts.displayLarge.copyWith(
            color:         AppColors.textPrimary,
            fontSize:      60,
            fontWeight:    FontWeight.w900,
            letterSpacing: -2.0,
          ),
        ),
        Text(
          'FIT',
          style: AppFonts.displayLarge.copyWith(
            color:         AppColors.primary,
            fontSize:      60,
            fontWeight:    FontWeight.w900,
            letterSpacing: -2.0,
          ),
        ),
      ],
    );
  }

  // 💬 Tagline
  Widget _buildTagline() {
    return Text(
      AppStrings.appTagline.toUpperCase(),
      style: AppFonts.labelMedium.copyWith(
        color:         AppColors.textMuted,
        letterSpacing: 4.5,
        fontSize:      11,
        fontWeight:    FontWeight.w600,
      ),
    );
  }
}