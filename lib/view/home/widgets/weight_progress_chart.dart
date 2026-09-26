import 'package:flutter/material.dart';
import '../../../res/color/app_color.dart';
import '../../../res/fonts/app_fonts.dart';
import '../../../res/app_strings/app_strings.dart';

class WeightProgressChart extends StatelessWidget {
  final double       currentWeight;
  final double       lostKg;
  final double       lostPercent;
  final List<double> chartPoints;

  const WeightProgressChart({
    super.key,
    required this.currentWeight,
    required this.lostKg,
    required this.lostPercent,
    required this.chartPoints,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color:        AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(32),
        border:       Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.currentWeight,
                style: AppFonts.labelSmall.copyWith(
                  color:        AppColors.textMuted,
                  letterSpacing: 1.2,
                ),
              ),
              Text(
                AppStrings.vsStart,
                style: AppFonts.labelSmall.copyWith(
                  color:    AppColors.textMuted,
                  fontSize: 9,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment:  MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // ✅ Dynamic current weight
                  Text(
                    currentWeight > 0
                        ? currentWeight.toStringAsFixed(1)
                        : '--',
                    style: AppFonts.displayLarge.copyWith(fontSize: 48),
                  ),
                  const SizedBox(width: 8),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      'kg',
                      style: AppFonts.headlineMedium.copyWith(
                        color: AppColors.textMuted,
                      ),
                    ),
                  ),
                ],
              ),
              // ✅ Dynamic lost kg
              if (lostKg > 0)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.arrow_downward_rounded,
                          color: AppColors.primary,
                          size:  18,
                        ),
                        Text(
                          ' ${lostKg.toStringAsFixed(1)}kg',
                          style: AppFonts.headlineSmall.copyWith(
                            color:      AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${lostPercent.toStringAsFixed(1)}% lost',
                      style: AppFonts.bodySmall.copyWith(
                        color:    AppColors.textMuted,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 32),

          // ✅ Dynamic chart
          SizedBox(
            height: 120,
            width:  double.infinity,
            child:  CustomPaint(
              painter: WeightLinePainter(points: chartPoints),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: ['Jan','Feb','Mar','Apr','May','Jun'].map((month) {
              final isSelected = month == 'Jun';
              return Text(
                month,
                style: AppFonts.labelSmall.copyWith(
                  color:      isSelected ? AppColors.primary : AppColors.textMuted,
                  fontSize:   10,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class WeightLinePainter extends CustomPainter {
  final List<double> points;

  const WeightLinePainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    if (points.length < 2) return;

    final paint = Paint()
      ..color       = AppColors.primary
      ..strokeWidth = 3
      ..style       = PaintingStyle.stroke
      ..strokeCap   = StrokeCap.round;

    final path = Path();
    final step = size.width / (points.length - 1);

    for (int i = 0; i < points.length; i++) {
      final x = i * step;
      final y = points[i] * size.height;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        // Smooth bezier curve
        final prevX = (i - 1) * step;
        final prevY = points[i - 1] * size.height;
        final cpX   = (prevX + x) / 2;
        path.cubicTo(cpX, prevY, cpX, y, x, y);
      }
    }

    // Fill gradient
    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin:  Alignment.topCenter,
        end:    Alignment.bottomCenter,
        colors: [
          AppColors.primary.withOpacity(0.3),
          AppColors.primary.withOpacity(0.0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final fillPath = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, paint);

    // End dot
    final lastX  = size.width;
    final lastY  = points.last * size.height;

    canvas.drawCircle(
      Offset(lastX, lastY),
      8,
      Paint()
        ..color      = AppColors.primary.withOpacity(0.4)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
    );
    canvas.drawCircle(
      Offset(lastX, lastY),
      4,
      Paint()..color = AppColors.primary,
    );
  }

  @override
  bool shouldRepaint(WeightLinePainter old) => old.points != points;
}