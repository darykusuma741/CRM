import 'package:crm/common/components/custom_button.dart';
import 'package:crm/presentation/sna_form/controllers/sna_form.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SnaFormButton extends GetView<SnaFormController> {
  const SnaFormButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: CustomButton(
        onTap: controller.onClickSubmit,
        title: 'Schedule',
      ),
    );
  }
}
