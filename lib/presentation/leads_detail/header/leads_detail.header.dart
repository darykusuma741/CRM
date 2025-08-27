import 'package:crm/common/components/custom_rating.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/common/constants/image_assets.dart';
import 'package:crm/data/model/leads.model.dart';
import 'package:crm/presentation/leads_detail/controllers/leads_detail.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class LeadsDetailHeader extends GetView<LeadsDetailController> {
  const LeadsDetailHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // leadsDetailBg1Svg
      double paddingTop = MediaQuery.of(context).padding.top;
      double height = paddingTop + 173.h;

      return Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: height,
            child: Image.asset(
              ImageAssets.leadsDetailBg1Svg,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: double.infinity,
            height: height,
            padding: EdgeInsets.only(left: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: paddingTop),
                SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: SvgPicture.asset(ImageAssets.iconSvgArrowLeft, width: 14.67.w),
                          ),
                          SizedBox(width: 11.67.w),
                          Text(
                            'Leads Detail',
                            style: BaseText.white.copyWith(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: controller.onPressMore,
                        icon: SvgPicture.asset(ImageAssets.iconSvgOther, width: 3.75.w),
                      ),
                    ],
                  ),
                ),
                // SizedBox(height: 9.h),
                Text(
                  controller.item.value.leadName,
                  style: BaseText.white.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Text(
                      controller.item.value.type.toShortString(),
                      style: (controller.item.value.type == LeadsType.lost ? BaseText.redCherry : BaseText.greenPrimary).copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Container(
                      width: 0.8.w,
                      height: 12.h,
                      decoration: BoxDecoration(color: ColorsName.graySteelDark),
                    ),
                    SizedBox(width: 6.w),
                    CustomRating(count: controller.item.value.priority),
                  ],
                ),
                SizedBox(height: 14.h),
                Row(
                  children: [
                    SvgPicture.asset(ImageAssets.iconSvgIcon1, width: 14.w),
                    SizedBox(width: 8.w),
                    Text(
                      controller.item.value.companyName ?? '-',
                      style: BaseText.white.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    SvgPicture.asset(ImageAssets.iconSvgIcon2, width: 14.w),
                    SizedBox(width: 8.w),
                    Text(
                      "www.scaleocean.com",
                      style: BaseText.white.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      );
    });
  }
}
