import 'package:crm/common/components/custom_divider.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/presentation/leads_detail/controllers/leads_detail.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LeadsDetailItems extends GetView<LeadsDetailController> {
  const LeadsDetailItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Product Information',
              style: BaseText.grayCharcoal.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 12.h),
            Text(
              'Product Category',
              style: BaseText.graySlate.copyWith(fontSize: 11.sp, fontWeight: FontWeight.w300),
            ),
            SizedBox(height: 4.h),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: 6.w,
                children: controller.item.value.productCategoty.map((e) {
                  return LeadsDetailItemsItem(title: e);
                }).toList(),
              ),
            ),
            SizedBox(height: 14.h),
            CustomDivider(),
            SizedBox(height: 14.h),
            Text(
              'Contact Information',
              style: BaseText.grayCharcoal.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 12.h),
            LeadsDetailItemsContent(label: 'Name', value: "${controller.item.value.title} ${controller.item.value.contactName}"),
            SizedBox(height: 10.h),
            LeadsDetailItemsContent(label: 'Job Position', value: controller.item.value.jobPosition),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LeadsDetailItemsContent(label: 'Email', value: controller.item.value.email),
                // Container(
                //   width: 32.w,
                //   height: 32.w,
                //   decoration: BoxDecoration(color: ColorsName.blueSoft, borderRadius: BorderRadius.circular(100.r)),
                //   child: Center(
                //     child: SvgPicture.asset(
                //       ImageAssets.iconSvgIcon3,
                //       width: 14.w,
                //     ),
                //   ),
                // ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LeadsDetailItemsContent(label: 'Phone Number', value: controller.item.value.phoneNumber),
                // Container(
                //   width: 32.w,
                //   height: 32.w,
                //   decoration: BoxDecoration(color: ColorsName.blueSoft, borderRadius: BorderRadius.circular(100.r)),
                //   child: Center(
                //     child: SvgPicture.asset(
                //       ImageAssets.iconSvgPhone,
                //       width: 16.55.w,
                //     ),
                //   ),
                // ),
              ],
            ),
            SizedBox(height: 14.h),
            CustomDivider(),
            SizedBox(height: 14.h),
            Text(
              'Address Information',
              style: BaseText.grayCharcoal.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 12.h),
            LeadsDetailItemsContent(label: 'Address', value: controller.item.value.streetAddress),
            SizedBox(height: 20.h),
          ],
        ),
      );
    });
  }
}

class LeadsDetailItemsContent extends StatelessWidget {
  const LeadsDetailItemsContent({super.key, required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: BaseText.graySlate.copyWith(fontSize: 11.sp, fontWeight: FontWeight.w300),
        ),
        SizedBox(height: 1.h),
        Text(
          value,
          style: BaseText.grayDarker.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}

class LeadsDetailItemsItem extends StatelessWidget {
  const LeadsDetailItemsItem({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: ColorsName.graySoftPale,
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(
          color: ColorsName.bluePastel,
          width: 0.8.w,
        ),
      ),
      child: Text(title, style: BaseText.grayDarker.copyWith(fontSize: 11.sp)),
    );
  }
}
