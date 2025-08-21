import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/data/enum/transport_by.dart';
import 'package:crm/data/model/customer.model.dart';
import 'package:crm/presentation/customer_detail/controllers/customer_detail.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomerDetailInformationLogistics extends GetView<CustomerDetailController> {
  const CustomerDetailInformationLogistics({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final item = controller.item.value;

      return Container(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Logistics Information', style: BaseText.grayCharcoalDark.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w500)),
            SizedBox(height: 12.h),
            Text('Customer Type', style: BaseText.graySlate.copyWith(fontSize: 11.sp, fontWeight: FontWeight.w300)),
            SizedBox(height: 1.h),
            Text(item.customerType.toShortString(), style: BaseText.grayDarker.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w400)),
            SizedBox(height: 10.h),
            Text('Transport by', style: BaseText.graySlate.copyWith(fontSize: 11.sp, fontWeight: FontWeight.w300)),
            SizedBox(height: 1.h),
            Text(item.transportBy.toShortString(), style: BaseText.grayDarker.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w400)),
            SizedBox(height: 10.h),
            Text('Product Category', style: BaseText.graySlate.copyWith(fontSize: 11.sp, fontWeight: FontWeight.w300)),
            SizedBox(height: 4.h),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: 6.w,
                children: controller.item.value.productCategory.map((e) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                    decoration: BoxDecoration(
                        color: ColorsName.graySoftPale,
                        border: Border.all(color: ColorsName.bluePastel, width: 0.8.r),
                        borderRadius: BorderRadius.circular(4.r)),
                    child: Text(
                      e,
                      style: BaseText.grayDarker.copyWith(fontSize: 11.sp, fontWeight: FontWeight.w400),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      );
    });
  }
}
