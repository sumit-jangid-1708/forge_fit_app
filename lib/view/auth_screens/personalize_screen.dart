import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../res/app_strings/app_strings.dart';
import '../../res/color/app_color.dart';
import '../../res/components/widgets/custom_button.dart';
import '../../res/components/widgets/goal_card.dart';
import '../../res/fonts/app_fonts.dart';
import '../../view_models/controllers/personalize_controller.dart';

class PersonalizeScreen extends StatelessWidget {
  PersonalizeScreen({super.key});

  final PersonalizeController controller = Get.put(PersonalizeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    Text(
                      AppStrings.personalize.toUpperCase(),
                      style: AppFonts.labelLarge.copyWith(
                        color: AppColors.primary,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const SizedBox(height: 12),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "${AppStrings.whatsYour}\n",
                            style: AppFonts.displayMedium.copyWith(
                              fontWeight: AppFonts.bold_w,
                              color:      AppColors.textPrimary,
                            ),
                          ),
                          TextSpan(
                            text: AppStrings.mainGoal,
                            style: AppFonts.displayMedium.copyWith(
                              fontWeight: AppFonts.bold_w,
                              color:      AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      AppStrings.personalizePlanDesc,
                      style: AppFonts.bodyLarge.copyWith(
                        color: AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // ── Goals Grid ────────────────────────────
                    // ✅ FIX: GridView ab Obx ke bahar — normal builder
                    //    Sirf andar har GoalCard apna Obx use karta hai
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.goals.length,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:   2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing:  16,
                        childAspectRatio: 0.82,
                      ),
                      itemBuilder: (context, index) {
                        final goal  = controller.goals[index];
                        final title = goal['title']!;

                        // ✅ Har card apne aap mein Obx hai
                        // selectedGoal.value change hote hi sirf
                        // yeh specific card rebuild hoga, poora grid nahi
                        return Obx(
                              () => GoalCard(
                            title:       title,
                            description: goal['desc']!,
                            imagePath:   goal['image']!,
                            isSelected:  controller.selectedGoal.value == title,
                            onTap:       () => controller.selectGoal(title),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24.0),
              child: CustomButton(
                title:      AppStrings.buildMyPlan,
                icon:       Icons.arrow_forward,
                iconRight:  true,
                showShadow: false,
                onPressed:  controller.onBuildPlanPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}