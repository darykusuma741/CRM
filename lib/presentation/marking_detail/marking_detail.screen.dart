import 'package:crm/common/components/custom_scaffold.dart';
import 'package:crm/common/components/custom_select_modal/custom_select_modal.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/data/enum/transport_by.dart';
import 'package:crm/presentation/marking_detail/button_add/marking_detail.button_add.dart';
import 'package:crm/presentation/marking_detail/empty/marking_detail.empty.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'controllers/marking_detail.controller.dart';

class MarkingDetailScreen extends GetView<MarkingDetailController> {
  const MarkingDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return CustomScaffold(
        appBar: CustomAppBar(
          title: 'Marking Detail',
        ),
        backgroundColor: ColorsName.white,
        body: Stack(
          children: [
            if (controller.markingsFix.value.isEmpty) MarkingDetailEmpty(),
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 14.h),
                  MarkingDetailButtonAdd(),
                  SizedBox(height: 10.h),
                  CustomSelectModal<String>(
                    margin: EdgeInsets.zero,
                    value: controller.transportBy.value,
                    hint: 'Transport By',
                    title: 'Transport By',
                    items: [
                      TransportBy.air.toShortString(),
                      TransportBy.ocean.toShortString(),
                      TransportBy.all.toShortString(),
                    ],
                    valueText: (v) {
                      return v;
                    },
                    onChange: controller.onChangeTrBy,
                  ),
                  SizedBox(height: 14.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8.h,
                    children: controller.markingsFix.value.map((e) {
                      return InkWell(
                        onTap: () => controller.onClickDetail(e),
                        borderRadius: BorderRadius.circular(6.r),
                        child: Ink(
                          width: double.infinity,
                          height: 59.h,
                          decoration: BoxDecoration(
                            color: ColorsName.white,
                            border: Border.all(color: ColorsName.grayLightest),
                            borderRadius: BorderRadius.circular(6.r),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0.0, 2.0),
                                blurRadius: 16.0,
                                color: ColorsName.grayDarker.withOpacity(0.06),
                              )
                            ],
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(e.markingName, style: BaseText.grayCharcoal.copyWith(fontSize: 13.sp)),
                              SizedBox(height: 4.h),
                              Text("Transport By: ${e.transportBy.toShortString()}",
                                  style: BaseText.grayGraphiteDark.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w300)),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
