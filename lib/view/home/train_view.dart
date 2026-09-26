import 'package:flutter/material.dart';
import '../../res/color/app_color.dart';
import '../../res/components/widgets/custom_button.dart';
import '../../res/fonts/app_fonts.dart';
import 'widgets/exercise_card.dart';
import 'widgets/info_badge.dart';
import 'widgets/train_header.dart';
import 'widgets/workout_progress.dart';

class TrainView extends StatelessWidget {
  const TrainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  
                  // ── Header ─────────────────────────────────────────────
                  const TrainHeader(),

                  const SizedBox(height: 20),

                  // ── Badges ─────────────────────────────────────────────
                  const Row(
                    children: [
                      InfoBadge(text: '52 min'),
                      SizedBox(width: 12),
                      InfoBadge(text: '420 kcal'),
                      SizedBox(width: 12),
                      InfoBadge(text: 'Advanced', isOutline: false),
                    ],
                  ),

                  const SizedBox(height: 16),
                  
                  InfoBadge(
                    text: '6 Exercises', 
                    isOutline: false,
                  ),

                  const SizedBox(height: 40),

                  // ── Exercises Section Title ────────────────────────────
                  Text(
                    'EXERCISES',
                    style: AppFonts.labelSmall.copyWith(
                      letterSpacing: 2,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  
                  const SizedBox(height: 20),

                  // ── Exercises List ─────────────────────────────────────
                  const ExerciseCard(
                    index: 1,
                    title: 'Barbell Bench Press',
                    subtitle: '4 sets · 8-10 reps · 90s rest',
                    isCompleted: true,
                  ),
                  const ExerciseCard(
                    index: 2,
                    title: 'Incline DB Press',
                    subtitle: '3 sets · 10-12 reps · 75s rest',
                    isCompleted: true,
                  ),
                  const ExerciseCard(
                    index: 3,
                    title: 'Overhead Press',
                    subtitle: '4 sets · 6-8 reps · 90s rest',
                  ),
                  const ExerciseCard(
                    index: 4,
                    title: 'Cable Flyes',
                    subtitle: '3 sets · 12-15 reps · 60s rest',
                  ),
                  const ExerciseCard(
                    index: 5,
                    title: 'Tricep Pushdown',
                    subtitle: '3 sets · 12 reps · 60s rest',
                  ),
                  const ExerciseCard(
                    index: 6,
                    title: 'Lateral Raises',
                    subtitle: '4 sets · 15-20 reps · 45s rest',
                  ),

                  const SizedBox(height: 24),

                  // ── Progress Section ──────────────────────────────────
                  const WorkoutProgress(completed: 2, total: 6),

                  const SizedBox(height: 140), // Space for bottom button
                ],
              ),
            ),

            // ── Floating Action Button / Bottom Button ──────────────────
            Positioned(
              bottom: 24,
              left: 20,
              right: 20,
              child: CustomButton(
                title: 'Complete Workout 🔥',
                onPressed: () {},
                showShadow: true,
                borderRadius: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
