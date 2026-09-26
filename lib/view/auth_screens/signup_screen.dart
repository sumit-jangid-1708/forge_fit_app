import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../res/app_strings/app_strings.dart';
import '../../res/color/app_color.dart';
import '../../res/components/widgets/custom_button.dart';
import '../../res/components/widgets/custom_text_field.dart';
import '../../res/fonts/app_fonts.dart';
import '../../res/routes/routes_name.dart';
import '../../utils/app_alerts.dart';
import '../../view_models/controllers/auth_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final authController = Get.put(AuthController());
  bool agreeTerms = false;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              
              // ── Logo Section ──────────────────────────────────────────
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppStrings.forge.toUpperCase(),
                      style: AppFonts.headlineLarge.copyWith(
                        letterSpacing: -1,
                        fontWeight: AppFonts.black_w,
                      ),
                    ),
                    Text(
                      AppStrings.fit.toUpperCase(),
                      style: AppFonts.headlineLarge.copyWith(
                        color: AppColors.primary,
                        letterSpacing: -1,
                        fontWeight: AppFonts.black_w,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // ── Title Section ─────────────────────────────────────────
              Text(
                AppStrings.createYourAccount,
                style: AppFonts.displayMedium.copyWith(
                  fontWeight: AppFonts.bold_w,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                AppStrings.transformationToday,
                style: AppFonts.bodyLarge.copyWith(
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 32),

              // ── Name Row ──────────────────────────────────────────────
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      label: AppStrings.firstName,
                      hintText: 'Alex',
                      controller: firstNameController,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomTextField(
                      label: AppStrings.lastName,
                      hintText: 'Stone',
                      controller: lastNameController,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // ── Email Field ───────────────────────────────────────────
              CustomTextField(
                label: AppStrings.email,
                hintText: 'alex@gmail.com',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),

              // ── Password Fields ───────────────────────────────────────
              Obx(() => CustomTextField(
                label: AppStrings.password,
                hintText: '*********',
                isPassword: !authController.isPasswordVisible.value,
                controller: passwordController,
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
              const SizedBox(height: 20),
              Obx(() => CustomTextField(
                label: AppStrings.confirmPwd,
                hintText: '*********',
                isPassword: !authController.isConfirmPasswordVisible.value,
                controller: confirmPasswordController,
                suffixIcon: IconButton(
                  onPressed: authController.toggleConfirmPassword,
                  icon: Icon(
                    authController.isConfirmPasswordVisible.value
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: AppColors.textMuted,
                  ),
                ),
              )),
              
              const SizedBox(height: 24),

              // ── Password Strength (Visual only for now) ───────────────
              Text(
                AppStrings.pwdStrength.toUpperCase(),
                style: AppFonts.labelSmall.copyWith(color: AppColors.textMuted),
              ),
              const SizedBox(height: 8),
              Row(
                children: List.generate(4, (index) {
                  return Expanded(
                    child: Container(
                      height: 4,
                      margin: EdgeInsets.only(right: index == 3 ? 0 : 8),
                      decoration: BoxDecoration(
                        color: index < 3 ? AppColors.primary : AppColors.surfaceLight,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 8),
              Text(
                AppStrings.pwdStrongMsg,
                style: AppFonts.bodySmall.copyWith(color: AppColors.primary),
              ),

              const SizedBox(height: 24),

              // ── Terms & Conditions ────────────────────────────────────
              Row(
                children: [
                  Checkbox(
                    value: agreeTerms,
                    onChanged: (val) => setState(() => agreeTerms = val ?? false),
                    activeColor: AppColors.primary,
                    side: const BorderSide(color: AppColors.borderStrong),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                  Expanded(
                    child: Text(
                      AppStrings.agreeTerms,
                      style: AppFonts.bodySmall.copyWith(color: AppColors.textMuted),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // ── Create Account Button ─────────────────────────────────
              Obx(() => CustomButton(
                title: AppStrings.createAccount,
                icon: Icons.arrow_forward,
                iconRight: true,
                showShadow: false,
                loading: authController.isSignUpLoading.value,
                onPressed: () {
                  if (!agreeTerms) {
                    AppAlerts.error('Please agree to terms and conditions');
                    return;
                  }
                  if (passwordController.text != confirmPasswordController.text) {
                    AppAlerts.error('Passwords do not match');
                    return;
                  }
                  authController.signUp(
                    name: '${firstNameController.text} ${lastNameController.text}',
                    email: emailController.text,
                    password: passwordController.text,
                  );
                },
              )),

              const SizedBox(height: 24),

              // ── Divider ───────────────────────────────────────────────
              Row(
                children: [
                  const Expanded(child: Divider(color: AppColors.border, thickness: 1)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      AppStrings.orSignUpWith,
                      style: AppFonts.bodySmall.copyWith(color: AppColors.textMuted),
                    ),
                  ),
                  const Expanded(child: Divider(color: AppColors.border, thickness: 1)),
                ],
              ),

              const SizedBox(height: 24),

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

              const SizedBox(height: 32),

              // ── Sign In Link ──────────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.haveAccount,
                    style: AppFonts.bodyMedium.copyWith(color: AppColors.textMuted),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Text(
                      AppStrings.login,
                      style: AppFonts.bodyMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
