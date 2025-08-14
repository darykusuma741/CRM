import 'package:flutter/material.dart';

class CustomGradientText extends StatelessWidget {
  const CustomGradientText({super.key, required this.text, this.style});
  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color(0xFF55B9FF),
          Color(0xFF1B9EF7),
          Color(0xFF18E0FB),
        ],
        stops: [0.0197, 0.4703, 0.9906], // sesuai persentase CSS
      ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      child: Text(
        text,
        style: style,
      ),
    );
  }
}
