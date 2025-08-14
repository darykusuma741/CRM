import 'package:crm/common/components/custom_divider.dart';
import 'package:crm/common/components/custom_slide_button.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/data/model/activity.model.dart';
import 'package:crm/presentation/check_in/form_location/check_in.form_location.photo.dart';
import 'package:crm/presentation/check_in/form_location/check_in.form_location.your_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:crm/presentation/check_in/controllers/check_in.controller.dart';
import 'package:intl/intl.dart';

class CheckInFormLocation extends GetView<CheckInController> {
  const CheckInFormLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final Radius borderRadius = Radius.circular(20.0);
      final ActivityModel? item = controller.data.value;
      return AnimatedSlide(
        offset: controller.isVisible.value ? Offset(0, 0) : Offset(0, 1),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        child: AnimatedOpacity(
          opacity: controller.isVisible.value ? 1 : 0,
          duration: const Duration(milliseconds: 300),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
            decoration: BoxDecoration(
              color: ColorsName.white,
              borderRadius: BorderRadius.only(topLeft: borderRadius, topRight: borderRadius),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF8DB8E6),
                  blurRadius: 33.75,
                  offset: Offset(0, 0),
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: Color(0x40000000), // #00000040 = black with 25% opacity
                  blurRadius: 4,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Check-in Detail'.tr, style: BaseText.grayCharcoalDark.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w500)),
                    InkWell(
                      child: Row(
                        children: [
                          Text('View This Pipeline'.tr, style: BaseText.blueSteel.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w500)),
                          SizedBox(width: 2.w),
                          Icon(Icons.arrow_forward_ios_rounded, color: ColorsName.blueSteel, size: 10.sp)
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                CheckInFormLocationYourLocation(),
                SizedBox(height: 12.h),
                Text('Activity Name'.tr, style: BaseText.graySlate.copyWith(fontSize: 11.sp, fontWeight: FontWeight.w400)),
                SizedBox(height: 3.h),
                Text(item?.name ?? '-', style: BaseText.grayDarker.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w400)),
                SizedBox(height: 16.h),
                Text('Activity Type'.tr, style: BaseText.graySlate.copyWith(fontSize: 11.sp, fontWeight: FontWeight.w400)),
                SizedBox(height: 3.h),
                Text(item?.activityType.toShortString() ?? '-', style: BaseText.grayDarker.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w400)),
                SizedBox(height: 12.h),
                Text('Date and Time'.tr, style: BaseText.graySlate.copyWith(fontSize: 11.sp, fontWeight: FontWeight.w400)),
                SizedBox(height: 3.h),
                Text(item?.dueDate == null ? '-' : DateFormat("d MMM yyyy, 10:00 - 11.30").format(item!.dueDate),
                    style: BaseText.grayDarker.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w400)),
                SizedBox(height: 16.h),
                Text('Link meeting'.tr, style: BaseText.graySlate.copyWith(fontSize: 11.sp, fontWeight: FontWeight.w400)),
                SizedBox(height: 3.h),
                Text('4 Aug 2025', style: BaseText.grayDarker.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w400)),
                SizedBox(height: 16.h),
                Text('Description'.tr, style: BaseText.graySlate.copyWith(fontSize: 11.sp, fontWeight: FontWeight.w400)),
                SizedBox(height: 3.h),
                Text(item?.description ?? '-', style: BaseText.grayDarker.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w400)),
                SizedBox(height: 12.h),
                CustomDivider(),
                SizedBox(height: 12.h),
                Text('Photo check-in required!'.tr, style: BaseText.graySlate.copyWith(fontSize: 11.sp, fontWeight: FontWeight.w400)),
                SizedBox(height: 4.h),
                CheckInFormLocationPhoto(),
                SizedBox(height: 16.h),
                CustomSlideButton(
                  title: 'Kick off your workday',
                  subTitle: 'Geser untuk memperoses!',
                  // done: false,
                  done: true,
                  enabled: true,
                  onFinish: controller.onSubmit,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
