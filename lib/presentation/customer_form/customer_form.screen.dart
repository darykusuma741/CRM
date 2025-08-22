import 'package:crm/common/components/custom_button.dart';
import 'package:crm/common/components/custom_divider.dart';
import 'package:crm/common/components/custom_scaffold.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/presentation/customer_form/detail/customer_form.detail.dart';
import 'package:crm/presentation/customer_form/documents/customer_form.documents.dart';
import 'package:crm/presentation/customer_form/individual_information/customer_form.individual_information.dart';
import 'package:crm/presentation/customer_form/logistics/customer_form.logistics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'controllers/customer_form.controller.dart';

class CustomerFormScreen extends GetView<CustomerFormController> {
  const CustomerFormScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return CustomScaffold(
        appBar: CustomAppBar(
          title: controller.item.value == null ? 'Add Customer' : 'Edit Customer',
        ),
        backgroundColor: ColorsName.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.h),
              CustomerFormLogistics(),
              SizedBox(height: 16.h),
              CustomDivider(),
              SizedBox(height: 12.h),
              CustomerFormDetail(),
              CustomerFormIndividualInformation(),
              SizedBox(height: 16.h),
              CustomDivider(),
              SizedBox(height: 12.h),
              CustomerFormDocuments(),
              SizedBox(height: 20.h),
              CustomButton(
                onTap: controller.onSubmit,
                title: 'Submit',
                bgColor: ColorsName.blueDeep,
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom + 16.h),
            ],
          ),
        ),
      );
    });
  }
}
