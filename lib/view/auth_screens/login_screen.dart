import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/local/hive_boxes.dart';
import '../../res/app_strings/app_strings.dart';
import '../../res/color/app_color.dart';
import '../../res/components/widgets/custom_button.dart';
import '../../res/components/widgets/custom_text_field.dart';
import '../../res/fonts/app_fonts.dart';
import '../../res/routes/routes_name.dart';
import '../../view_models/controllers/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    // Saved email ko console mein print karein aur field mein fill karein
    String savedEmail = HiveBoxes.userEmail;
    if (savedEmail.isNotEmpty) {
      emailController.text = savedEmail;
      print("DEBUG: Saved User Email found: $savedEmail");
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),

              // ── Logo Section ──────────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.forge.toUpperCase(),
                    style: AppFonts.displayMedium.copyWith(
                      letterSpacing: -1,
                      fontWeight: AppFonts.black_w,
                    ),
                  ),
                  Text(
                    AppStrings.fit.toUpperCase(),
                    style: AppFonts.displayMedium.copyWith(
                      color: AppColors.primary,
                      letterSpacing: -1,
                      fontWeight: AppFonts.black_w,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                AppStrings.welcomeBack,
                style: AppFonts.bodyLarge.copyWith(
                  color: AppColors.textMuted,
                ),
              ),

              const SizedBox(height: 48),

              // ── Form Fields ───────────────────────────────────────────
              CustomTextField(
                label: AppStrings.email,
                hintText: 'alex@forgefit.com',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              Obx(() => CustomTextField(
                label: AppStrings.password,
                hintText: '*********',
                controller: passwordController,
                isPassword: !authController.isPasswordVisible.value,
                suffixIcon: IconButton(
                  onPressed: authController.togglePassword,
                  icon: Icon(
                    authController.isPasswordVisible.value
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: AppColors.textMuted,
                  ),
                ),
              )),

              // ── Forgot Password ───────────────────────────────────────
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Get.toNamed(RouteName.forgotPasswordScreen);
                  },
                  child: Text(
                    AppStrings.forgotPwd,
                    style: AppFonts.titleSmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ── Sign In Button ────────────────────────────────────────
              Obx(() => CustomButton(
                title: AppStrings.login,
                showShadow: false, 
                loading: authController.isLoginLoading.value,
                onPressed: () {
                  authController.login(
                    email: emailController.text,
                    password: passwordController.text,
                  );
                },
              )),

              const SizedBox(height: 32),

              // ── Divider ───────────────────────────────────────────────
              Row(
                children: [
                  const Expanded(child: Divider(color: AppColors.border, thickness: 1)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      AppStrings.orContinue,
                      style: AppFonts.bodySmall.copyWith(color: AppColors.textMuted),
                    ),
                  ),
                  const Expanded(child: Divider(color: AppColors.border, thickness: 1)),
                ],
              ),

              const SizedBox(height: 32),

              // ── Social Login ──────────────────────────────────────────
              Obx(() => CustomButton(
                title: AppStrings.google,
                isFullWidth: true,
                buttonColor: AppColors.surfaceLight,
                gradient: null,
                showShadow: false,
                loading: authController.isGoogleLoading.value,
                textStyle: AppFonts.button.copyWith(color: AppColors.textPrimary),
                icon: Icons.g_mobiledata_rounded,
                onPressed: () {
                  authController.signInWithGoogle();
                },
              )),

              const SizedBox(height: 40),

              // ── Sign Up Link ──────────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.noAccount,
                    style: AppFonts.bodyMedium.copyWith(color: AppColors.textMuted),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteName.signUpScreen);
                    },
                    child: Text(
                      AppStrings.signUp,
                      style: AppFonts.bodyMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
