import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/common/constants/image_assets.dart';
import 'package:crm/presentation/face_scan/controllers/face_scan.controller.dart';

class FaceScanNavigation extends GetView<FaceScanController> {
  const FaceScanNavigation({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 34.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    width: 32.w,
                    height: 32.h,
                    decoration: BoxDecoration(color: ColorsName.white, borderRadius: BorderRadius.circular(100.r)),
                    child: Center(child: SvgPicture.asset(ImageAssets.iconSvgArrowLeftBlack, width: 16.w)),
                  ),
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: controller.onTapFlipCamera,
                      child: Container(
                        width: 32.w,
                        height: 32.h,
                        decoration: BoxDecoration(color: ColorsName.white, borderRadius: BorderRadius.circular(100.r)),
                        child: Center(
                          child: SvgPicture.asset(
                            ImageAssets.iconSvgFlipCamera,
                            width: 14.w,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    GestureDetector(
                      onTap: controller.handleFlashMode,
                      child: Container(
                        width: 32.w,
                        height: 32.h,
                        decoration: BoxDecoration(color: ColorsName.white, borderRadius: BorderRadius.circular(100.r)),
                        child: Center(
                          child: Icon(
                            controller.flashOn.value ? Icons.flash_on_rounded : Icons.flash_off_rounded,
                            size: 18.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
