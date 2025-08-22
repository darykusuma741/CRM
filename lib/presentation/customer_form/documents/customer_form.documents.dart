import 'dart:io';

import 'package:crm/common/components/custom_text_editing.dart';
import 'package:crm/common/components/custom_upload.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/presentation/customer_form/controllers/customer_form.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomerFormDocuments extends GetView<CustomerFormController> {
  const CustomerFormDocuments({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Logistics Information', style: BaseText.grayCharcoal.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w500)),
          SizedBox(height: 12.h),
          CustomTextEditing(
            label: 'NIK',
            hint: 'e.g. 320101xxxxxxxxxx',
            controller: controller.nikCtr.value,
            error: controller.nikErr.value,
            onChanged: (v) => controller.nikErr.value = null,
          ),
          SizedBox(height: 16.h),
          CustomUpload(
            hint: 'Upload file',
            label: 'KTP File',
            required: false,
            formatsText: 'PDF, DOCX, JPG, PNG',
            maxFile: 1,
            maxFileSizeMB: 1,
            multiple: false,
            files: [controller.fileKtp.value].whereType<File>().toList(),
            onChange: (file) {
              controller.fileKtp.value = file;
            },
            onRemove: (file) {
              controller.fileKtp.value = null;
            },
          ),
          SizedBox(height: 16.h),
          CustomTextEditing(
            required: false,
            label: 'NPWP',
            hint: 'e.g. 12.345.678.9-012.345',
            controller: controller.npwpCtr.value,
          ),
          SizedBox(height: 16.h),
          CustomUpload(
            hint: 'NPWP File',
            label: 'KTP File',
            required: false,
            formatsText: 'PDF, DOCX, JPG, PNG',
            maxFile: 1,
            maxFileSizeMB: 1,
            multiple: false,
            files: [controller.fileNpwp.value].whereType<File>().toList(),
            onChange: (file) {
              controller.fileNpwp.value = file;
            },
            onRemove: (file) {
              controller.fileNpwp.value = null;
            },
          ),
        ],
      );
    });
  }
}
