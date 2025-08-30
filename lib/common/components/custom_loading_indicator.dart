import 'package:flutter/material.dart';

class CustomLoadingIndicator extends StatelessWidget {
  final Widget Function(CustomLoadingIndicatorParameter?)? customIndicator;
  final CustomLoadingIndicatorParameter? customLoadingIndicatorParameter;

  const CustomLoadingIndicator({
    super.key,
    this.customIndicator,
    this.customLoadingIndicatorParameter,
  });

  @override
  Widget build(BuildContext context) {
    return customIndicator != null ? customIndicator!(customLoadingIndicatorParameter) : CircularProgressIndicator(color: customLoadingIndicatorParameter?.color);
  }
}

class CustomLoadingIndicatorParameter {
  Color? color;

  CustomLoadingIndicatorParameter({
    required this.color
  });
}