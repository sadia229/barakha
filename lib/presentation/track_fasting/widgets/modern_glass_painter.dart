import 'dart:math';

import 'package:flutter/material.dart';

class ModernGlassPainter extends CustomPainter {
  final double fillPercentage;
  final double bubbleAnimation;

  ModernGlassPainter(
      {required this.fillPercentage, required this.bubbleAnimation});

  @override
  void paint(Canvas canvas, Size size) {
    final glassPaint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final glassStrokePaint = Paint()
      ..color = Colors.white.withOpacity(0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    final waterPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFF00b4db).withOpacity(0.8),
          const Color(0xFF0083b0).withOpacity(0.9),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final bubblePaint = Paint()
      ..color = Colors.white.withOpacity(0.6)
      ..style = PaintingStyle.fill;

    // Draw glass shape with rounded bottom
    final glassPath = Path()
      ..moveTo(size.width * 0.15, size.height * 0.05)
      ..quadraticBezierTo(size.width * 0.1, size.height * 0.02,
          size.width * 0.05, size.height * 0.05)
      ..lineTo(size.width * 0.05, size.height * 0.85)
      ..quadraticBezierTo(size.width * 0.05, size.height * 0.95,
          size.width * 0.15, size.height * 0.98)
      ..lineTo(size.width * 0.85, size.height * 0.98)
      ..quadraticBezierTo(size.width * 0.95, size.height * 0.95,
          size.width * 0.95, size.height * 0.85)
      ..lineTo(size.width * 0.95, size.height * 0.05)
      ..quadraticBezierTo(size.width * 0.9, size.height * 0.02,
          size.width * 0.85, size.height * 0.05)
      ..close();

    // Draw glass background
    canvas.drawPath(glassPath, glassPaint);
    canvas.drawPath(glassPath, glassStrokePaint);

    // Draw water with realistic effect
    if (fillPercentage > 0) {
      final waterHeight = size.height * 0.88 * fillPercentage;
      final waterY = size.height * 0.98 - waterHeight;

      // Water path with wave effect
      final waterPath = Path();
      final waveHeight = 4.0;
      final waveFrequency = 3.0;

      waterPath.moveTo(size.width * 0.05, size.height * 0.98);
      waterPath.lineTo(size.width * 0.05, waterY);

      // Create wave effect
      for (double x = size.width * 0.05; x <= size.width * 0.95; x += 2) {
        final normalizedX = (x - size.width * 0.05) / (size.width * 0.9);
        final waveY = waterY -
            waveHeight *
                (0.5 +
                    0.5 *
                        sin(waveFrequency * 2 * pi * normalizedX +
                            bubbleAnimation * 2 * pi));
        waterPath.lineTo(x, waveY);
      }

      waterPath.lineTo(size.width * 0.95, size.height * 0.98);
      waterPath.close();

      canvas.drawPath(waterPath, waterPaint);

      // Draw bubbles
      if (fillPercentage > 0.2) {
        _drawBubbles(canvas, size, waterY, waterHeight, bubblePaint);
      }
    }

    // Draw glass highlights and reflections
    _drawGlassHighlights(canvas, size);
  }

  void _drawBubbles(Canvas canvas, Size size, double waterY, double waterHeight,
      Paint bubblePaint) {
    final bubbleCount = 5;
    for (int i = 0; i < bubbleCount; i++) {
      final bubbleX = size.width * (0.2 + 0.6 * (i / bubbleCount));
      final bubbleY = waterY +
          waterHeight * (0.1 + 0.8 * (i / bubbleCount)) -
          (bubbleAnimation * waterHeight * 0.8);

      if (bubbleY > waterY && bubbleY < waterY + waterHeight) {
        final bubbleSize = 2.0 + 3.0 * (i / bubbleCount);
        canvas.drawCircle(
          Offset(bubbleX, bubbleY),
          bubbleSize,
          bubblePaint,
        );
      }
    }
  }

  void _drawGlassHighlights(Canvas canvas, Size size) {
    final highlightPaint = Paint()
      ..color = Colors.white.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    // Main highlight
    canvas.drawLine(
      Offset(size.width * 0.25, size.height * 0.15),
      Offset(size.width * 0.25, size.height * 0.75),
      highlightPaint,
    );

    // Secondary highlight
    final secondaryHighlightPaint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(size.width * 0.35, size.height * 0.1),
      Offset(size.width * 0.35, size.height * 0.6),
      secondaryHighlightPaint,
    );

    // Rim highlight
    final rimPaint = Paint()
      ..color = Colors.white.withOpacity(0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawPath(
      Path()
        ..moveTo(size.width * 0.15, size.height * 0.05)
        ..quadraticBezierTo(size.width * 0.1, size.height * 0.02,
            size.width * 0.05, size.height * 0.05),
      rimPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
