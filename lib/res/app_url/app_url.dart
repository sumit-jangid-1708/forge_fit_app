
class AppUrl {
  AppUrl._();

  // ─── Base URLs ────────────────────────────────────────────────
  static const String baseUrl       = 'https://api.forgefit.app/v1';
  static const String devBaseUrl    = 'https://dev-api.forgefit.app/v1';

  // ─── Auth ─────────────────────────────────────────────────────
  static const String login         = '$baseUrl/auth/login';
  static const String signup        = '$baseUrl/auth/signup';
  static const String logout        = '$baseUrl/auth/logout';
  static const String forgotPwd     = '$baseUrl/auth/forgot-password';
  static const String verifyOtp     = '$baseUrl/auth/verify-otp';
  static const String resetPwd      = '$baseUrl/auth/reset-password';
  static const String refreshToken  = '$baseUrl/auth/refresh-token';

  // ─── User / Profile ───────────────────────────────────────────
  static const String profile       = '$baseUrl/user/profile';
  static const String updateProfile = '$baseUrl/user/profile/update';
  static const String uploadAvatar  = '$baseUrl/user/avatar';
  static const String bodyStats     = '$baseUrl/user/body-stats';

  // ─── Goals ────────────────────────────────────────────────────
  static const String goals         = '$baseUrl/goals';
  static const String setGoal       = '$baseUrl/goals/set';

  // ─── Workout ──────────────────────────────────────────────────
  static const String workoutPlans  = '$baseUrl/workouts/plans';
  static const String workoutDetail = '$baseUrl/workouts/detail';
  static const String startWorkout  = '$baseUrl/workouts/start';
  static const String completeWo    = '$baseUrl/workouts/complete';
  static const String exercises     = '$baseUrl/workouts/exercises';

  // ─── Trackers ─────────────────────────────────────────────────
  static const String steps         = '$baseUrl/trackers/steps';
  static const String logSteps      = '$baseUrl/trackers/steps/log';
  static const String water         = '$baseUrl/trackers/water';
  static const String logWater      = '$baseUrl/trackers/water/log';
  static const String weight        = '$baseUrl/trackers/weight';
  static const String logWeight     = '$baseUrl/trackers/weight/log';

  // ─── Progress ─────────────────────────────────────────────────
  static const String progress      = '$baseUrl/progress';
  static const String progressPhotos= '$baseUrl/progress/photos';
  static const String uploadPhoto   = '$baseUrl/progress/photos/upload';

  // ─── Achievements ─────────────────────────────────────────────
  static const String achievements  = '$baseUrl/achievements';
  static const String earnedBadges  = '$baseUrl/achievements/earned';

  // ─── Dashboard ────────────────────────────────────────────────
  static const String dashboard     = '$baseUrl/dashboard';
  static const String activityRings = '$baseUrl/dashboard/rings';
}