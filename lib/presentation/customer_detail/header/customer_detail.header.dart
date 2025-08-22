import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/data/enum/customer_detail_type.dart';
import 'package:crm/infrastructure/navigation/routes.dart';
import 'package:crm/presentation/customer_detail/controllers/customer_detail.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomerDetailHeader extends GetView<CustomerDetailController> {
  const CustomerDetailHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final item = controller.item.value;
      final String name = item.companyName ?? item.customerName ?? '-';
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 14.h),
            Text(
              name,
              style: BaseText.grayCharcoal.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 2.h),
            Text(
              item.detailType.toShortString(),
              style: BaseText.graySlate.copyWith(fontSize: 12.sp),
            ),
            SizedBox(height: 12.h),
            Row(
              spacing: 10.w,
              children: [
                CustomerDetailHeaderMQ(
                  label: 'Marking',
                  count: item.markings.length,
                  onTap: () {
                    Get.toNamed(Routes.MARKING_DETAIL, arguments: item.markings);
                  },
                ),
                CustomerDetailHeaderMQ(
                  label: 'Quotation',
                  count: 0,
                  onTap: () {},
                ),
              ],
            ),
            SizedBox(height: 16.h),
          ],
        ),
      );
    });
  }
}

class CustomerDetailHeaderMQ extends StatelessWidget {
  const CustomerDetailHeaderMQ({super.key, required this.label, required this.count, required this.onTap});
  final String label;
  final int count;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4.r),
        child: Ink(
          height: 34.h,
          decoration: BoxDecoration(
            color: ColorsName.greenUltraSoft,
            borderRadius: BorderRadius.circular(4.r),
            border: Border.all(color: ColorsName.greenMintSoft),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: BaseText.greenPrimary.copyWith(fontSize: 11.sp)),
              Text(count.toString(), style: BaseText.greenPrimary.copyWith(fontSize: 11.sp)),
            ],
          ),
        ),
      ),
    );
  }
}
