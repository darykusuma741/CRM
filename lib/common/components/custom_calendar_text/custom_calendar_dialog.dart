// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:crm/common/components/custom_button.dart';
import 'package:crm/common/components/custom_calendar_text/controller/custom_calendar_text.controller.dart';
import 'package:crm/common/components/custom_calendar_text/custom_calendar_by_date/custom_calendar_by_date.dart';
import 'package:crm/common/components/custom_calendar_text/custom_calendar_by_month/custom_calendar_by_month.dart';
import 'package:crm/common/components/custom_calendar_text/custom_calendar_by_year/custom_calendar_by_year.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';

class CustomCalendarDialog extends GetView<CustomCalendarTextController> {
  const CustomCalendarDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Container(
          // height: 350.h, // Adjust the height of the dialog to fit inside the screen
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: ColorsName.white,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Date'.tr, style: BaseText.grayCharcoal.copyWith(fontSize: 15.sp, fontWeight: FontWeight.w500)),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      color: Colors.white.withOpacity(.1),
                      margin: EdgeInsets.only(top: 3.0),
                      child: Icon(
                        Icons.close_rounded,
                        size: 20.0,
                        color: ColorsName.grayDarker,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10.h),
              if (controller.by.value == "Year") CustomCalendarByYear(),
              if (controller.by.value == "Month") CustomCalendarByMonth(),
              if (controller.by.value == "Date") CustomCalendarByDate(),
              SizedBox(height: 20.h),
              CustomButton(
                onTap: () {
                  controller.onSubmit.value(controller.startDate.value, controller.endDate.value);
                  Get.back();
                },
                title: 'Save'.tr,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
