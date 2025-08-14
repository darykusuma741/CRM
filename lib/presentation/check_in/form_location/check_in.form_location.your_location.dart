import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/common/constants/image_assets.dart';
import 'package:crm/presentation/check_in/controllers/check_in.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CheckInFormLocationYourLocation extends GetView<CheckInController> {
  const CheckInFormLocationYourLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        width: double.infinity,
        // height: 62.h,
        decoration: BoxDecoration(
          color: ColorsName.grayUltraWhite,
          border: Border.all(
            color: ColorsName.grayCloud,
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(ImageAssets.iconSvgLocation, width: 16.w),
            SizedBox(width: 6.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Your Location',
                    style: BaseText.grayCharcoalDark.copyWith(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    controller.address.value ?? 'Searching for your current location...',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: BaseText.grayGraphiteDark.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
