import 'package:crm/common/components/custom_calendar_text/custom_calendar_text.dart';
import 'package:crm/common/components/custom_scaffold.dart';
import 'package:crm/common/components/custom_select_label.dart';
import 'package:crm/common/components/custom_text_editing.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/presentation/sna_form/button/sna_form.button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'controllers/sna_form.controller.dart';

class SnaFormScreen extends GetView<SnaFormController> {
  const SnaFormScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return CustomScaffold(
        appBar: CustomAppBar(
          title: 'Schedule Next Activity',
        ),
        backgroundColor: ColorsName.white,
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Column(
                  spacing: 16.h,
                  children: [
                    CustomSelectLabel(
                      label: 'Activity Recommendations',
                      items: controller.activityRecItems,
                      selectedItems: controller.activityRec.value,
                      error: controller.activityRecErr.value,
                      onSelected: (value, item) {
                        controller.activityRec.value = item;
                      },
                    ),
                    CustomTextEditing(
                      label: 'Summary',
                      required: false,
                      hint: 'e.g. Follow-up with client',
                    ),
                    CustomCalendarText(
                      error: controller.dueDateErr.value,
                      label: 'Due Date'.tr,
                      hint: 'Select date'.tr,
                      startDateState: controller.dueDate.value,
                      endDateState: null,
                      textController: controller.dueDateCtr.value,
                      onSubmit: (start, end) {
                        controller.dueDate.value = start;
                        controller.dueDateErr.value = null;
                        controller.dueDateCtr.value.text = (start == null) ? "" : DateFormat("dd MMM yyyy").format(start);
                      },
                    ),
                    CustomTextEditing(
                      label: 'Notes',
                      required: false,
                      hint: 'Enter your notes',
                    ),
                  ],
                ),
              ),
            ),
            SnaFormButton(),
          ],
        ),
      );
    });
  }
}
