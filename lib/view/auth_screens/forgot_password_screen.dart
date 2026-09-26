import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../res/app_strings/app_strings.dart';
import '../../res/color/app_color.dart';
import '../../res/components/widgets/custom_button.dart';
import '../../res/components/widgets/custom_text_field.dart';
import '../../res/fonts/app_fonts.dart';
import '../../view_models/controllers/auth_controller.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  final authController = Get.put(AuthController());

  @override
  void dispose() {
    emailController.dispose();
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
              // ── Back Button ──────────────────────────────────────────
              Align(
                alignment: Alignment.topLeft,
                child: InkWell(
                  onTap: () => Get.back(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.arrow_back, color: AppColors.textSecondary, size: 18),
                        const SizedBox(width: 8),
                        Text(
                          AppStrings.backToLogin,
                          style: AppFonts.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ── Icon Section ──────────────────────────────────────────
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppColors.borderOrange, width: 1),
                ),
                child: const Center(
                  child: Icon(
                    Icons.lock_person_rounded,
                    size: 48,
                    color: AppColors.primary,
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // ── Title Section ─────────────────────────────────────────
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Forgot your\n",
                      style: AppFonts.displayMedium.copyWith(
                        fontWeight: AppFonts.black_w,
                      ),
                    ),
                    TextSpan(
                      text: "password?",
                      style: AppFonts.displayMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: AppFonts.black_w,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                AppStrings.forgotSubtitle,
                textAlign: TextAlign.center,
                style: AppFonts.bodyLarge.copyWith(
                  color: AppColors.textMuted,
                ),
              ),

              const SizedBox(height: 40),

              // ── Email Field ───────────────────────────────────────────
              CustomTextField(
                label: AppStrings.yourEmail,
                hintText: 'alex@gmail.com',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 32),

              // ── Send Link Button ──────────────────────────────────────
              Obx(() => CustomButton(
                title: AppStrings.sendResetLink,
                loading: authController.isForgotLoading.value,
                onPressed: () {
                  authController.forgotPassword(email: emailController.text);
                },
              )),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
