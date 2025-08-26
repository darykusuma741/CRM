import 'package:crm/common/components/custom_button.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/data/enum/transport_by.dart';
import 'package:crm/data/model/marking.model.dart';
import 'package:crm/presentation/marking_detail/controllers/marking_detail.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MarkingDetailDetail extends GetView<MarkingDetailController> {
  const MarkingDetailDetail({super.key, required this.item});
  final MarkingModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Marking Detail', style: BaseText.grayCharcoalDark.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w500)),
          SizedBox(height: 16.h),
          Text('Marking Name', style: BaseText.graySlate.copyWith(fontSize: 11.sp, fontWeight: FontWeight.w300)),
          SizedBox(height: 1.h),
          Text(item.markingName, style: BaseText.grayDarker.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w400)),
          SizedBox(height: 10.h),
          Text('Transport by', style: BaseText.graySlate.copyWith(fontSize: 11.sp, fontWeight: FontWeight.w300)),
          SizedBox(height: 1.h),
          Text(item.transportBy.toShortString(), style: BaseText.grayDarker.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w400)),
          SizedBox(height: 16.h),
          CustomButton(
            title: 'Edit',
            onTap: () {
              Get.back();
              controller.onClickEdit(item);
            },
            bgColor: ColorsName.blueDeep,
          ),
        ],
      ),
    );
  }
}
