import 'package:crm/common/components/custom_button.dart';
import 'package:crm/common/components/custom_scaffold.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/presentation/add_lead/form/add_lead.form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'controllers/add_lead.controller.dart';

class AddLeadScreen extends GetView<AddLeadController> {
  const AddLeadScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(title: 'Add Lead'),
      backgroundColor: ColorsName.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: AddLeadForm(),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: CustomButton(
              title: 'Submit',
              bgColor: ColorsName.blueDeep,
            ),
          )
        ],
      ),
    );
  }
}
