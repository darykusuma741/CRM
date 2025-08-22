import 'package:crm/common/components/custom_button.dart';
import 'package:crm/common/components/custom_dropdown.dart';
import 'package:crm/common/components/custom_text_editing.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/data/dummy/title.dummy.dart';
import 'package:crm/data/enum/address_type.dart';
import 'package:crm/presentation/address_form/not_contact/address_form.not_contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'controllers/address_form.controller.dart';

class AddressFormScreen extends GetView<AddressFormController> {
  const AddressFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            controller.title.value ?? 'NULL',
            style: BaseText.grayCharcoal.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 16.h),
          CustomDropdown<String>(
            label: 'Address type',
            selectedItem: controller.addressType.value,
            error: controller.addressTypeErr.value,
            items: [
              AddressType.contact.toShortString(),
              AddressType.deliveryAddress.toShortString(),
              AddressType.invoiceAddress.toShortString(),
              AddressType.otherAddress.toShortString(),
            ],
            customContent: (p0) => p0 == null ? 'Select address type' : p0.toString(),
            onChanged: (v) {
              controller.addressTypeErr.value = null;
              controller.addressType.value = v;
            },
          ),
          SizedBox(height: 16.h),
          CustomDropdown<String>(
            label: 'Title',
            selectedItem: controller.titleType.value,
            error: controller.titleTypeErr.value,
            items: TitleDummy.data,
            customContent: (p0) => p0 == null ? 'Select title' : p0.toString(),
            onChanged: (v) {
              controller.titleTypeErr.value = null;
              controller.titleType.value = v;
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
            label: 'Job Position',
            hint: 'Enter job position',
            required: false,
            controller: controller.jobPositionCtr.value,
          ),
          SizedBox(height: 16.h),
          CustomTextEditing(
            label: 'Email',
            hint: 'e.g. admin@scaleocean.com',
            required: false,
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
          AddressFormNotContact(),
          SizedBox(height: 16.h),
          CustomButton(
            onTap: controller.onSubmit,
            title: 'Submit',
            bgColor: ColorsName.blueDeep,
          ),
          SizedBox(height: 16.h),
        ]),
      );
    });
  }
}
