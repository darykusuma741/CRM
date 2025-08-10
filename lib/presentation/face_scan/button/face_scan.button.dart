// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/presentation/face_scan/controllers/face_scan.controller.dart';

class FaceScanButton extends GetView<FaceScanController> {
  const FaceScanButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      String status = 'Wajah tidak terdeteksi';
      if (controller.isFaceDetecting.value) {
        if (!controller.isWinkDetecting.value) {
          status = 'Kedipkan mata';
        } else if (!controller.isFaceLeftDetecting.value) {
          status = 'Hadap kiri';
        } else if (!controller.isFaceRightDetecting.value) {
          status = 'Hadap kanan';
        } else if (!controller.isSmileDetecting.value) {
          status = 'Senyum';
        } else {
          status = 'Wajah telah terdeteksi';
        }
      }
      return Column(
        children: [
          Expanded(child: Container()),
          Container(
            decoration: BoxDecoration(color: ColorsName.white, borderRadius: BorderRadius.circular(100.r)),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 3.h),
            child: Text(
              status.tr,
              style: BaseText.blueSteel.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: 18.h),
          InkWell(
            onTap: controller.onChapture,
            child: Container(
              width: 72.0,
              height: 72.0,
              padding: EdgeInsets.all(4.r),
              decoration: BoxDecoration(
                  border: Border.all(color: controller.complete.value ? ColorsName.white.withOpacity(0.6) : ColorsName.grayLead.withOpacity(0.6), width: 6.0),
                  borderRadius: BorderRadius.circular(100.r)),
              child: Container(
                decoration:
                    BoxDecoration(color: controller.complete.value ? ColorsName.white : ColorsName.grayLead, borderRadius: BorderRadius.circular(100.r)),
              ),
            ),
          ),
          SizedBox(height: 32.h),
        ],
      );
    });
  }
}
