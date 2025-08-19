import 'package:crm/common/components/custom_check_list.dart';
import 'package:crm/common/components/custom_scaffold.dart';
import 'package:crm/common/components/custom_text_editing.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/presentation/product_category_form/button/product_category_form.button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'controllers/product_category_form.controller.dart';

class ProductCategoryFormScreen extends GetView<ProductCategoryFormController> {
  const ProductCategoryFormScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: CustomAppBar(
          title: '${controller.item.value == null ? 'Add' : 'Edit'} Freight Product',
        ),
        backgroundColor: ColorsName.white,
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextEditing(
                      label: 'Product Name',
                      hint: 'Enter product name',
                      controller: controller.productNameCtr.value,
                      error: controller.productNameErr.value,
                    ),
                    SizedBox(height: 16.h),
                    CustomCheckList<String>(
                      label: 'Transport by',
                      items: ['Air', 'Ocean'],
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
                    CustomTextEditing(
                      label: 'HS Code',
                      hint: 'Enter HS Code',
                      controller: controller.hsCodeCtr.value,
                      error: controller.hsCodeErr.value,
                    ),
                    SizedBox(height: 16.h),
                    CustomTextEditing(
                      label: 'Description',
                      hint: 'Enter Description',
                      required: false,
                      textArea: true,
                      controller: controller.descriptionCtr.value,
                    ),
                  ],
                ),
              ),
            ),
            ProductCategoryFormButton(),
          ],
        ),
      );
    });
  }
}
