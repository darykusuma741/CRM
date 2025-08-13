import 'package:crm/common/components/custom_button.dart';
import 'package:crm/common/components/custom_divider.dart';
import 'package:crm/common/components/custom_text_editing.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/common/constants/image_assets.dart';
import 'package:crm/data/model/activity.model.dart';
import 'package:crm/presentation/call_activities/controllers/call_activities.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CallActivitiesDetailComponent extends GetView<CallActivitiesController> {
  const CallActivitiesDetailComponent(this.item, {super.key});
  final ActivityModel item;

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
          CallActivitiesDetailComponentItem(label: "Activity Name", content: item.name),
          SizedBox(height: 12.h),
          CallActivitiesDetailComponentItem(label: "Activity Type", content: item.activityType.toShortString()),
          SizedBox(height: 12.h),
          CallActivitiesDetailComponentItem(label: "Due Date", content: DateFormat("d MMM yyyy").format(item.dueDate)),
          SizedBox(height: 12.h),
          CallActivitiesDetailComponentItem(label: "Notes", content: item.notes ?? '-'),
          SizedBox(height: 16.h),
          Material(
            color: ColorsName.greenMintPale,
            borderRadius: BorderRadius.circular(8.r),
            child: InkWell(
              onTap: () => controller.onClickWhatsapp(item),
              splashColor: ColorsName.greenMintPale.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8.r),
              child: Container(
                width: double.infinity,
                height: 40.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(ImageAssets.iconSvgWhatsapp1, width: 16.w),
                    SizedBox(width: 8.w),
                    Text(
                      'Whatsapp Call',
                      style: BaseText.greenPrimary.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ),
          ),
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
            title: 'Submit',
            onTap: () => controller.onSubmit(item),
            bgColor: ColorsName.blueDeep,
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}

class CallActivitiesDetailComponentItem extends StatelessWidget {
  const CallActivitiesDetailComponentItem({super.key, required this.label, required this.content});
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
        SizedBox(height: 3.h),
        Text(
          content,
          style: BaseText.grayDarker.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
