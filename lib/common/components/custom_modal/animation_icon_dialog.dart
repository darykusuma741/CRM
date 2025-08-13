import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';

class AnimatedIconDialog extends StatefulWidget {
  final String title;
  final String subTitle;
  final String imageIcon;
  final Color? color;
  final double sizeCheck;
  final double padding;

  const AnimatedIconDialog({
    super.key,
    required this.title,
    required this.subTitle,
    required this.imageIcon,
    required this.color,
    required this.sizeCheck,
    required this.padding,
  });

  @override
  State<AnimatedIconDialog> createState() => AnimatedIconDialogState();
}

class AnimatedIconDialogState extends State<AnimatedIconDialog> with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _borderController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _borderAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    _borderController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.3).chain(CurveTween(curve: Curves.easeOut)), weight: 35),
      TweenSequenceItem(tween: Tween(begin: 1.3, end: .7).chain(CurveTween(curve: Curves.easeIn)), weight: 35),
      TweenSequenceItem(tween: Tween(begin: 0.7, end: 1.0).chain(CurveTween(curve: Curves.easeIn)), weight: 30),
    ]).animate(_scaleController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _borderController.forward(); // jalankan setelah scale selesai
        }
      });

    _borderAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: .0, end: 6.0).chain(CurveTween(curve: Curves.easeOut)), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 6.0, end: 4.46).chain(CurveTween(curve: Curves.easeIn)), weight: 50),
    ]).animate(_borderController);
    _scaleController.forward();
    // _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _borderController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // White box (modal)
        Container(
          width: MediaQuery.of(context).size.width - (widget.padding * 2),
          padding: EdgeInsets.only(top: widget.sizeCheck / 2),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 14.h),
              Text(widget.title,
                  style: BaseText.grayCharcoalDark.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w500, decoration: TextDecoration.none),
                  textAlign: TextAlign.center),
              SizedBox(height: 7.h),
              Text(widget.subTitle,
                  textAlign: TextAlign.center,
                  style: BaseText.grayShadow
                      .copyWith(fontSize: 12.sp, height: 1.5, letterSpacing: 0.0, fontWeight: FontWeight.w300, decoration: TextDecoration.none)),
              SizedBox(height: 16.h),
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  height: 40.h,
                  margin: EdgeInsets.symmetric(horizontal: 14.w),
                  decoration: BoxDecoration(
                    color: ColorsName.blueDeep,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Center(
                    child: Text('OK', style: BaseText.white.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w500, decoration: TextDecoration.none)),
                  ),
                ),
              ),
              SizedBox(height: 14.h),
            ],
          ),
        ),

        // Icon container with animated scale
        Positioned(
          left: 0,
          right: 0,
          top: -widget.sizeCheck / 2,
          child: Center(
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: AnimatedBuilder(
                animation: _borderController,
                builder: (context, child) {
                  return Container(
                    width: widget.sizeCheck,
                    height: widget.sizeCheck,
                    decoration: BoxDecoration(
                      color: widget.color,
                      shape: BoxShape.circle,
                      border: _borderAnimation.value == 0 ? null : Border.all(color: ColorsName.white, width: _borderAnimation.value.r),
                    ),
                    child: Center(
                      child: SvgPicture.asset(widget.imageIcon),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
