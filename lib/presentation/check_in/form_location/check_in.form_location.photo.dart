import 'package:crm/common/components/custom_dash_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/common/constants/image_assets.dart';
import 'package:crm/infrastructure/navigation/routes.dart';
import 'package:crm/presentation/check_in/controllers/check_in.controller.dart';

class CheckInFormLocationPhoto extends GetView<CheckInController> {
  const CheckInFormLocationPhoto({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.photo.value != null) {
        return InkWell(
          onTap: () async {
            final dynamic result = await Get.toNamed(Routes.FACE_SCAN);
            if (result != null) {
              controller.photo.value = result;
            }
          },
          child: SizedBox(
            height: 60.665.h,
            width: 60.665.w,
            child: Stack(
              children: [
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  child: Container(
                    height: 56.h,
                    width: 56.w,
                    decoration: BoxDecoration(color: ColorsName.blueBaby, borderRadius: BorderRadius.circular(4.r)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4.r),
                      child: Image.file(
                        controller.photo.value!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 0.0,
                  top: 0.0,
                  child: Icon(
                    Icons.do_disturb_on_rounded,
                    color: ColorsName.redCherry,
                    size: 15.sp,
                  ),
                )
              ],
            ),
          ),
        );
      }
      return InkWell(
        onTap: () async {
          final dynamic result = await Get.toNamed(Routes.FACE_SCAN);
          if (result != null) {
            controller.photo.value = result;
          }
        },
        child: CustomDashContainer(
          radius: 6.r,
          color: ColorsName.bluePastel,
          child: Container(
            width: 117.w,
            height: 34.h,
            decoration: BoxDecoration(color: ColorsName.grayIce, borderRadius: BorderRadius.circular(6.r)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(ImageAssets.iconSvgPhotoCamera, height: 16.h, width: 16.w),
                SizedBox(width: 8.w),
                Text('Take Photo'.tr, style: BaseText.blueSteel.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w500))
              ],
            ),
          ),
        ),
      );
    });
  }
}
