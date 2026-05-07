import 'dart:math';

import 'package:flutter/material.dart';

class OrbitPainter extends CustomPainter {
  final double animationValue;

  OrbitPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final paint = Paint()
      ..color = Colors.blue.withOpacity(0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // الدواير
    canvas.drawCircle(center, 100, paint);
    canvas.drawCircle(center, 120, paint);
    canvas.drawCircle(center, 140, paint);

    final dotPaint = Paint()..color = Colors.blue;

    // النقط بتلف
    for (int i = 0; i < 4; i++) {
      double angle = (animationValue * 2 * pi) + (i * pi / 2);

      final x = center.dx + 120 * cos(angle);
      final y = center.dy + 120 * sin(angle);

      canvas.drawCircle(Offset(x, y), 6, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant OrbitPainter oldDelegate) => true;
}