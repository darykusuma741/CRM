import 'package:crm/common/components/custom_divider.dart';
import 'package:crm/common/components/custom_dropdown.dart';
import 'package:crm/common/components/custom_text_editing.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/presentation/add_lead/controllers/add_lead.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddLeadForm extends GetView<AddLeadController> {
  const AddLeadForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Lead Information',
          style: BaseText.grayCharcoal.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 14.h),
        CustomTextEditing(
          label: 'Lead Name',
          hint: 'Enter lead name',
        ),
        SizedBox(height: 16.h),
        CustomTextEditing(
          label: 'Company Name',
          hint: 'Enter company name',
        ),
        SizedBox(height: 16.h),
        CustomTextEditing(
          label: 'Website',
          hint: 'e.g. https://www.scaleocean.com',
        ),
        SizedBox(height: 16.h),
        CustomDivider(),
        SizedBox(height: 12.h),
        Text(
          'Contact Information',
          style: BaseText.grayCharcoal.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 14.h),
        CustomDropdown<String>(
          label: 'Title',
          showScroll: true,
          // selectedItem: months[now.month - 1],
          items: [],
          // iconLeftAsset: ImageAssets.iconCalendar,
          customContent: (p0) => p0 == null ? 'Select title' : p0.toString(),
          onChanged: (v) {
            // controller.initialDate.value = v;
            // controller.getData();
          },
        ),
        SizedBox(height: 16.h),
        CustomTextEditing(
          label: 'Contact Name',
          hint: 'Enter contact name',
        ),
        SizedBox(height: 16.h),
        CustomTextEditing(
          label: 'Email',
          hint: 'e.g. admin@scaleocean.com',
        ),
        SizedBox(height: 16.h),
        CustomTextEditing(
          label: 'Phone Number',
          hint: 'e.g. 0812 3456 7890',
        ),
        SizedBox(height: 16.h),
        CustomTextEditing(
          label: 'Job Position',
          hint: 'Enter job position',
        ),
        SizedBox(height: 16.h),
        CustomDivider(),
        SizedBox(height: 12.h),
        Text(
          'Address Information',
          style: BaseText.grayCharcoal.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 14.h),
        CustomTextEditing(
          label: 'State',
          hint: 'e.g. Jawa Barat',
        ),
        SizedBox(height: 16.h),
        CustomTextEditing(
          label: 'City',
          hint: 'e.g. Bandung',
        ),
        SizedBox(height: 16.h),
        CustomDropdown<String>(
          label: 'Country',
          showScroll: true,
          // selectedItem: months[now.month - 1],
          items: [],
          // iconLeftAsset: ImageAssets.iconCalendar,
          customContent: (p0) => p0 == null ? 'Select country' : p0.toString(),
          onChanged: (v) {
            // controller.initialDate.value = v;
            // controller.getData();
          },
        ),
        SizedBox(height: 16.h),
        CustomTextEditing(
          label: 'Street Address',
          hint: 'e.g. Jl. Merdeka No. 45',
          textArea: true,
        ),
        SizedBox(height: 16.h),
        CustomTextEditing(
          label: 'Postal Code',
          hint: 'e.g., 12345',
        ),
      ],
    );
  }
}
