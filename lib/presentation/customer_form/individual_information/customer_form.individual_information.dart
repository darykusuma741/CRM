import 'package:crm/common/components/custom_divider.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/common/constants/image_assets.dart';
import 'package:crm/data/enum/address_type.dart';
import 'package:crm/data/enum/customer_detail_type.dart';
import 'package:crm/presentation/customer_form/controllers/customer_form.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CustomerFormIndividualInformation extends GetView<CustomerFormController> {
  const CustomerFormIndividualInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.customerDetailType.value == CustomerDetailType.individual.toShortString()) return Container();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.h),
          CustomDivider(),
          SizedBox(height: 12.h),
          Text('Individual Information', style: BaseText.grayCharcoal.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w500)),
          SizedBox(height: 10.h),
          if (controller.additionalAddress.value.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8.h,
                children: controller.additionalAddress.value.map((e) {
                  return InkWell(
                    onTap: () => controller.onTapEditAddress(e),
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
                          ),
                        ],
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(e.contactName, overflow: TextOverflow.ellipsis, maxLines: 1, style: BaseText.grayCharcoal.copyWith(fontSize: 13.sp)),
                                Text(e.addressType.toShortString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: BaseText.grayGraphiteDark.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w300)),
                              ],
                            ),
                          ),
                          SvgPicture.asset(ImageAssets.iconSvgEdit, width: 14.w),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          InkWell(
            onTap: controller.onClickAddIndividual,
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
                  Text('Add Individual', style: BaseText.blueSteel.copyWith(fontSize: 12.sp)),
                ],
              ),
            ),
          )
        ],
      );
    });
  }
}
