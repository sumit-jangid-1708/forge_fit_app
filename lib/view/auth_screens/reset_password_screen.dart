import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../res/app_strings/app_strings.dart';
import '../../res/color/app_color.dart';
import '../../res/components/widgets/custom_button.dart';
import '../../res/components/widgets/custom_text_field.dart';
import '../../res/fonts/app_fonts.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

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
                          AppStrings.back,
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

              // ── Key Icon Section ──────────────────────────────────────
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
                    Icons.vpn_key_rounded,
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
                      text: "${AppStrings.setNewPwd}\n",
                      style: AppFonts.displayMedium.copyWith(
                        fontWeight: AppFonts.black_w,
                      ),
                    ),
                    TextSpan(
                      text: AppStrings.pwd,
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
                AppStrings.resetPwdSubtitle,
                textAlign: TextAlign.center,
                style: AppFonts.bodyLarge.copyWith(
                  color: AppColors.textMuted,
                ),
              ),

              const SizedBox(height: 40),

              // ── New Password Field ────────────────────────────────────
              const CustomTextField(
                label: AppStrings.newPwd,
                hintText: '••••••••••••',
                isPassword: true,
              ),

              const SizedBox(height: 20),

              // ── Confirm Password Field ────────────────────────────────
              CustomTextField(
                label: AppStrings.confirmPwdLabel,
                hintText: '••••••••••••',
                isPassword: true,
                isValid: true,
                suffixIcon: Container(
                  padding: const EdgeInsets.all(12),
                  child: const Icon(Icons.check, color: AppColors.primary, size: 20),
                ),
              ),

              const SizedBox(height: 20),

              // ── Password Strength Indicator ───────────────────────────
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.pwdStrength,
                    style: AppFonts.bodySmall.copyWith(color: AppColors.textMuted),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: List.generate(4, (index) {
                      return Expanded(
                        child: Container(
                          height: 4,
                          margin: EdgeInsets.only(right: index == 3 ? 0 : 8),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        AppStrings.excellentMsg,
                        style: AppFonts.bodySmall.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ── Requirements List ─────────────────────────────────────
              _buildRequirementRow(AppStrings.req1, true),
              _buildRequirementRow(AppStrings.req2, true),
              _buildRequirementRow(AppStrings.req3, true),

              const SizedBox(height: 32),

              // ── Update Button ─────────────────────────────────────────
              CustomButton(
                title: AppStrings.updatePwd,
                onPressed: () {},
              ),

              const SizedBox(height: 40),

              // ── Success State Section ─────────────────────────────────
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.surfaceMid,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    Text(
                      AppStrings.successState,
                      style: AppFonts.labelMedium.copyWith(
                        letterSpacing: 2,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.borderOrange, width: 1),
                        color: AppColors.surfaceLight,
                      ),
                      child: const Icon(Icons.check, color: AppColors.white, size: 30),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      AppStrings.pwdUpdated,
                      style: AppFonts.headlineMedium.copyWith(
                        fontWeight: AppFonts.black_w,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppStrings.readyToForge,
                      style: AppFonts.bodyMedium.copyWith(
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRequirementRow(String text, bool isMet) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 18,
            color: isMet ? AppColors.primary : AppColors.textMuted,
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: AppFonts.bodyMedium.copyWith(
              color: isMet ? AppColors.textPrimary : AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
