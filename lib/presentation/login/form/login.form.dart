import 'package:crm/common/components/custom_button.dart';
import 'package:crm/common/components/custom_text_editing.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/presentation/login/controllers/login.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginForm extends GetView<LoginController> {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 15.5.w),
        child: Column(
          children: [
            CustomTextEditing(
              label: 'Email',
              hint: 'Enter your email',
              controller: controller.ctrUser.value,
              error: controller.errUser.value,
            ),
            SizedBox(height: 16.h),
            CustomTextEditing(
              label: 'Password',
              hint: 'Enter your password',
              passwordField: true,
              controller: controller.ctrPass.value,
              error: controller.errPass.value,
            ),
            SizedBox(height: 32.h),
            InkWell(
              onTap: () {
                controller.saveLogin.value = !controller.saveLogin.value;
              },
              child: Row(
                children: [
                  Icon(controller.saveLogin.value ? Icons.check_box_rounded : Icons.check_box_outline_blank_rounded,
                      color: controller.saveLogin.value ? ColorsName.blueDeep : ColorsName.grayPlatinum, size: 20.sp),
                  SizedBox(width: 6.w),
                  Text('Save for future login'.tr, style: BaseText.grayGraphiteDark.copyWith(fontSize: 11.sp)),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            CustomButton(
              onTap: controller.onCLickLogin,
              title: 'Login',
            )
          ],
        ),
      );
    });
  }
}
