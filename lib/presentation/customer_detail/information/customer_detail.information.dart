import 'package:crm/common/components/custom_divider.dart';
import 'package:crm/presentation/customer_detail/controllers/customer_detail.controller.dart';
import 'package:crm/presentation/customer_detail/information/detail/customer_detail.information.detail.dart';
import 'package:crm/presentation/customer_detail/information/documents/customer_detail.documents.dart';
import 'package:crm/presentation/customer_detail/information/logistics/customer_detail.information.logistics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomerDetailInformation extends GetView<CustomerDetailController> {
  const CustomerDetailInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomerDetailInformationLogistics(),
          CustomDivider(),
          CustomerDetailInformationDetail(),
          CustomDivider(),
          CustomerDetailDocuments(),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
