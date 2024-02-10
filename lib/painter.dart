import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math';

class TemporalShiftPainter extends CustomPainter {
  final double animationValue;
  final double minRadius;
  final double maxRadius;
  final bool Function() clockwiseRotation;

  TemporalShiftPainter(this.animationValue,
      {required this.minRadius,
      required this.maxRadius,
      required this.clockwiseRotation});

  @override
  void paint(Canvas canvas, Size size) {
    double radius;
    if (animationValue < 0.5) {
      radius = lerpDouble(minRadius, maxRadius, animationValue * 2)!;
    } else {
      radius = lerpDouble(maxRadius, minRadius, (animationValue - 0.5) * 2)!;
    }

    final Offset center = Offset(size.width / 2, size.height / 2);
    final Paint centerPaint = Paint()..color = Colors.green;
    canvas.drawCircle(center, radius, centerPaint);

    // Draw particles within the glow effect and rotate them around the big circle
    const int numParticles = 6;
    const double angleIncrement = 2 * pi / numParticles;
    const double particleRadius = 5.0;
    double particleDistance = radius * 1.5;

    // Draw the glow effect with variable opacity based on radius
    final double glowOpacity =
        1.0 - (radius - minRadius) / (maxRadius - minRadius);
    final Paint glowPaint = Paint()
      ..color = Colors.green.withOpacity(glowOpacity.clamp(0.5, 1.0))
      ..strokeWidth = particleRadius * 2; // Set the stroke width;

    bool clockwise = clockwiseRotation();
    for (int i = 0; i < numParticles; i++) {
      double angle = i * angleIncrement;
      double rotationAngle = angle;

      if (clockwise) {
        rotationAngle += 2 * pi * animationValue;
      } else {
        rotationAngle -= 2 * pi * animationValue;
      }

      final Offset particleCenter = center +
          Offset(cos(rotationAngle) * particleDistance,
              sin(rotationAngle) * particleDistance);
      canvas.drawCircle(particleCenter, particleRadius, centerPaint);

      // Draw particle trails
      final double prevX =
          center.dx + cos(rotationAngle - angleIncrement) * particleDistance;
      final double prevY =
          center.dy + sin(rotationAngle - angleIncrement) * particleDistance;
      canvas.drawLine(Offset(prevX, prevY), particleCenter, glowPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
