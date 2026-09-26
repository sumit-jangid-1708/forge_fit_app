// lib/view_models/controllers/weight_tracker_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/local/hive_boxes.dart';
import '../../res/color/app_color.dart';

class WeightEntry {
  final String date;
  final String time;
  final double weight;
  final String diff;
  final bool isLoss;

  WeightEntry({
    required this.date,
    required this.time,
    required this.weight,
    required this.diff,
    required this.isLoss,
  });
}

class WeightTrackerController extends GetxController {

  // ── Weight Data ────────────────────────────────────────────
  final RxDouble currentWeight = 0.0.obs;
  final RxDouble startWeight   = 0.0.obs;
  final RxDouble goalWeight    = 0.0.obs;
  final RxList<WeightEntry> logs = <WeightEntry>[].obs;

  // ── Computed Values ────────────────────────────────────────
  double get lostKg =>
      (startWeight.value - currentWeight.value).clamp(0.0, double.infinity);

  double get toGoKg =>
      (currentWeight.value - goalWeight.value).clamp(0.0, double.infinity);

  double get lostPercent => startWeight.value > 0
      ? (lostKg / startWeight.value) * 100
      : 0.0;

  // Chart ke liye points (0.0 to 1.0)
  // Hive se last 6 entries ka normalized y position
  List<double> get chartPoints {
    if (logs.isEmpty) return [0.5, 0.5, 0.5, 0.5, 0.5, 0.5];
    final weights = logs.take(6).map((e) => e.weight).toList().reversed.toList();
    if (weights.length < 2) return [0.5, 0.5, 0.5, 0.5, 0.5, 0.5];
    final minW = weights.reduce((a, b) => a < b ? a : b);
    final maxW = weights.reduce((a, b) => a > b ? a : b);
    final range = maxW - minW;
    if (range == 0) return weights.map((_) => 0.5).toList();
    // Y axis flip karo — zyada weight = neeche
    return weights.map((w) => 1.0 - ((w - minW) / range)).toList();
  }

  @override
  void onInit() {
    super.onInit();
    _loadFromHive();
  }

  // ── Hive se load ───────────────────────────────────────────
  void _loadFromHive() {
    currentWeight.value = HiveBoxes.tracker.get(
      'current_weight', defaultValue: 0.0,
    );
    startWeight.value = HiveBoxes.tracker.get(
      'start_weight', defaultValue: 0.0,
    );
    goalWeight.value = HiveBoxes.tracker.get(
      'goal_weight', defaultValue: 0.0,
    );

    final savedLogs = HiveBoxes.tracker.get(
      'weight_logs', defaultValue: <dynamic>[],
    );
    logs.value = (savedLogs as List).map((e) {
      return WeightEntry(
        date:   e['date'],
        time:   e['time'],
        weight: e['weight'],
        diff:   e['diff'],
        isLoss: e['isLoss'],
      );
    }).toList();
  }

  // ── Hive mein save ─────────────────────────────────────────
  void _saveToHive() {
    HiveBoxes.tracker.put('current_weight', currentWeight.value);
    HiveBoxes.tracker.put('start_weight',   startWeight.value);
    HiveBoxes.tracker.put('goal_weight',    goalWeight.value);
    HiveBoxes.tracker.put('weight_logs', logs.map((e) => {
      'date':   e.date,
      'time':   e.time,
      'weight': e.weight,
      'diff':   e.diff,
      'isLoss': e.isLoss,
    }).toList());
  }

  // ── Weight Log karo ────────────────────────────────────────
  void logWeight(double weight) {
    final now     = DateTime.now();
    final hour    = now.hour;
    final min     = now.minute.toString().padLeft(2, '0');
    final amPm    = hour >= 12 ? 'PM' : 'AM';
    final hour12  = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    final timeStr = '$hour12:$min $amPm';

    // Date string
    final months  = ['Jan','Feb','Mar','Apr','May','Jun',
      'Jul','Aug','Sep','Oct','Nov','Dec'];
    final days    = ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'];
    final dateStr = logs.isNotEmpty &&
        logs.first.date.toLowerCase().contains('today')
        ? '${days[now.weekday - 1]}, ${now.day} ${months[now.month - 1]}'
        : 'Today';

    // Diff calculate karo
    String diff   = '';
    bool isLoss   = true;
    if (currentWeight.value > 0) {
      final d  = (currentWeight.value - weight).abs();
      diff     = d.toStringAsFixed(1);
      isLoss   = weight < currentWeight.value;
    }

    // Agar pehli entry hai to start weight set karo
    if (startWeight.value == 0.0) {
      startWeight.value = weight;
    }

    // Current weight update karo
    currentWeight.value = weight;

    // Log mein add karo — upar
    logs.insert(0, WeightEntry(
      date:   dateStr,
      time:   timeStr,
      weight: weight,
      diff:   diff,
      isLoss: isLoss,
    ));

    _saveToHive();

    Get.snackbar(
      '⚖️ Weight Logged',
      '${weight.toStringAsFixed(1)} kg saved successfully!',
      backgroundColor: AppColors.primary.withOpacity(0.15),
      colorText:       Colors.white,
      duration:        const Duration(seconds: 2),
      snackPosition:   SnackPosition.TOP,
    );
  }

  // ── Log Weight Dialog ──────────────────────────────────────
  void showLogWeightDialog() {
    final TextEditingController inputController = TextEditingController(
      text: currentWeight.value > 0
          ? currentWeight.value.toStringAsFixed(1)
          : '',
    );

    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF121212),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        title: const Text(
          'Log Today\'s Weight',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller:   inputController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              style:        const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText:      'Enter weight',
                hintStyle:     TextStyle(color: Colors.white.withOpacity(0.4)),
                suffixText:    'kg',
                suffixStyle:   TextStyle(color: AppColors.primary),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide:   BorderSide(color: Colors.white.withOpacity(0.1)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide:   BorderSide(color: AppColors.primary),
                ),
              ),
            ),
            if (goalWeight.value == 0.0) ...[
              const SizedBox(height: 16),
              Text(
                'Also set your goal weight:',
                style: TextStyle(
                  color:    Colors.white.withOpacity(0.5),
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                style:        const TextStyle(color: Colors.white),
                onChanged: (v) {
                  goalWeight.value = double.tryParse(v) ?? 0.0;
                },
                decoration: InputDecoration(
                  hintText:      'Goal weight (optional)',
                  hintStyle:     TextStyle(color: Colors.white.withOpacity(0.4)),
                  suffixText:    'kg',
                  suffixStyle:   TextStyle(color: AppColors.primary),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide:   BorderSide(color: Colors.white.withOpacity(0.1)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide:   BorderSide(color: AppColors.primary),
                  ),
                ),
              ),
            ],
          ],
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
              final weight = double.tryParse(inputController.text);
              if (weight != null && weight > 0) {
                Get.back();
                logWeight(weight);
              } else {
                Get.snackbar('Error', 'Please enter a valid weight');
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Save', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}