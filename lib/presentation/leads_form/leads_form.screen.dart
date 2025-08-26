import 'package:crm/common/components/custom_button.dart';
import 'package:crm/common/components/custom_scaffold.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/presentation/leads_form/form/leads_form.form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'controllers/leads_form.controller.dart';

class LeadsFormScreen extends GetView<LeadsFormController> {
  const LeadsFormScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return CustomScaffold(
        appBar: CustomAppBar(title: controller.item.value != null ? 'Edit Lead' : 'Add Lead'),
        backgroundColor: ColorsName.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: LeadsFormForm(),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: CustomButton(
                onTap: controller.onSubmit,
                title: 'Submit',
                bgColor: ColorsName.blueDeep,
              ),
            )
          ],
        ),
      );
    });
  }
}
