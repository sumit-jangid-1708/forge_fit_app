import 'package:get/get.dart';
import '../../data/local/hive_boxes.dart';
import '../../res/app_strings/app_strings.dart';
import '../../res/assets/images_assets.dart';
import '../../res/routes/routes_name.dart';

class PersonalizeController extends GetxController {

  // ── Selected Goal ──────────────────────────────────────────
  final RxString selectedGoal = AppStrings.buildMuscle.obs;

  // ── Goals List ─────────────────────────────────────────────
  final List<Map<String, String>> goals = [
    {
      'title': AppStrings.buildMuscle,
      'desc':  AppStrings.buildMuscleDesc,
      'image': ImageAssets.dumbbell,
    },
    {
      'title': AppStrings.burnFat,
      'desc':  AppStrings.burnFatDesc,
      'image': ImageAssets.rope,
    },
    {
      'title': AppStrings.getStronger,
      'desc':  AppStrings.getStrongerDesc,
      'image': ImageAssets.shoe,
    },
    {
      'title': AppStrings.endurance,
      'desc':  AppStrings.enduranceDesc,
      'image': ImageAssets.runner,
    },
    {
      'title': AppStrings.flexibility,
      'desc':  AppStrings.flexibilityDesc,
      'image': ImageAssets.yoga,
    },
    {
      'title': AppStrings.stayBetter,
      'desc':  AppStrings.stayBetterDesc,
      'image': ImageAssets.healthyMeal,
    },
  ];

  // ── onInit — pehle se saved goal load karo ─────────────────
  @override
  void onInit() {
    super.onInit();
    final savedGoal = HiveBoxes.userGoal;
    if (savedGoal.isNotEmpty) {
      selectedGoal.value = savedGoal;
    }
  }

  // ── Goal Select karo ───────────────────────────────────────
  void selectGoal(String goalTitle) {
    selectedGoal.value = goalTitle;
  }

  // ── Check karo selected hai ya nahi ───────────────────────
  bool isGoalSelected(String goalTitle) =>
      selectedGoal.value == goalTitle;

  // ── Build My Plan button ───────────────────────────────────
  void onBuildPlanPressed() {
    if (selectedGoal.value.isEmpty) {
      return;
    }

    // ✅ Hive mein save karo
    HiveBoxes.saveGoal(selectedGoal.value);

    // Dashboard par jao (Correct route name: dashboard)
    Get.offAllNamed(RouteName.dashboard);
  }
}
