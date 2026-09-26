import 'package:flutter/material.dart';
import '../../../res/color/app_color.dart';
import '../../../res/fonts/app_fonts.dart';

class RecentWeightLogTile extends StatelessWidget {
  final String date;
  final String time;
  final String weight;
  final String diff;
  final bool isLoss;

  const RecentWeightLogTile({
    super.key,
    required this.date,
    required this.time,
    required this.weight,
    required this.diff,
    this.isLoss = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                date,
                style: AppFonts.titleMedium.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                '$time · fasting',
                style: AppFonts.bodySmall.copyWith(color: AppColors.textMuted),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$weight kg',
                style: AppFonts.titleLarge.copyWith(fontWeight: FontWeight.bold),
              ),
              if (diff.isNotEmpty)
                Row(
                  children: [
                    Icon(
                      isLoss ? Icons.arrow_downward_rounded : Icons.arrow_upward_rounded,
                      color: AppColors.primary,
                      size: 12,
                    ),
                    Text(
                      ' $diff',
                      style: AppFonts.bodySmall.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}
