import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:crm/common/constants/colors_name.dart';

void customModalBottom<T>(Widget child) {
  showModalBottomSheet(
      context: Get.context!,
      builder: (context) {
        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 12.h),
              Container(
                width: 32.w,
                height: 4.0,
                decoration: BoxDecoration(color: ColorsName.graySilver, borderRadius: BorderRadius.circular(4.r)),
              ),
              SizedBox(height: 16.h),
              child,
            ],
          ),
        );
      },
      enableDrag: true,
      isDismissible: true,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: ColorsName.white,
      // barrierColor: ColorsName.graySilver,
      showDragHandle: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ));
}
