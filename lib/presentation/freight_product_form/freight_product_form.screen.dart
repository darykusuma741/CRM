import 'package:crm/common/components/custom_check_list.dart';
import 'package:crm/common/components/custom_dropdown.dart';
import 'package:crm/common/components/custom_scaffold.dart';
import 'package:crm/common/components/custom_text_editing.dart';
import 'package:crm/common/components/custom_upload.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/presentation/freight_product_form/button/freight_product_form.button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'controllers/freight_product_form.controller.dart';

class FreightProductFormScreen extends GetView<FreightProductFormController> {
  const FreightProductFormScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return CustomScaffold(
        appBar: CustomAppBar(
          title: 'Edit Freight Product',
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
                    CustomDropdown<String>(
                      label: 'Product Type',
                      selectedItem: controller.productType.value,
                      items: ['Product', 'Service'],
                      error: controller.productTypeErr.value,
                      customContent: (p0) => p0 == null ? 'Select product type' : p0.toString(),
                      onChanged: (v) {
                        controller.productTypeErr.value = null;
                        controller.productType.value = v;
                      },
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
                    CustomDropdown<String>(
                      label: 'Branch',
                      required: false,
                      showScroll: true,
                      selectedItem: controller.branch.value,
                      items: ['Surabaya', 'Jakarta'],
                      customContent: (p0) => p0 == null ? 'Select branch' : p0.toString(),
                      onChanged: (v) {
                        controller.branch.value = v;
                      },
                    ),
                    SizedBox(height: 16.h),
                    CustomUpload(
                      hint: 'Upload photo',
                      label: 'Product Photo',
                      required: false,
                      formatsText: 'JPG, PNG',
                      maxFile: 1,
                      multiple: false,
                      files: controller.files.value,
                      onChange: (file) {
                        controller.files.value = [...controller.files.value, file];
                      },
                      onRemove: (file) {
                        final f = [...controller.files.value];
                        f.remove(file);
                        controller.files.value = f;
                      },
                    ),
                    SizedBox(height: 16.h),
                    CustomTextEditing(
                      label: 'Internal Reference',
                      hint: 'Enter internal reference',
                      required: false,
                      controller: controller.internalReferenceCtr.value,
                    ),
                  ],
                ),
              ),
            ),
            FreightProductFormButton(),
          ],
        ),
      );
    });
  }
}
