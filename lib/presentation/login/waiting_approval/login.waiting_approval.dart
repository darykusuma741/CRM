import 'package:crm/common/components/custom_circle_loader.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/image_assets.dart';
import 'package:crm/presentation/login/controllers/login.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class LoginWaitingApproval extends GetView<LoginController> {
  const LoginWaitingApproval({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(ImageAssets.loginGroup2, width: 165.64.w),
        SizedBox(height: 16.h),
        Text(
          'Waiting for Approval',
          style: BaseText.blueDarkest.copyWith(fontSize: 18.sp, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 6.h),
        Text(
          'Please allow your administrator to\napprove your request.',
          textAlign: TextAlign.center,
          style: BaseText.grayDark.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w400),
        ),
        SizedBox(height: 32.h),
        CustomCircleLoader(),
      ],
    );
  }
}
