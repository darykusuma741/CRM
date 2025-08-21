import 'package:crm/common/constants/base_text.dart';
import 'package:crm/presentation/marking_detail/controllers/marking_detail.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MarkingDetailEmpty extends GetView<MarkingDetailController> {
  const MarkingDetailEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('No marking added yet', textAlign: TextAlign.center, style: BaseText.grayCharcoal.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w500)),
          SizedBox(height: 2.h),
          Text('Tap “Add Marking” to create one.',
              textAlign: TextAlign.center, style: BaseText.grayLead.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w300)),
        ],
      ),
    );
  }
}
