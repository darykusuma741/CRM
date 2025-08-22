import 'package:crm/common/components/custom_radio_list.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/data/enum/customer_detail_type.dart';
import 'package:crm/presentation/customer_form/controllers/customer_form.controller.dart';
import 'package:crm/presentation/customer_form/detail/company/customer_form.detail.company.dart';
import 'package:crm/presentation/customer_form/detail/individual/customer_form.detail.individual.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomerFormDetail extends GetView<CustomerFormController> {
  const CustomerFormDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Detail Information', style: BaseText.grayCharcoal.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w500)),
          SizedBox(height: 12.h),
          CustomRadioList<String>(
            items: [CustomerDetailType.company.toShortString(), CustomerDetailType.individual.toShortString()],
            onClick: (v) => controller.customerDetailType.value = v,
            selectItems: controller.customerDetailType.value,
          ),
          SizedBox(height: 16.h),
          (controller.customerDetailType.value == CustomerDetailType.individual.toShortString()) ? CustomerFormDetailIndividual() : CustomerFormDetailCompany(),
        ],
      );
    });
  }
}
