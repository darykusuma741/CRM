import 'package:crm/common/components/custom_button.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/common/constants/image_assets.dart';
import 'package:crm/data/enum/address_type.dart';
import 'package:crm/data/model/additional_address.model.dart';
import 'package:crm/presentation/customer_detail/controllers/customer_detail.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CustomerDetailAddressDetail extends GetView<CustomerDetailController> {
  const CustomerDetailAddressDetail(this.item, {super.key});
  final AdditionalAddressModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Additional Address Detail",
            style: BaseText.grayCharcoal.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 16.h),
          _CustomerDetailAddressDetailItem(label: 'Address Type', value: item.addressType.toShortString()),
          SizedBox(height: 10.h),
          _CustomerDetailAddressDetailItem(label: 'Contact Name', value: item.contactName),
          SizedBox(height: 10.h),
          _CustomerDetailAddressDetailItem(label: 'Job Position', value: item.jobPosition ?? '-'),
          SizedBox(height: 10.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: _CustomerDetailAddressDetailItem(label: 'Email', value: item.email ?? '-'),
              ),
              Container(
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(color: ColorsName.blueSoft, borderRadius: BorderRadius.circular(100.r)),
                child: Center(
                  child: SvgPicture.asset(
                    ImageAssets.iconSvgIcon3,
                    width: 14.w,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: _CustomerDetailAddressDetailItem(label: 'Phone Number', value: item.phoneNumber),
              ),
              Container(
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(color: ColorsName.blueSoft, borderRadius: BorderRadius.circular(100.r)),
                child: Center(
                  child: SvgPicture.asset(
                    ImageAssets.iconSvgPhone,
                    width: 14.w,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          CustomButton(
            onTap: () {},
            title: 'Edit',
            bgColor: ColorsName.blueDeep,
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}

class _CustomerDetailAddressDetailItem extends StatelessWidget {
  const _CustomerDetailAddressDetailItem({required this.label, required this.value});
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
