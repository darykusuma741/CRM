import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/image_assets.dart';
import 'package:crm/presentation/login/controllers/login.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class LoginHeader extends GetView<LoginController> {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text('Powered by', style: BaseText.grayDark.copyWith(fontSize: 10.sp, fontWeight: FontWeight.w400)),
        SizedBox(height: 2.h),
        SvgPicture.asset(ImageAssets.loginLogo1, width: 90.w),
      ],
    );
  }
}
