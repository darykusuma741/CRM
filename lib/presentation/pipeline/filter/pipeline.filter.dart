import 'package:crm/common/components/custom_select_category.dart';
import 'package:crm/data/dummy/stages.dummy.dart';
import 'package:crm/presentation/pipeline/controllers/pipeline.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PipelineFilter extends GetView<PipelineController> {
  const PipelineFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSelectCategory<String?>(
      // selectItem: controller.detailType.value,
      onTap: (e) {
        // controller.detailType.value = e;
        // controller.searchCustomer(controller.searchCustomerCtr.value.text);
      },
      items: [
        CustomSelectCategoryState<String?>(count: 0, label: 'All', value: null),
        ...StagesDummy.data.map((e) {
          return CustomSelectCategoryState<String?>(count: 0, label: e, value: e);
        }),
      ],
    );
  }
}
