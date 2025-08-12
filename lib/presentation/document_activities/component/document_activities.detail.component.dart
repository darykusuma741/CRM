import 'package:crm/common/components/custom_button.dart';
import 'package:crm/common/components/custom_divider.dart';
import 'package:crm/common/components/custom_text_editing.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DocumentActivitiesDetailComponent extends StatelessWidget {
  const DocumentActivitiesDetailComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Document Detail",
            style: BaseText.grayCharcoal.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 16.h),
          DocumentActivitiesDetailComponentItem(label: "Summary", content: "Document Detail"),
          SizedBox(height: 12.h),
          DocumentActivitiesDetailComponentItem(label: "Activity Type", content: "Call"),
          SizedBox(height: 12.h),
          DocumentActivitiesDetailComponentItem(label: "Due Date", content: "4 Aug 2025"),
          SizedBox(height: 12.h),
          DocumentActivitiesDetailComponentItem(
              label: "Notes", content: "Intro call to present solutions. Discussed pain points in inventory. Next: send deck + schedule demo."),
          SizedBox(height: 16.h),
          CustomDivider(),
          SizedBox(height: 16.h),
          CustomTextEditing(
            label: 'Your Feedback',
            hint: 'Please share your feedback',
            required: false,
            textArea: true,
          ),
          SizedBox(height: 16.h),
          CustomButton(
            title: 'Done',
            onTap: () {
              Get.back();
            },
            bgColor: ColorsName.blueDeep,
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}

class DocumentActivitiesDetailComponentItem extends StatelessWidget {
  const DocumentActivitiesDetailComponentItem({super.key, required this.label, required this.content});
  final String label;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: BaseText.graySlate.copyWith(fontSize: 11.sp, fontWeight: FontWeight.w400),
        ),
        SizedBox(height: 1.h),
        Text(
          content,
          style: BaseText.grayDarker.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
