import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/common/constants/gradient/custom_linear_gradient.dart';
import 'package:crm/common/constants/image_assets.dart';

class CustomSlideButton extends StatefulWidget {
  const CustomSlideButton({
    super.key,
    required this.title,
    this.done = true,
    this.enabled = true,
    required this.subTitle,
    required this.onFinish,
  });

  final String title;
  final String subTitle;
  final bool enabled;
  final bool done;
  final void Function() onFinish;

  @override
  // ignore: library_private_types_in_public_api
  _CustomSlideButtonState createState() => _CustomSlideButtonState();
}

class _CustomSlideButtonState extends State<CustomSlideButton> with SingleTickerProviderStateMixin {
  double xOffset = 8.0;
  double maxOffset = 0.0; // Akan dihitung berdasarkan lebar container
  late AnimationController _animationController;
  late Animation<double> _animation;
  final double paddingLeft = 8.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _resetPosition() {
    _animation = Tween<double>(begin: xOffset, end: paddingLeft).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.bounceOut),
    );

    _animation.addListener(() {
      setState(() {
        xOffset = _animation.value;
      });
    });

    _animationController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    final double sizeCircle = 36.h;
    final double maxHeight = 52.h;
    final double centerCircle = (maxHeight / 2) - (sizeCircle / 2);
    final double minOffset = paddingLeft;
    final double widthShadow = sizeCircle + (paddingLeft);

    return LayoutBuilder(
      builder: (context, constraints) {
        maxOffset = constraints.maxWidth - 44.w; // Menghitung batas maksimum pergerakan
        return Container(
          height: maxHeight,
          decoration: BoxDecoration(
            color: ColorsName.graySilver,
            borderRadius: BorderRadius.circular(24.r),
            gradient: widget.enabled
                ? widget.done
                    ? CustomLinearGradient.blueCyanGradient
                    : CustomLinearGradient.redGradient
                : null,
          ),
          child: Stack(
            children: [
              // Text dan Subtitle
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: EdgeInsets.only(right: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.title.tr, style: BaseText.white.copyWith(fontSize: 11.sp, fontWeight: FontWeight.w300)),
                      SizedBox(height: 2.h),
                      Text(widget.subTitle.tr, style: BaseText.white.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ),
              AnimatedOpacity(
                duration: Duration(milliseconds: 300),
                opacity: xOffset != minOffset ? .8 : .0,
                child: Container(
                  width: widthShadow + xOffset,
                  height: maxHeight,
                  decoration: BoxDecoration(
                    color: widget.done ? ColorsName.blueLight : ColorsName.redLight,
                    // gradient: widget.enabled? widget.done? CustomLinearGradient.blueCyanGradient : CustomLinearGradient.redGradient : null,
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                ),
              ),
              // GestureDetector untuk Drag
              Positioned(
                left: xOffset,
                bottom: centerCircle,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    if (!widget.enabled) return;
                    setState(() {
                      xOffset += details.delta.dx;
                      xOffset = xOffset.clamp(minOffset, maxOffset); // Membatasi gerakan
                    });
                  },
                  onPanEnd: (details) {
                    if (!widget.enabled) return;
                    _resetPosition(); // Mengembalikan ke posisi awal dengan animasi
                    if (xOffset >= maxOffset - 20.0) {
                      widget.onFinish();
                    }
                  },
                  child: Container(
                    height: sizeCircle,
                    width: sizeCircle,
                    decoration: BoxDecoration(color: ColorsName.white, borderRadius: BorderRadius.circular(24.r)),
                    child: Center(
                      child: SvgPicture.asset(
                        widget.enabled
                            ? widget.done
                                ? ImageAssets.iconSvgDoubleArrowBlue
                                : ImageAssets.iconSvgDoubleArrowRed
                            : ImageAssets.iconSvgDoubleArrowGray,
                        width: 11.7.w,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
