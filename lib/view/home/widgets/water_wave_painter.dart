import 'dart:math';
import 'package:flutter/material.dart';
import '../../../res/color/app_color.dart';

class WaterWavePainter extends CustomPainter {
  final double progress;
  WaterWavePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = AppColors.info;
    final path = Path();

    final y = size.height * (1 - progress);
    
    path.moveTo(0, y);
    
    // Simple wave effect
    for (double i = 0; i <= size.width; i++) {
      path.lineTo(i, y + 4 * sin((i / size.width * 2 * pi)));
    }
    
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.clipPath(Path()..addOval(Rect.fromLTWH(0, 0, size.width, size.height)));
    canvas.drawPath(path, paint);
    
    // Draw subtle border
    final borderPaint = Paint()
      ..color = AppColors.info.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), size.width / 2, borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
