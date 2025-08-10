// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:crm/common/components/custom_calendar_text/controller/custom_calendar_text.controller.dart';
import 'package:crm/common/components/custom_calendar_text/custom_calendar_form/custom_calendar_form.dart';
import 'package:crm/common/components/custom_error_text.dart';
import 'package:crm/common/constants/base_text.dart';

class CustomCalendarText extends GetView<CustomCalendarTextController> {
  const CustomCalendarText({
    super.key,
    this.label,
    this.error,
    required this.hint,
    required this.onSubmit,
    this.required = true,
    this.startDateState,
    this.endDateState,
    this.textController,
    this.multipleDate = false,
    this.enabled = true,
  });
  final String? error;
  final String? label;
  final String hint;
  final bool multipleDate;
  final bool enabled;
  final DateTime? startDateState;
  final DateTime? endDateState;
  final TextEditingController? textController;
  final Function(DateTime? start, DateTime? end) onSubmit;
  final bool required;

  @override
  Widget build(BuildContext context) {
    Get.put(CustomCalendarTextController());
    final labelStyle = BaseText.blueMuted.copyWith(fontSize: 12.sp);
    final requiredStyle = BaseText.redCherry.copyWith(fontSize: 12.sp);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Row(
            children: [
              Text(label!, style: labelStyle),
              if (required) Text(' *', style: requiredStyle),
            ],
          ),
        if (label != null) SizedBox(height: 5.h),
        GestureDetector(
          onTap: () async {
            if (!enabled) return;
            controller.startDate.value = startDateState;
            controller.endDate.value = endDateState;
            controller.multipleDate.value = multipleDate;
            controller.onSubmit.value = onSubmit;
            if (controller.startDate.value != null) {
              controller.focusedDay.value = controller.startDate.value!;
            }
            controller.by.value = 'Date';
            controller.handleOnTap();
          },
          child: CustomCalendarForm(
            hint: hint,
            controller: textController,
            enabled: enabled,
            error: error,
          ),
        ),
        if (error != null) CustomErrorText(error: error)
      ],
    );
  }
}
