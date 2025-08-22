import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:crm/common/constants/colors_name.dart';

Future<T?> customModalBottom<T>(Widget child) async {
  return await showModalBottomSheet<T>(
      context: Get.context!,
      constraints: BoxConstraints(maxHeight: MediaQuery.of(Get.context!).size.height - MediaQuery.of(Get.context!).padding.top - 30.h),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 12.h),
            Container(
              width: 32.w,
              height: 4.0,
              decoration: BoxDecoration(color: ColorsName.graySilver, borderRadius: BorderRadius.circular(4.r)),
            ),
            SizedBox(height: 16.h),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    child,
                    SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
                    SizedBox(height: MediaQuery.of(context).padding.bottom),
                  ],
                ),
              ),
            ),
          ],
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
