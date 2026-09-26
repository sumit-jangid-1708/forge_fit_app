// lib/data/local/hive_boxes.dart

import 'package:hive_flutter/hive_flutter.dart';

class HiveBoxes {
  HiveBoxes._();

  // Box names — ek jagah define karo, galti na ho
  static const String _userBox    = 'userBox';
  static const String _workoutBox = 'workoutBox';
  static const String _trackerBox = 'trackerBox';

  // Boxes access karne ke liye getters
  static Box get user    => Hive.box(_userBox);
  static Box get workout => Hive.box(_workoutBox);
  static Box get tracker => Hive.box(_trackerBox);

  // ── User Data Keys ──────────────────────────────────────────
  static const String keyUserName     = 'user_name';
  static const String keyUserEmail    = 'user_email';
  static const String keyUserUid      = 'user_uid';
  static const String keyUserGoal     = 'user_goal';
  static const String keyIsLoggedIn   = 'is_logged_in';
  static const String keyIsFirstTime  = 'is_first_time';

  // ── Tracker Keys ───────────────────────────────────────────
  static const String keyWaterToday   = 'water_today';
  static const String keyWaterGoal    = 'water_goal';
  static const String keyWeightLog    = 'weight_log';
  static const String keyStepsToday   = 'steps_today';
  static const String keyStepsGoal    = 'steps_goal';

  // ── Helper Methods ─────────────────────────────────────────

  // User save karo login ke baad
  static void saveUser({
    required String uid,
    required String name,
    required String email,
  }) {
    user.put(keyUserUid,    uid);
    user.put(keyUserName,   name);
    user.put(keyUserEmail,  email);
    user.put(keyIsLoggedIn, true);
  }

  // User data clear karo logout ke baad
  static void clearUser() {
    user.put(keyIsLoggedIn, false);
    user.delete(keyUserUid);
    user.delete(keyUserName);
    user.delete(keyUserEmail);
    user.delete(keyUserGoal);
  }

  // Check karo logged in hai ya nahi
  static bool get isLoggedIn =>
      user.get(keyIsLoggedIn, defaultValue: false);

  // Check karo pehli baar hai ya nahi
  static bool get isFirstTime =>
      user.get(keyIsFirstTime, defaultValue: true);

  // First time flag off karo
  static void setNotFirstTime() =>
      user.put(keyIsFirstTime, false);

  // User name get karo
  static String get userName =>
      user.get(keyUserName, defaultValue: '');

  // User email get karo
  static String get userEmail =>
      user.get(keyUserEmail, defaultValue: '');

  // User goal get karo
  static String get userGoal =>
      user.get(keyUserGoal, defaultValue: '');

  // User goal save karo
  static void saveGoal(String goal) =>
      user.put(keyUserGoal, goal);
}