import 'package:crm/common/components/custom_floating_action_container.dart';
import 'package:crm/common/components/custom_scaffold.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/common/helper/my_snack_bar.dart';
import 'package:crm/infrastructure/navigation/routes.dart';
import 'package:crm/presentation/customer/filter/customer.filter.dart';
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
      floatingActionButton: CustomFloatingActionContainer(onTap: () async {
        final dynamic result = await Get.toNamed(Routes.CUSTOMER_FORM);
        if (result != null) {
          controller.ctrCustomerMain.addData(result);
          controller.getData();
          MySnackBar.success(
            Get.context!,
            title: 'Customer successfully added!',
            subTitle: 'New customer added to your list.',
          );
        }
      }),
      backgroundColor: ColorsName.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomerFilter(),
            SizedBox(height: 6.h),
            CustomerItems(),
          ],
        ),
      ),
    );
  }
}
