import 'package:crm/common/components/custom_app_bar_bottom.dart';
import 'package:crm/presentation/customer_detail/controllers/customer_detail.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomerDetailTabBar extends GetView<CustomerDetailController> {
  const CustomerDetailTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final item = controller.item.value;
      final List<Tab> tabs = [
        Tab(text: 'Information'.tr, height: 40.h),
        Tab(text: 'Additional Address (${item.additionalAddress.length})'.tr, height: 40.h),
      ];
      return CustomAppBarBottom(
        boxShadow: [
          BoxShadow(color: Color.fromARGB(13, 75, 75, 75), blurRadius: 12, spreadRadius: 1.32, offset: Offset(0, 15)),
          BoxShadow(color: Color(0x05000000), blurRadius: 2, offset: Offset(2, 0.44)),
        ],
        dividerTop: false,
        tabs: tabs,
      );
    });
  }
}
