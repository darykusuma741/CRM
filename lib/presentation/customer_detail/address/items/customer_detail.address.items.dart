import 'package:crm/common/components/custom_modal_bottom.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/data/enum/address_type.dart';
import 'package:crm/presentation/customer_detail/address/detail/customer_detail.address.detail.dart';
import 'package:crm/presentation/customer_detail/controllers/customer_detail.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomerDetailAddressItems extends GetView<CustomerDetailController> {
  const CustomerDetailAddressItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final item = controller.item.value;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8.h,
        children: item.additionalAddress.map((e) {
          return InkWell(
            onTap: () {
              customModalBottom(CustomerDetailAddressDetail(e));
            },
            borderRadius: BorderRadius.circular(6.r),
            child: Ink(
              width: double.infinity,
              height: 59.h,
              decoration: BoxDecoration(
                color: ColorsName.white,
                borderRadius: BorderRadius.circular(6.r),
                border: Border.all(color: ColorsName.grayLightest),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0.0, 2.0),
                    blurRadius: 16.0,
                    color: ColorsName.grayDarker.withOpacity(.06),
                  )
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(e.contactName, style: BaseText.grayCharcoal.copyWith(fontSize: 13.sp)),
                  SizedBox(height: 4.h),
                  Text(e.addressType.toShortString(), style: BaseText.grayGraphiteDark.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w300)),
                ],
              ),
            ),
          );
        }).toList(),
      );
    });
  }
}
