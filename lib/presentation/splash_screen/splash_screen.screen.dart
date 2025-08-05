import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:crm/common/components/custom_scaffold.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/image_assets.dart';
import 'package:crm/presentation/splash_screen/splash_screen.logo.dart';

import 'controllers/splash_screen.controller.dart';

class SplashScreenScreen extends GetView<SplashScreenController> {
  const SplashScreenScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      light: true,
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SvgPicture.asset(
              ImageAssets.splashScreenBgSvg,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Expanded(child: Container()),
              Text(
                'ScaleOcean CRM v1.2',
                style: BaseText.blueDusty.copyWith(
                  fontSize: 10.sp,
                ),
              ),
              SizedBox(height: 24.h)
            ],
          ),
          Hero(tag: 'logo-init', child: SplashScreenLogo()),
        ],
      ),
    );
  }
}
