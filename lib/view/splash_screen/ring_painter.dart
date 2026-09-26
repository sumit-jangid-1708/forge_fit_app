import 'dart:math';
import 'package:flutter/material.dart';
import '../../res/color/app_color.dart';

// CustomPainter: Flutter mein canvas par directly draw karne ke liye
// Jab koi built-in widget kaam na aaye (jaise rotating arc)
// tab CustomPainter use karte hain
class RingPainter extends CustomPainter {
  final double progress; // controller se aata hai: 0.0 → 1.0

  const RingPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - 8; // 8px andar taaki edges clip na ho

    // ── Step 1: Background ring ───────────────────────────────
    // Poora dark circle jo background mein dikhta hai
    final bgPaint = Paint()
      ..color       = AppColors.surfaceLight   // #1A1A1A dark grey
      ..strokeWidth = 8.0
      ..style       = PaintingStyle.stroke     // sirf border, andar fill nahi
      ..strokeCap   = StrokeCap.round;         // ends gol honge

    canvas.drawCircle(center, radius, bgPaint);

    // ── Step 2: Gradient arc ──────────────────────────────────
    // Yeh orange arc hai jo progress ke saath ghoomta hai
    final rect = Rect.fromCircle(center: center, radius: radius);

    // SweepGradient: arc ke along color change karta hai
    final gradient = SweepGradient(
      startAngle: 0.0,
      endAngle:   2 * pi,
      colors: [
        Colors.transparent,      // arc ka start → transparent
        AppColors.secondary,     // #FC3B00 deep orange
        AppColors.primary,       // #FF6129 bright orange
      ],
      stops: const [0.0, 0.5, 1.0],
      // GradientRotation: progress ke saath rotate karo
      transform: GradientRotation(2 * pi * progress),
    );

    final arcPaint = Paint()
      ..shader      = gradient.createShader(rect)
      ..strokeWidth = 8.0
      ..style       = PaintingStyle.stroke
      ..strokeCap   = StrokeCap.round;

    // drawArc(rect, startAngle, sweepAngle, useCenter, paint)
    // startAngle: -pi/2 = 12 baje se shuru (upar se)
    // + (2*pi*progress) = progress ke saath ghoomta hai
    // sweepAngle: 1.5*pi = 270 degree ka arc (poora nahi)
    canvas.drawArc(
      rect,
      -pi / 2 + (2 * pi * progress), // rotating start point
      1.5 * pi,                        // 270 degree arc
      false,                           // center tak line nahi
      arcPaint,
    );

    // ── Step 3: Glowing dot (arc ke end par) ──────────────────
    // Arc ke aakhiri point par ek chamakta dot dikhata hai
    final dotAngle = -pi / 2 + (2 * pi * progress) + (1.5 * pi);
    final dotX     = center.dx + radius * cos(dotAngle);
    final dotY     = center.dy + radius * sin(dotAngle);

    // Outer soft glow
    canvas.drawCircle(
      Offset(dotX, dotY),
      7,
      Paint()
        ..color      = AppColors.primary.withOpacity(0.35)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8),
    );

    // Inner solid dot
    canvas.drawCircle(
      Offset(dotX, dotY),
      4,
      Paint()..color = AppColors.primary, // #FF6129
    );
  }

  // shouldRepaint: kab redraw kare
  // progress change ho tab hi repaint karo — performance ke liye
  @override
  bool shouldRepaint(RingPainter oldDelegate) =>
      oldDelegate.progress != progress;
}