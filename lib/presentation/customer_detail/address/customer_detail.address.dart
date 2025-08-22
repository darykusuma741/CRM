import 'package:crm/presentation/customer_detail/address/button_add/customer_detail.address.button_add.dart';
import 'package:crm/presentation/customer_detail/address/empty/customer_detail.address.empty.dart';
import 'package:crm/presentation/customer_detail/address/items/customer_detail.address.items.dart';
import 'package:crm/presentation/customer_detail/controllers/customer_detail.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomerDetailAddress extends GetView<CustomerDetailController> {
  const CustomerDetailAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final item = controller.item.value;

      return SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(height: 16.h),
            CustomerDetailAddressButtonAdd(),
            SizedBox(height: 8.h),
            (item.additionalAddress.isEmpty) ? CustomerDetailAddressEmpty() : CustomerDetailAddressItems(),
          ],
        ),
      );
    });
  }
}
