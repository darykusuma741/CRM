import 'dart:ui';

import 'package:flutter/material.dart';

class CustomDashContainer extends StatelessWidget {
  final double radius;
  final Color color;
  final double strokeWidth;
  final List<double> dashPattern;
  final Widget? child;

  const CustomDashContainer({
    super.key,
    this.radius = 8,
    this.color = Colors.grey,
    this.strokeWidth = 1.5,
    this.dashPattern = const [6, 3], // garis & jarak
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedRadiusPainter(
        radius: radius,
        color: color,
        strokeWidth: strokeWidth,
        dashPattern: dashPattern,
      ),
      child: child, // 🔹 Tanpa padding lagi
    );
  }
}

class _DashedRadiusPainter extends CustomPainter {
  final double radius;
  final Color color;
  final double strokeWidth;
  final List<double> dashPattern;

  _DashedRadiusPainter({
    required this.radius,
    required this.color,
    required this.strokeWidth,
    required this.dashPattern,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(radius),
    );

    final path = Path()..addRRect(rrect);

    // Pola dash
    double dashOn = dashPattern[0];
    double dashOff = dashPattern[1];
    double distance = 0.0;

    for (PathMetric pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        final next = distance + dashOn;
        canvas.drawPath(
          pathMetric.extractPath(distance, next.clamp(0.0, pathMetric.length)),
          paint,
        );
        distance = next + dashOff;
      }
      distance = 0.0; // reset untuk segmen berikutnya
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
