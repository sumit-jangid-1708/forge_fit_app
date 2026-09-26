// lib/view_models/controllers/water_tracker_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/local/hive_boxes.dart';

class WaterEntry {
  final String time;
  final String label;
  final double amount; // ml mein
  final Color color;

  WaterEntry({
    required this.time,
    required this.label,
    required this.amount,
    required this.color,
  });
}

class WaterTrackerController extends GetxController {

  // ── Water Data ─────────────────────────────────────────────
  final RxDouble totalIntake = 0.0.obs; // litres mein
  final RxDouble dailyGoal   = 3.0.obs; // litres mein
  final RxList<WaterEntry> logs = <WaterEntry>[].obs;

  // Progress 0.0 → 1.0
  double get progress =>
      (totalIntake.value / dailyGoal.value).clamp(0.0, 1.0);

  // Remaining
  double get remaining =>
      (dailyGoal.value - totalIntake.value).clamp(0.0, dailyGoal.value);

  @override
  void onInit() {
    super.onInit();
    _loadFromHive();
  }

  // ── Hive se load karo ──────────────────────────────────────
  void _loadFromHive() {
    // Aaj ki date check karo — naya din ho to reset karo
    final today     = DateTime.now();
    final savedDate = HiveBoxes.tracker.get(
      'water_date',
      defaultValue: '',
    );
    final todayStr = '${today.year}-${today.month}-${today.day}';

    if (savedDate != todayStr) {
      // Naya din — reset karo
      _resetDay(todayStr);
    } else {
      // Same din — saved data load karo
      totalIntake.value = HiveBoxes.tracker.get(
        HiveBoxes.keyWaterToday,
        defaultValue: 0.0,
      );

      // Logs load karo
      final savedLogs = HiveBoxes.tracker.get(
        'water_logs',
        defaultValue: <dynamic>[],
      );
      logs.value = (savedLogs as List).map((e) {
        return WaterEntry(
          time:   e['time'],
          label:  e['label'],
          amount: e['amount'],
          color:  Color(e['color']),
        );
      }).toList();
    }
  }

  // ── Naya din reset ─────────────────────────────────────────
  void _resetDay(String todayStr) {
    totalIntake.value = 0.0;
    logs.clear();
    HiveBoxes.tracker.put('water_date',          todayStr);
    HiveBoxes.tracker.put(HiveBoxes.keyWaterToday, 0.0);
    HiveBoxes.tracker.put('water_logs',          []);
  }

  // ── Quick Add ──────────────────────────────────────────────
  void addWater(double ml) {
    final litres = ml / 1000;
    totalIntake.value = (totalIntake.value + litres);

    // Log entry banao
    final now   = TimeOfDay.now();
    final hour  = now.hour;
    final min   = now.minute.toString().padLeft(2, '0');
    final amPm  = hour >= 12 ? 'PM' : 'AM';
    final hour12 = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    final time  = '$hour12:$min $amPm';

    // Label decide karo
    String label;
    final colors = [
      Colors.blue,
      Colors.purple,
      Colors.tealAccent,
      Colors.cyan,
      Colors.indigo,
    ];
    final color = colors[logs.length % colors.length];

    if (hour < 10) {
      label = 'Morning hydration';
    } else if (hour < 13) {
      label = 'Pre-workout';
    } else if (hour < 16) {
      label = 'Post-workout';
    } else if (hour < 19) {
      label = 'Afternoon hydration';
    } else {
      label = 'Evening hydration';
    }

    final entry = WaterEntry(
      time:   time,
      label:  label,
      amount: ml,
      color:  color,
    );

    logs.insert(0, entry); // Naya entry upar dikhao

    // Hive mein save karo
    _saveToHive();

    // HomeController ko bhi update karo (Home screen par reflect ho)
    try {
      // ignore: avoid_catches_without_on_clauses
    } catch (_) {}

    // Success message
    Get.snackbar(
      '💧 Water Added',
      '${ml.toInt()} ml added — keep it up!',
      backgroundColor: Colors.blue.withOpacity(0.15),
      colorText:        Colors.white,
      duration:         const Duration(seconds: 2),
      snackPosition:    SnackPosition.TOP,
    );
  }

  // ── Custom Amount ──────────────────────────────────────────
  void showCustomAmountDialog() {
    final TextEditingController inputController = TextEditingController();

    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF121212),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        title: const Text(
          'Add Custom Amount',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: TextField(
          controller:   inputController,
          keyboardType: TextInputType.number,
          style:        const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText:      'Enter amount in ml',
            hintStyle:     TextStyle(color: Colors.white.withOpacity(0.4)),
            suffixText:    'ml',
            suffixStyle:   const TextStyle(color: Colors.blue),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide:   BorderSide(color: Colors.white.withOpacity(0.1)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide:   const BorderSide(color: Colors.blue),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.white.withOpacity(0.5)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final amount = double.tryParse(inputController.text);
              if (amount != null && amount > 0) {
                Get.back();
                addWater(amount);
              } else {
                Get.snackbar('Error', 'Please enter a valid amount');
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:  Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Add', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // ── Hive mein save karo ────────────────────────────────────
  void _saveToHive() {
    HiveBoxes.tracker.put(
      HiveBoxes.keyWaterToday,
      totalIntake.value,
    );
    HiveBoxes.tracker.put(
      'water_logs',
      logs.map((e) => {
        'time':   e.time,
        'label':  e.label,
        'amount': e.amount,
        'color':  e.color.value,
      }).toList(),
    );
  }
}