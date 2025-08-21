import 'package:crm/common/components/custom_scaffold.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/presentation/customer/items/customer.items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'controllers/customer.controller.dart';

class CustomerScreen extends GetView<CustomerController> {
  const CustomerScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        title: 'Customer',
      ),
      backgroundColor: ColorsName.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // FreightProductFilter(),
            // SizedBox(height: 6.h),
            CustomerItems(),
          ],
        ),
      ),
    );
  }
}
