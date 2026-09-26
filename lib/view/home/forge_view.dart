import 'package:flutter/material.dart';
import '../../res/color/app_color.dart';
import '../../res/fonts/app_fonts.dart';
import '../../res/app_strings/app_strings.dart';
import 'widgets/active_plan_card.dart';
import 'widgets/workout_plan_tile.dart';

class ForgeView extends StatelessWidget {
  const ForgeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              
              // ── Header ─────────────────────────────────────────────
              Text(
                AppStrings.training,
                style: AppFonts.labelSmall.copyWith(
                  color: AppColors.primary,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Workout ',
                      style: AppFonts.displayMedium.copyWith(
                        fontWeight: AppFonts.black_w,
                        fontSize: 36,
                      ),
                    ),
                    TextSpan(
                      text: 'Plans',
                      style: AppFonts.displayMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: AppFonts.black_w,
                        fontSize: 36,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ── Filter Categories ──────────────────────────────────
              Row(
                children: [
                  _buildFilterChip(AppStrings.allPlans, true),
                  const SizedBox(width: 12),
                  _buildFilterChip(AppStrings.myPlan, false),
                  const SizedBox(width: 12),
                  _buildFilterChip(AppStrings.saved, false),
                ],
              ),

              const SizedBox(height: 32),

              // ── Active Plan ────────────────────────────────────────
              const ActivePlanCard(
                title: 'Hypertrophy Foundation',
                week: 'Week 3/8',
                daysPerWeek: '5 days/week',
                duration: '60 min',
                level: 'Advanced',
                progress: 0.37,
                progressText: '37% complete · 5 weeks remaining',
              ),

              const SizedBox(height: 32),

              // ── Plan List ──────────────────────────────────────────
              WorkoutPlanTile(
                title: 'Shred Protocol',
                duration: '12 weeks',
                description: 'Cut fat while preserving muscle mass with HIIT and supersets.',
                daysPerWeek: '6 days/wk',
                level: 'Intermediate',
                onStart: () {},
              ),
              WorkoutPlanTile(
                title: 'PowerBuilding X',
                duration: '10 weeks',
                description: 'Build strength and size simultaneously with compound lifts.',
                daysPerWeek: '4 days/wk',
                level: 'Advanced',
                onStart: () {},
              ),
              WorkoutPlanTile(
                title: 'Beginner\'s Forge',
                duration: '6 weeks',
                description: 'Perfect entry point for newcomers to structured training.',
                daysPerWeek: '3 days/wk',
                level: 'Beginner',
                onStart: () {},
              ),

              const SizedBox(height: 120), // Bottom nav space
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? AppColors.primary : AppColors.border,
        ),
      ),
      child: Text(
        label,
        style: AppFonts.labelSmall.copyWith(
          color: isSelected ? Colors.white : AppColors.textMuted,
          fontWeight: FontWeight.bold,
          letterSpacing: 0,
        ),
      ),
    );
  }
}
