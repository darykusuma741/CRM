import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/image_assets.dart';
import 'package:crm/presentation/login/controllers/login.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class LoginCenterContent extends GetView<LoginController> {
  const LoginCenterContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(ImageAssets.loginGroup1, width: 120.w),
        SizedBox(height: 16.h),
        Text(
          'Boost Your Sales Efficiency',
          style: BaseText.blueDarkest.copyWith(fontSize: 18.sp, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 6.h),
        Text(
          'Track visits, manage meetings,\nand view your pipeline',
          textAlign: TextAlign.center,
          style: BaseText.grayDark.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
