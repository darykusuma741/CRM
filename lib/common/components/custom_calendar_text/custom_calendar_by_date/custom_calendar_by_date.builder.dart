import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crm/common/components/custom_divider.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';

class CustomCalendarByDateBuilder {
  static Widget? Function(BuildContext, DateTime, DateTime)? defaultBuilder = (context, day, focusedDay) {
    final isWeekend = day.weekday == DateTime.sunday;
    final styleText = isWeekend ? BaseText.redCherry : BaseText.grayCharcoal;
    return Center(
      child: Text(day.day.toString(), style: styleText.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w400)),
    );
  };

  static Widget? Function(BuildContext, DateTime, DateTime)? todayBuilder = (context, day, focusedDay) {
    final isWeekend = day.weekday == DateTime.sunday;
    final styleText = isWeekend ? BaseText.redCherry : BaseText.grayCharcoal;
    return Stack(
      children: [
        Center(
          child: Text(day.day.toString(), style: styleText.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w400)),
        ),
        Center(
          child: Container(
            width: 27.w,
            height: 27.h,
            decoration: BoxDecoration(
              // color: ColorsName.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: ColorsName.grayFoggy,
                width: 0.8,
              ),
            ),
          ),
        )
      ],
    );
  };

  static Widget? Function(BuildContext, DateTime)? dowBuilder = (context, day) {
    final text = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][day.weekday - 1];
    final isWeekend = day.weekday == DateTime.sunday;
    final styleText = isWeekend ? BaseText.redCherry : BaseText.graySlate;
    return Column(
      children: [
        Center(
          child: Text(text, style: styleText.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w400)),
        ),
        SizedBox(height: 6.h),
        CustomDivider(),
      ],
    );
  };
}
