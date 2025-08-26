import 'package:crm/common/components/custom_divider.dart';
import 'package:crm/common/components/custom_dropdown.dart';
import 'package:crm/common/components/custom_dropdown_multiple.dart';
import 'package:crm/common/components/custom_rating_input.dart';
import 'package:crm/common/components/custom_text_editing.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/data/dummy/product_category.dummy.dart';
import 'package:crm/data/dummy/state.dummy.dart';
import 'package:crm/data/dummy/title.dummy.dart';
import 'package:crm/presentation/leads_form/controllers/leads_form.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LeadsFormForm extends GetView<LeadsFormController> {
  const LeadsFormForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
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
            controller: controller.leadNameCtr.value,
            error: controller.leadNameErr.value,
            onChanged: (v) => controller.leadNameErr.value = null,
          ),
          SizedBox(height: 16.h),
          CustomRatingInput(
            label: 'Priority',
            required: false,
            count: controller.priority.value,
            onTap: (v) {
              controller.priority.value = v;
            },
          ),
          SizedBox(height: 16.h),
          CustomTextEditing(
            label: 'Company Name',
            hint: 'Enter company name',
            required: false,
            controller: controller.companyNameCtr.value,
          ),
          SizedBox(height: 16.h),
          CustomTextEditing(
            label: 'Website',
            hint: 'e.g. https://www.scaleocean.com',
            controller: controller.companyWebsiteCtr.value,
            error: controller.companyWebsiteErr.value,
            onChanged: (v) => controller.companyWebsiteErr.value = null,
          ),
          SizedBox(height: 16.h),
          CustomDivider(),
          SizedBox(height: 12.h),
          Text(
            'Product Information',
            style: BaseText.grayCharcoal.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 12.h),
          CustomDropdownMultiple(
            label: 'Product Category',
            hint: 'Select product category',
            items: ProductCategoryDummy.data.map((e) => e.name).toList(),
            selectedItem: controller.productCategory.value,
            error: controller.productCategoryErr.value,
            onChanged: (v) {
              final exists = controller.productCategory.value;
              (exists.contains(v)) ? exists.remove(v) : exists.add(v);
              controller.productCategory.value = [...exists];
              controller.productCategoryErr.value = v;
            },
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
            required: false,
            items: TitleDummy.data,
            customContent: (p0) => p0 == null ? 'Select title' : p0.toString(),
            selectedItem: controller.title.value,
            onChanged: (v) {
              controller.title.value = v;
            },
          ),
          SizedBox(height: 16.h),
          CustomTextEditing(
            label: 'Contact Name',
            hint: 'Enter contact name',
            controller: controller.contactNameCtr.value,
            error: controller.contactNameErr.value,
            onChanged: (v) => controller.contactNameErr.value = null,
          ),
          SizedBox(height: 16.h),
          CustomTextEditing(
            label: 'Email',
            required: false,
            hint: 'e.g. admin@scaleocean.com',
            controller: controller.emailCtr.value,
          ),
          SizedBox(height: 16.h),
          CustomTextEditing(
            label: 'Phone Number',
            hint: 'e.g. 0812 3456 7890',
            controller: controller.phoneNumberCtr.value,
            error: controller.phoneNumberErr.value,
            onChanged: (v) => controller.phoneNumberErr.value = null,
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
            label: 'City',
            hint: 'e.g. Bandung',
            controller: controller.cityCtr.value,
            error: controller.cityErr.value,
            onChanged: (v) => controller.cityErr.value = null,
          ),
          SizedBox(height: 16.h),
          CustomDropdown<String>(
            label: 'State',
            selectedItem: controller.state.value,
            error: controller.stateErr.value,
            items: StateDummy.data,
            customContent: (p0) => p0 == null ? 'Select state' : p0.toString(),
            onChanged: (v) {
              controller.stateErr.value = null;
              controller.state.value = v;
            },
          ),
          SizedBox(height: 16.h),
          CustomDropdown<String>(
            label: 'Country',
            selectedItem: controller.country.value,
            error: controller.countryErr.value,
            items: [
              'Indonesia',
            ],
            customContent: (p0) => p0 == null ? 'Select country' : p0.toString(),
            onChanged: (v) {
              controller.countryErr.value = null;
              controller.country.value = v;
            },
          ),
          SizedBox(height: 16.h),
          CustomTextEditing(
            label: 'Street Address',
            hint: 'e.g. Jl. Merdeka No. 45',
            textArea: true,
            controller: controller.streetAddressCtr.value,
            error: controller.streetAddressErr.value,
            onChanged: (v) => controller.streetAddressErr.value = null,
          ),
          SizedBox(height: 16.h),
          CustomTextEditing(
            label: 'Postal Code',
            hint: 'e.g., 12345',
            controller: controller.postalCodeCtr.value,
            error: controller.postalCodeErr.value,
            onChanged: (v) => controller.postalCodeErr.value = null,
          ),
        ],
      );
    });
  }
}
