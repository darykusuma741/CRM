// ignore_for_file: deprecated_member_use, use_full_hex_values_for_flutter_colors

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';

class MySnackBar {
  static void success(BuildContext context, {required String title, String? subTitle}) {
    late Flushbar<dynamic> fb;
    fb = snInitial(
      title: title,
      color: ColorsName.greenJade,
      colorButtonClose: ColorsName.greenDark.withOpacity(.5),
      colorButtonCloseShadow: Color(0x333A5133),
      subTitle: subTitle,
    );
    fb.show(context);
  }

  static void error(BuildContext context, {required String title, String? subTitle}) {
    late Flushbar<dynamic> fb;
    fb = snInitial(
      title: title,
      subTitle: subTitle,
      color: ColorsName.redCherry,
      colorButtonClose: Color(0xffCA393A),
      colorButtonCloseShadow: Color(0xff333A5133),
      icon: false,
    );
    fb.show(context);
  }

  static Flushbar<dynamic> snInitial({
    required String title,
    String? subTitle,
    bool icon = true,
    required Color color,
    required Color colorButtonClose,
    required Color colorButtonCloseShadow,
  }) {
    return Flushbar(
      // title: "New Reminder Added.",
      padding: EdgeInsets.symmetric(horizontal: 11.17.w, vertical: 11.h),
      messageText: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon) Icon(Icons.check_circle_rounded, color: ColorsName.white, size: 16.sp),
          if (icon) SizedBox(width: 9.17.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: BaseText.white.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w500),
                ),
                if (subTitle != null)
                  Text(
                    subTitle,
                    // overflow: TextOverflow.ellipsis,
                    style: BaseText.white.copyWith(fontSize: 11.sp, fontWeight: FontWeight.w300),
                  ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: color,
      message: title,
      borderRadius: BorderRadius.circular(6.r),
      flushbarPosition: FlushbarPosition.TOP,
      margin: EdgeInsets.only(right: 16.w, left: 16.w, top: 57.h),
      duration: Duration(seconds: 3),
      mainButton: Container(
        height: 20.h,
        width: 20.w,
        margin: EdgeInsets.only(right: 10.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.r),
          color: colorButtonClose,
          boxShadow: [
            BoxShadow(
              color: colorButtonCloseShadow, // #333A5133
              offset: Offset(0, 21.6),
              blurRadius: 36,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Center(
          child: Icon(
            Icons.close,
            color: Colors.white,
            size: 12.sp,
          ),
        ),
      ),
    );
  }
}
