import 'dart:math';
import 'package:flutter/material.dart';

class CustomCircleLoader extends StatefulWidget {
  const CustomCircleLoader({super.key});

  @override
  State<CustomCircleLoader> createState() => _CustomCircleLoaderState();
}

class _CustomCircleLoaderState extends State<CustomCircleLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double radius = 33;
    int dotCount = 10;

    final colors = [
      const Color(0xFF0C304E),
      const Color(0xFF123A5C),
      const Color(0xFF17436B),
      const Color(0xFF2B5279),
      const Color(0xFF4A7BAF),
      const Color(0xFF6F96BF),
      const Color(0xFF94B1D0),
      const Color(0xFFB8CCE0),
      const Color(0xFFDDE7F0),
      Colors.white,
      Colors.white,
      Colors.white,
    ];

    return UnconstrainedBox(
      child: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return SizedBox(
              width: (radius + 14) * 2,
              height: (radius + 14) * 2,
              child: Stack(
                alignment: Alignment.center,
                children: List.generate(dotCount, (index) {
                  // Sudut diputar oleh animasi
                  double angle = (2 * pi / dotCount) * index - (2 * pi * _controller.value);

                  double x = radius * cos(angle);
                  double y = radius * sin(angle);

                  return Positioned(
                    left: x + radius + 7, // + setengah ukuran titik
                    top: y + radius + 7,
                    child: Container(
                      width: 6.4,
                      height: 6.4,
                      decoration: BoxDecoration(
                        color: colors[index % colors.length],
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                }),
              ),
            );
          },
        ),
      ),
    );
  }
}
