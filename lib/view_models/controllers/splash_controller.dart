// lib/view_models/controllers/splash_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/local/hive_boxes.dart';
import '../../res/routes/routes_name.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {

  late AnimationController animationController;
  late Animation<double>   scaleAnimation;
  late Animation<Offset>   slideAnimation;
  late Animation<double>   fadeAnimation;

  @override
  void onInit() {
    super.onInit();

    animationController = AnimationController(
      vsync:    this,
      duration: const Duration(seconds: 2),
    );

    scaleAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeOutBack),
    );

    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 2),
      end:   Offset.zero,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve:  Curves.easeOutCubic,
    ));

    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve:  const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );

    animationController.forward();
    Future.delayed(const Duration(seconds: 3), _navigateToNext);
  }

  void _navigateToNext() {
    // Pehli baar → Onboarding
    // Already logged in → Dashboard
    // Login nahi → Login
    if (HiveBoxes.isFirstTime) {
      HiveBoxes.setNotFirstTime();
      Get.offAllNamed(RouteName.onboardingScreen);
    } else if (HiveBoxes.isLoggedIn) {
      Get.offAllNamed(RouteName.dashboard);
    } else {
      Get.offAllNamed(RouteName.loginScreen);
    }
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
