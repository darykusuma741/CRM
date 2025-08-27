import 'package:crm/common/components/custom_list.dart';
import 'package:crm/common/components/custom_rating.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/helper/formatter.helper.dart';
import 'package:crm/data/model/pipeline.model.dart';
import 'package:crm/presentation/pipeline/controllers/pipeline.controller.dart';
import 'package:crm/presentation/pipeline/items/pipeline.items.label_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PipelineItems extends GetView<PipelineController> {
  const PipelineItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final List<PipelineModel> data = controller.pipelineMainCtr.data.value;

      return CustomList(
        items: data,
        itemBuilder: (context, index) {
          final item = data[index];

          return InkWell(
            onTap: () {
              // value.value = items[index];
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 12.h),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PipelineItemsLabelStatus(status: item.stages),
                      CustomRating(count: item.priority),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.opportunity, style: BaseText.grayCharcoal.copyWith(fontSize: 13.sp)),
                          SizedBox(height: 4.h),
                          Text(
                            item.email ?? '-',
                            style: BaseText.grayGraphiteDark.copyWith(fontSize: 11.sp, fontWeight: FontWeight.w300),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            item.phoneNumber,
                            style: BaseText.grayGraphiteDark.copyWith(fontSize: 11.sp, fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                      Text(
                        FormatterHelper.formatRupiah(item.expectedRevenue),
                        style: BaseText.grayCharcoalDark.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
