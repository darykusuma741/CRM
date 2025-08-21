import 'package:crm/common/constants/base_text.dart';
import 'package:crm/presentation/customer_detail/controllers/customer_detail.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomerDetailAddressEmpty extends GetView<CustomerDetailController> {
  const CustomerDetailAddressEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450.h,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('No Additional Address Yet', textAlign: TextAlign.center, style: BaseText.grayCharcoal.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w500)),
          SizedBox(height: 2.h),
          Text('Add an additional address\nto make managing deliveries easier.',
              textAlign: TextAlign.center, style: BaseText.grayLead.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w300)),
        ],
      ),
    );
  }
}
