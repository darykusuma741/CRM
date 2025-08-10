import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    super.key,
    this.onTap,
    this.height,
    this.titleSize,
    this.border = false,
    required this.title,
    this.enable = true,
    this.borderCustom,
    this.iconWidget,
    this.bgColor,
  });

  final void Function()? onTap;
  final String title;
  final double? titleSize;
  final double? height;
  final bool border;
  final Widget? iconWidget;
  final bool enable;
  final BoxBorder? borderCustom;
  final Color? bgColor;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 200),
        tween: Tween<double>(begin: 1.0, end: _isPressed ? 0.98 : 1.0),
        builder: (context, scale, child) {
          return Transform.scale(
            scale: scale,
            child: Ink(
              decoration: BoxDecoration(
                color: !widget.enable
                    ? ColorsName.bluePastel
                    : widget.border
                        ? Colors.transparent
                        : _isPressed
                            ? ColorsName.blueDeep.withOpacity(0.6)
                            : widget.bgColor ?? ColorsName.blueSteel,
                borderRadius: BorderRadius.circular(6.r),
                border: widget.borderCustom,
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(6.r),
                onTap: widget.onTap,
                splashColor: ColorsName.blueDeep,
                onHighlightChanged: (value) {
                  setState(() {
                    _isPressed = value;
                  });
                },
                child: Container(
                  width: double.infinity.w,
                  height: widget.height ?? 40.h,
                  alignment: Alignment.center,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.iconWidget != null) widget.iconWidget!,
                      if (widget.iconWidget != null) SizedBox(width: 4.w),
                      Text(
                        widget.title,
                        style: (widget.border ? BaseText.blueDeep : BaseText.white).copyWith(fontSize: widget.titleSize ?? 14.sp, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
