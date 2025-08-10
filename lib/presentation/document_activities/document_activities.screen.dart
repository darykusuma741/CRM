import 'package:crm/common/components/custom_ink_well.dart';
import 'package:crm/common/components/custom_list.dart';
import 'package:crm/common/components/custom_scaffold.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/common/constants/image_assets.dart';
import 'package:crm/infrastructure/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'controllers/document_activities.controller.dart';

class DocumentActivitiesScreen extends GetView<DocumentActivitiesController> {
  const DocumentActivitiesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        title: 'Document Activities',
      ),
      backgroundColor: ColorsName.white,
      body: CustomList(
        paddingDivider: EdgeInsets.all(0.0),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        scroll: true,
        items: [1, 2, 3, 4, 5],
        itemBuilder: (context, index) {
          return InkWell(
            onTap: controller.onClickDetail,
            child: Container(
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
                      child: SvgPicture.asset(ImageAssets.iconSvgDocument, width: 16.w),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Intro Call with PT Sinar",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: BaseText.grayCharcoal.copyWith(fontSize: 13.sp),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          "Due in 2 days (${DateFormat('d MMM yyyy').format(DateTime.now())})",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: BaseText.graySlate.copyWith(fontSize: 11.sp),
                        ),
                      ],
                    ),
                  ),
                  CustomInkWell(
                    onTap: () => Get.toNamed(Routes.SNA_FORM),
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
            ),
          );
        },
      ),
    );
  }
}
