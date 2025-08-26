import 'package:crm/common/constants/base_text.dart';
import 'package:crm/presentation/customer_detail/controllers/customer_detail.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomerDetailInformationDetail extends GetView<CustomerDetailController> {
  const CustomerDetailInformationDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final item = controller.item.value;
      return Container(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Detail Information', style: BaseText.grayCharcoalDark.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w500)),
            SizedBox(height: 12.h),
            _CustomerDetailInformationDetailItem(label: 'Company Name', value: item.companyName ?? '-'),
            SizedBox(height: 10.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: _CustomerDetailInformationDetailItem(label: 'Email', value: item.email ?? '-'),
                ),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: _CustomerDetailInformationDetailItem(label: 'Phone Number', value: item.phoneNumber ?? '-'),
                ),
                // Container(
                //   width: 32.w,
                //   height: 32.w,
                //   decoration: BoxDecoration(color: ColorsName.blueSoft, borderRadius: BorderRadius.circular(100.r)),
                //   child: Center(
                //     child: SvgPicture.asset(
                //       ImageAssets.iconSvgPhone,
                //       width: 14.w,
                //     ),
                //   ),
                // ),
              ],
            ),
            SizedBox(height: 10.h),
            _CustomerDetailInformationDetailItem(label: 'Address', value: item.address ?? '-'),
          ],
        ),
      );
    });
  }
}

class _CustomerDetailInformationDetailItem extends StatelessWidget {
  const _CustomerDetailInformationDetailItem({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: BaseText.graySlate.copyWith(fontSize: 11.sp, fontWeight: FontWeight.w300)),
        SizedBox(height: 1.h),
        Text(value, style: BaseText.grayDarker.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w400)),
      ],
    );
  }
}
