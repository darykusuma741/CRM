import 'package:crm/common/components/custom_scaffold.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/presentation/login/center_content/login.center_content.dart';
import 'package:crm/presentation/login/form/login.form.dart';
import 'package:crm/presentation/login/header/login.header.dart';
import 'package:crm/presentation/login/waiting_approval/login.waiting_approval.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'controllers/login.controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    double paddingTop = MediaQuery.of(context).padding.top;

    return Obx(() {
      return CustomScaffold(
        backgroundColor: ColorsName.white,
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 16.h + paddingTop),
                LoginHeader(),
                (controller.waitingApproval.value)
                    ? Column(
                        children: [
                          SizedBox(height: 153.68.h),
                          LoginWaitingApproval(),
                        ],
                      )
                    : Column(
                        children: [
                          SizedBox(height: 65.68.h),
                          LoginCenterContent(),
                          SizedBox(height: 32.h),
                          LoginForm(),
                        ],
                      ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
