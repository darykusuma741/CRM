import 'package:crm/common/components/custom_dropdown.dart';
import 'package:crm/common/components/custom_text_editing.dart';
import 'package:crm/presentation/customer_form/controllers/customer_form.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomerFormDetailCompany extends GetView<CustomerFormController> {
  const CustomerFormDetailCompany({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        spacing: 16.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextEditing(
            label: 'Company Name',
            hint: 'Enter company name',
            required: false,
            controller: controller.companyNameCtr.value,
            onChanged: (v) => controller.companyNameErr.value = null,
            error: controller.companyNameErr.value,
          ),
          CustomTextEditing(
            label: 'Email',
            required: false,
            hint: 'e.g. admin@scaleocean.com',
            controller: controller.emailCtr.value,
          ),
          CustomTextEditing(
            label: 'Phone Number',
            hint: 'e.g. 0812 3456 7890',
            controller: controller.phoneNumberCtr.value,
            onChanged: (v) => controller.phoneNumberErr.value = null,
            error: controller.phoneNumberErr.value,
          ),
          CustomTextEditing(
            label: 'Tax ID',
            hint: 'Tax ID',
            required: false,
            controller: controller.taxIdCtr.value,
            onChanged: (v) => controller.taxIdErr.value,
            error: controller.taxIdErr.value,
          ),
          CustomTextEditing(
            label: 'City',
            hint: 'e.g. Bandung',
            controller: controller.cityCtr.value,
            onChanged: (v) => controller.cityErr.value = null,
            error: controller.cityErr.value,
          ),
          CustomDropdown<String>(
            label: 'State',
            selectedItem: controller.state.value,
            error: controller.stateErr.value,
            items: [
              'Jawa Tengah',
              'Jawa Barat',
              'DKI Jakarta',
            ],
            customContent: (p0) => p0 == null ? 'Select state' : p0.toString(),
            onChanged: (v) {
              controller.stateErr.value = null;
              controller.state.value = v;
            },
          ),
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
          CustomTextEditing(
            label: 'Street Address',
            hint: 'e.g. Jl. Merdeka No. 45',
            textArea: true,
            controller: controller.streetAddressCtr.value,
            error: controller.streetAddressErr.value,
            onChanged: (v) => controller.streetAddressErr.value = null,
          ),
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
