// lib/view_models/controllers/home_controller.dart

import 'package:get/get.dart';
import '../../data/local/hive_boxes.dart';
import '../../utils/utils.dart';

class HomeController extends GetxController {

  // ── User Data ──────────────────────────────────────────────
  final RxString userName    = ''.obs;
  final RxString userGoal    = ''.obs;
  final RxString greeting    = ''.obs;
  final RxString todayDate   = ''.obs;

  // ── Stats — baad mein API se aayega, abhi dummy ───────────
  final RxInt    steps        = 8432.obs;
  final RxInt    stepsGoal    = 10000.obs;
  final RxDouble water        = 1.8.obs;
  final RxDouble waterGoal    = 2.5.obs;
  final RxInt    calories     = 1820.obs;
  final RxInt    caloriesGoal = 2400.obs;
  final RxDouble sleep        = 7.4.obs;
  final RxDouble sleepGoal    = 8.0.obs;
  final RxInt    streak       = 14.obs;

  // ── Activity Rings ────────────────────────────────────────
  double get stepsProgress    => steps.value / stepsGoal.value;
  double get waterProgress    => water.value / waterGoal.value;
  double get caloriesProgress => calories.value / caloriesGoal.value;
  double get sleepProgress    => sleep.value / sleepGoal.value;

  @override
  void onInit() {
    super.onInit();
    _loadUserData();
    _setGreeting();
    _setDate();
  }

  // ── Hive se user data load karo ───────────────────────────
  void _loadUserData() {
    final fullName = HiveBoxes.userName;

    // Pehla word hi first name hoga
    userName.value = fullName.isNotEmpty
        ? fullName.split(' ').first
        : 'Champion';

    userGoal.value = HiveBoxes.userGoal;
  }

  // ── Time ke hisab se greeting ─────────────────────────────
  void _setGreeting() {
    greeting.value = Utils.getGreeting();
  }

  // ── Aaj ki date ───────────────────────────────────────────
  void _setDate() {
    todayDate.value = Utils.formatDate(DateTime.now());
  }

  // ── Steps update karo (Step Counter se call hoga) ─────────
  void updateSteps(int newSteps) {
    steps.value = newSteps;
    // Hive mein bhi save karo
    HiveBoxes.tracker.put(HiveBoxes.keyStepsToday, newSteps);
  }

  // ── Water update karo (Water Tracker se call hoga) ────────
  void updateWater(double newWater) {
    water.value = newWater;
    HiveBoxes.tracker.put(HiveBoxes.keyWaterToday, newWater);
  }

  // ── Hive se saved stats load karo ────────────────────────
  void _loadSavedStats() {
    final savedSteps = HiveBoxes.tracker.get(
      HiveBoxes.keyStepsToday,
      defaultValue: 8432,
    );
    final savedWater = HiveBoxes.tracker.get(
      HiveBoxes.keyWaterToday,
      defaultValue: 1.8,
    );
    steps.value = savedSteps;
    water.value = savedWater;
  }
}