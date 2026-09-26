import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../data/local/hive_boxes.dart';
import '../../res/color/app_color.dart';
import '../../utils/app_alerts.dart';

class StepCounterController extends GetxController {
  // ── Step Data ──────────────────────────────────────────────
  final RxInt steps = 0.obs;
  final RxInt goal = 10000.obs;
  final RxList<double> hourlyData = <double>[0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0].obs;

  // ── Pedometer variables ──────────────────────────────────
  late Stream<StepCount> _stepCountStream;
  int _stepOffset = 0;
  int _lastKnownTotalSteps = 0;

  // ── Computed Stats ─────────────────────────────────────────
  double get progress => (steps.value / goal.value).clamp(0.0, 1.0);
  int get remaining => (goal.value - steps.value).clamp(0, goal.value);
  String get km => (steps.value * 0.00078).toStringAsFixed(1);
  String get kcal => (steps.value * 0.04).toStringAsFixed(0);
  String get min => (steps.value / 100).toStringAsFixed(0);

  String get remainingFormatted => remaining.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},');

  // Peak activity hour index for the chart
  int get peakHourIndex {
    if (hourlyData.isEmpty) return 0;
    double maxVal = -1.0;
    int idx = 0;
    for (int i = 0; i < hourlyData.length; i++) {
      if (hourlyData[i] > maxVal) {
        maxVal = hourlyData[i];
        idx = i;
      }
    }
    return idx;
  }

  @override
  void onInit() {
    super.onInit();
    _loadFromHive();
    _checkDayReset();
    _requestPermissionAndStart();
  }

  // ── Permission & Pedometer Start ───────────────────────────
  Future<void> _requestPermissionAndStart() async {
    if (await Permission.activityRecognition.request().isGranted) {
      _startPedometer();
    } else {
      AppAlerts.error('Activity permission is required to count steps');
    }
  }

  void _startPedometer() {
    try {
      _stepCountStream = Pedometer.stepCountStream;
      _stepCountStream.listen(_onStepCount, onError: (e) => debugPrint('Pedometer Error: $e'));
    } catch (e) {
      debugPrint('Could not start pedometer: $e');
    }
  }

  void _onStepCount(StepCount event) {
    _lastKnownTotalSteps = event.steps;
    if (_stepOffset == 0) {
      _stepOffset = HiveBoxes.tracker.get('step_offset_today', defaultValue: event.steps);
      HiveBoxes.tracker.put('step_offset_today', _stepOffset);
    }
    final todaySteps = event.steps - _stepOffset;
    if (todaySteps >= 0) {
      steps.value = todaySteps;
      _updateHourlyData();
      _saveToHive();
    }
  }

  // ── Reset Steps ────────────────────────────────────────────
  Future<void> resetSteps() async {
    final confirm = await AppAlerts.confirm(
      title: 'Reset Steps',
      message: 'Are you sure you want to reset today\'s steps?',
      confirmText: 'Reset',
      isDanger: true,
    );
    if (confirm) {
      _stepOffset = _lastKnownTotalSteps;
      steps.value = 0;
      hourlyData.assignAll(List.filled(8, 0.0));
      HiveBoxes.tracker.put('step_offset_today', _stepOffset);
      HiveBoxes.tracker.put(HiveBoxes.keyStepsToday, 0);
      HiveBoxes.tracker.put('hourly_steps', List.filled(8, 0.0));
      AppAlerts.success('Steps reset successfully');
    }
  }

  // ── Add Steps (Manual/Test) ────────────────────────────────
  void addSteps(int count) {
    steps.value += count;
    _stepOffset -= count; 
    HiveBoxes.tracker.put('step_offset_today', _stepOffset);
    _updateHourlyData();
    _saveToHive();
  }

  // ── Hive Persistence ───────────────────────────────────────
  void _loadFromHive() {
    steps.value = HiveBoxes.tracker.get(HiveBoxes.keyStepsToday, defaultValue: 0);
    goal.value = HiveBoxes.tracker.get(HiveBoxes.keyStepsGoal, defaultValue: 10000);
    final saved = HiveBoxes.tracker.get('hourly_steps', defaultValue: List.filled(8, 0.0));
    hourlyData.assignAll((saved as List).map((e) => (e as num).toDouble()).toList());
  }

  void _checkDayReset() {
    final todayStr = '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';
    if (HiveBoxes.tracker.get('steps_date', defaultValue: '') != todayStr) {
      steps.value = 0;
      _stepOffset = 0;
      hourlyData.assignAll(List.filled(8, 0.0));
      HiveBoxes.tracker.put('steps_date', todayStr);
      HiveBoxes.tracker.put(HiveBoxes.keyStepsToday, 0);
      HiveBoxes.tracker.put('hourly_steps', List.filled(8, 0.0));
      HiveBoxes.tracker.put('step_offset_today', 0);
    }
  }

  void _updateHourlyData() {
    final idx = (DateTime.now().hour - 7).clamp(0, 7);
    final normalized = (steps.value / goal.value).clamp(0.0, 1.0);
    if (idx < hourlyData.length) {
      hourlyData[idx] = normalized;
      HiveBoxes.tracker.put('hourly_steps', hourlyData.toList());
    }
  }

  void updateGoal(int newGoal) {
    goal.value = newGoal;
    HiveBoxes.tracker.put(HiveBoxes.keyStepsGoal, newGoal);
    _updateHourlyData();
  }

  void _saveToHive() => HiveBoxes.tracker.put(HiveBoxes.keyStepsToday, steps.value);

  void showGoalDialog() {
    final inputController = TextEditingController(text: goal.value.toString());
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF121212),
        title: const Text('Set Daily Goal', style: TextStyle(color: Colors.white)),
        content: TextField(
          controller: inputController,
          keyboardType: TextInputType.number,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(suffixText: 'steps'),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final g = int.tryParse(inputController.text);
              if (g != null && g > 0) {
                updateGoal(g);
                Get.back();
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
