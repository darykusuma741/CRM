import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:crm/common/constants/image_assets.dart';

class SplashScreenLogo extends StatefulWidget {
  const SplashScreenLogo({super.key});

  @override
  State<SplashScreenLogo> createState() => _SplashScreenLogoState();
}

class _SplashScreenLogoState extends State<SplashScreenLogo> with TickerProviderStateMixin {
  late final AnimationController _revealController;

  late final Animation<double> _logoReveal;
  late final Animation<double> _scaleOceanReveal;
  late final Animation<double> _accelerateImpactReveal;

  @override
  void initState() {
    super.initState();

    _revealController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _logoReveal = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _revealController, curve: const Interval(0.3, 0.9, curve: Curves.easeOut)),
    );

    _scaleOceanReveal = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _revealController, curve: const Interval(0.3, 0.7, curve: Curves.easeOut)),
    );

    _accelerateImpactReveal = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _revealController, curve: const Interval(0.6, 1.0, curve: Curves.easeOut)),
    );

    _startAnimations();
  }

  void _startAnimations() {
    _revealController.forward();
  }

  @override
  void dispose() {
    _revealController.dispose();
    super.dispose();
  }

  Widget _masking({required Animation<double> animation, required Widget child}) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        return ClipRect(
          child: Align(
            alignment: Alignment.centerLeft,
            widthFactor: animation.value,
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _masking(
            animation: _logoReveal,
            child: SvgPicture.asset(
              ImageAssets.splashScreenLogo1Svg,
              height: 34.84.h,
            ),
          ),
          SizedBox(width: 7.13.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _masking(
                animation: _scaleOceanReveal,
                child: SvgPicture.asset(
                  ImageAssets.splashScreenLogo2Svg,
                  height: 21.71.h,
                ),
              ),
              SizedBox(height: 5.91.h),
              _masking(
                animation: _accelerateImpactReveal,
                child: SvgPicture.asset(
                  ImageAssets.splashScreenLogo3Svg,
                  height: 7.22.h,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
