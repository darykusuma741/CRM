import 'package:crm/common/components/custom_button.dart';
import 'package:crm/common/components/custom_check_list.dart';
import 'package:crm/common/components/custom_text_editing.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/data/enum/transport_by.dart';
import 'package:crm/data/model/marking.model.dart';
import 'package:crm/presentation/marking_detail/controllers/marking_detail.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MarkingDetailForm extends GetView<MarkingDetailController> {
  const MarkingDetailForm({super.key, this.item});
  final MarkingModel? item;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item == null ? 'Add Marking' : 'Edit Marking', style: BaseText.grayCharcoalDark.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w500)),
            SizedBox(height: 16.h),
            CustomTextEditing(
              label: 'Marking Name',
              hint: 'Enter marking name',
              controller: controller.markingNameCtr.value,
              error: controller.markingNameErr.value,
              onChanged: (v) {
                controller.markingNameErr.value = null;
                if (item != null) {
                  if (v == item!.markingName) return;
                }
                final exists = controller.markings.value.where((e) => e.markingName.toLowerCase() == (v ?? '').toLowerCase()).toList();
                if (exists.isNotEmpty) {
                  controller.markingNameErr.value = 'Marking already used. Type a unique name.';
                }
              },
            ),
            SizedBox(height: 16.h),
            CustomCheckList<String>(
              label: 'Transport by',
              items: [TransportBy.air.toShortString(), TransportBy.ocean.toShortString()],
              error: controller.selectTransportByErr.value,
              onClick: (v) {
                controller.selectTransportByErr.value = null;
                final s = [...controller.selectTransportBy.value];
                bool select = s.contains(v);
                if (select) {
                  s.remove(v);
                  controller.selectTransportBy.value = s;
                } else {
                  s.add(v);
                  controller.selectTransportBy.value = s;
                }
              },
              selectItems: controller.selectTransportBy.value,
            ),
            SizedBox(height: 16.h),
            CustomButton(
              title: 'Submit',
              bgColor: ColorsName.blueDeep,
              onTap: () => controller.onSubmit(item),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      );
    });
  }
}
