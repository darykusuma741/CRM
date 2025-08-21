import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/presentation/customer_detail/controllers/customer_detail.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomerDetailAddressButtonAdd extends GetView<CustomerDetailController> {
  const CustomerDetailAddressButtonAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(6.r),
      child: Ink(
        width: double.infinity,
        height: 34.h,
        decoration: BoxDecoration(
          color: ColorsName.blueLightest,
          border: Border.all(color: ColorsName.blueSoftCloud),
          borderRadius: BorderRadius.circular(6.r),
          boxShadow: [
            BoxShadow(
              offset: Offset(0.0, 4.0),
              blurRadius: 12.0,
              color: ColorsName.grayIronDark.withOpacity(0.03),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.add, size: 16.0, color: ColorsName.blueSteel),
            SizedBox(width: 3.w),
            Text('Add Additional Address', style: BaseText.blueSteel.copyWith(fontSize: 12.sp)),
          ],
        ),
      ),
    );
  }
}
