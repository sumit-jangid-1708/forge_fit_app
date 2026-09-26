// lib/view_models/controllers/profile_controller.dart

import 'package:get/get.dart';
import '../../data/local/hive_boxes.dart';

class ProfileController extends GetxController {

  // ── User Data ──────────────────────────────────────────────
  final RxString userName    = ''.obs;
  final RxString userEmail   = ''.obs;
  final RxString userGoal    = ''.obs;
  final RxString avatarLetter = ''.obs;

  // ── Stats — abhi Hive se, baad mein API se ────────────────
  // Hive mein save honge jab workout complete ho
  final RxInt workoutsCount  = 0.obs;
  final RxInt streakCount    = 0.obs;
  final RxInt badgesCount    = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadProfileData();
  }

  void loadProfileData() {
    // Hive se data load karo
    userName.value  = HiveBoxes.userName;
    userEmail.value = HiveBoxes.userEmail;
    userGoal.value  = HiveBoxes.userGoal;

    // Avatar letter — naam ka pehla letter
    avatarLetter.value = userName.value.isNotEmpty
        ? userName.value[0].toUpperCase()
        : 'F';

    // Stats Hive se load karo
    workoutsCount.value = HiveBoxes.user.get(
      'workouts_count',
      defaultValue: 0,
    );
    streakCount.value = HiveBoxes.user.get(
      'streak_count',
      defaultValue: 0,
    );
    badgesCount.value = HiveBoxes.user.get(
      'badges_count',
      defaultValue: 0,
    );
  }

  // Workout complete hone par call karo
  void incrementWorkouts() {
    workoutsCount.value++;
    HiveBoxes.user.put('workouts_count', workoutsCount.value);
  }

  // Streak update karo
  void updateStreak(int streak) {
    streakCount.value = streak;
    HiveBoxes.user.put('streak_count', streak);
  }
}