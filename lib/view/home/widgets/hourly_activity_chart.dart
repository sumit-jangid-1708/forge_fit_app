import 'package:flutter/material.dart';
import '../../../res/color/app_color.dart';
import '../../../res/fonts/app_fonts.dart';

class HourlyActivityChart extends StatelessWidget {
  final List<double> data;
  final int          peakHourIndex;

  const HourlyActivityChart({
    super.key,
    required this.data,
    required this.peakHourIndex,
  });

  @override
  Widget build(BuildContext context) {
    final times = ['7am','8','9','10','11','12','1pm','2'];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color:        AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(24),
        border:       Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'HOURLY ACTIVITY',
            style: AppFonts.labelSmall.copyWith(
              color:        AppColors.textMuted,
              letterSpacing: 1.5,
              fontWeight:   FontWeight.w800,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(data.length, (index) {
              final isHighlighted = index == peakHourIndex;
              final height = (80 * data[index]).clamp(4.0, 80.0);

              return Column(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    curve:    Curves.easeOut,
                    height:   height,
                    width:    28,
                    decoration: BoxDecoration(
                      color:        isHighlighted
                          ? AppColors.primary
                          : const Color(0xFF2C1A14),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    times[index],
                    style: AppFonts.labelSmall.copyWith(
                      color:    isHighlighted
                          ? AppColors.primary
                          : AppColors.textMuted,
                      fontSize: 10,
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}