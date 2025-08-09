import 'package:crm/common/constants/colors_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomInkWell extends StatefulWidget {
  const CustomInkWell({super.key, this.child, this.padding, this.onTap, this.height, this.width, this.decoration, this.splashColor});
  final Widget? child;
  final void Function()? onTap;
  final double? height;
  final double? width;
  final BoxDecoration? decoration;
  final Color? splashColor;
  final EdgeInsetsGeometry? padding;

  @override
  State<CustomInkWell> createState() => _CustomInkWellState();
}

class _CustomInkWellState extends State<CustomInkWell> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final spColor = (widget.splashColor ?? ColorsName.grayDark).withOpacity(0.1);
    return InkWell(
      borderRadius: (widget.decoration?.borderRadius ?? BorderRadius.circular(100.r)) as BorderRadius,
      onTap: widget.onTap,
      onHighlightChanged: (value) {
        setState(() {
          _isPressed = value;
        });
      },
      overlayColor: MaterialStatePropertyAll(spColor),
      splashColor: spColor,
      highlightColor: spColor,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        height: widget.height,
        width: widget.width,
        padding: widget.padding,
        decoration: widget.decoration?.copyWith(
          color: _isPressed ? spColor : widget.decoration?.color ?? ColorsName.white,
          border: widget.decoration?.border,
          borderRadius: widget.decoration?.borderRadius ?? BorderRadius.circular(100.r),
        ),
        child: widget.child,
      ),
    );
  }
}
