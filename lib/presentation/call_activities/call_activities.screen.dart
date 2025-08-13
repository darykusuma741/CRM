import 'package:crm/common/components/custom_ink_well.dart';
import 'package:crm/common/components/custom_list.dart';
import 'package:crm/common/components/custom_scaffold.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/common/constants/image_assets.dart';
import 'package:crm/common/helper/get_due_text.dart';
import 'package:crm/data/model/activity.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import 'controllers/call_activities.controller.dart';

class CallActivitiesScreen extends GetView<CallActivitiesController> {
  const CallActivitiesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      List<ActivityModel> data = controller.data.value;

      return CustomScaffold(
        appBar: CustomAppBar(
          title: 'Call Activities',
        ),
        backgroundColor: ColorsName.white,
        body: CustomList(
          paddingDivider: EdgeInsets.all(0.0),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          scroll: true,
          items: data,
          itemBuilder: (context, index) {
            ActivityModel item = data[index];

            return Container(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: Row(
                spacing: 10.w,
                children: [
                  Container(
                    height: 32.w,
                    width: 32.w,
                    decoration: BoxDecoration(
                      color: ColorsName.graySoftLight,
                      borderRadius: BorderRadius.circular(100.r),
                      border: Border.all(color: ColorsName.bluePastel.withOpacity(0.5)),
                    ),
                    child: Center(
                      child: SvgPicture.asset(ImageAssets.iconSvgCall, width: 16.w),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: BaseText.grayCharcoal.copyWith(fontSize: 13.sp),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          getDueText(item.dueDate),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: BaseText.graySlate.copyWith(fontSize: 11.sp),
                        ),
                      ],
                    ),
                  ),
                  CustomInkWell(
                    onTap: () => controller.onClickDetail(item),
                    height: 30.h,
                    width: 68.w,
                    decoration: BoxDecoration(
                      color: ColorsName.white,
                      border: Border.all(color: ColorsName.bluePastel),
                    ),
                    child: Center(
                      child: Text('Open', style: BaseText.blueSteel.copyWith(fontSize: 11.sp, fontWeight: FontWeight.w500)),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    });
  }
}
