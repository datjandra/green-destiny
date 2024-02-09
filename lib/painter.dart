import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math';

class TemporalShiftPainter extends CustomPainter {
  late double _animationValue;
  final double minRadius;
  final double maxRadius;
  bool clockwiseRotation;

  TemporalShiftPainter(
      {required this.minRadius,
      required this.maxRadius,
      required double initialAnimationValue,
      this.clockwiseRotation = true})
      : _animationValue = initialAnimationValue;

  double get animationValue => _animationValue;
  set animationValue(double value) {
    _animationValue = value;
    // Trigger a repaint by calling `markNeedsRepaint()`
  }

  void setClockwiseRotation(bool value) {
    clockwiseRotation = value;
  }

  @override
  void paint(Canvas canvas, Size size) {
    double radius;
    if (animationValue < 0.5) {
      radius = lerpDouble(minRadius, maxRadius, animationValue * 2)!;
    } else {
      radius = lerpDouble(maxRadius, minRadius, (animationValue - 0.5) * 2)!;
    }

    final Offset center = Offset(size.width / 2, size.height / 2);

    final Paint glowPaint = Paint()
      ..color = Colors.green.withOpacity(0.5)
      ..maskFilter = MaskFilter.blur(BlurStyle.outer, 10.0);

    final Paint particlePaint = Paint()..color = Colors.green;

    // Draw the glow effect
    canvas.drawCircle(center, radius, glowPaint);

    // Draw particles within the glow effect and rotate them around the big circle
    const int numParticles = 20;
    const double angleIncrement = 2 * pi / numParticles;
    const double particleRadius = 5.0;
    double particleDistance = radius * 1.5;

    const bool clockwiseRotation = false;

    for (int i = 0; i < numParticles; i++) {
      double angle = i * angleIncrement;
      double rotationAngle = angle;

      if (clockwiseRotation) {
        rotationAngle += 2 * pi * animationValue;
      } else {
        rotationAngle -= 2 * pi * animationValue;
      }

      final Offset particleCenter = center +
          Offset(cos(rotationAngle) * particleDistance,
              sin(rotationAngle) * particleDistance);
      canvas.drawCircle(particleCenter, particleRadius, particlePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
