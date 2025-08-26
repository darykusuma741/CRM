import 'package:crm/common/components/custom_dropdown.dart';
import 'package:crm/common/components/custom_text_editing.dart';
import 'package:crm/data/dummy/state.dummy.dart';
import 'package:crm/data/enum/address_type.dart';
import 'package:crm/presentation/address_form/controllers/address_form.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddressFormNotContact extends GetView<AddressFormController> {
  const AddressFormNotContact({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.addressType.value != null && controller.addressType.value != AddressType.contact.toShortString()) {
        return Column(
          children: [
            SizedBox(height: 16.h),
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
      }
      return Container();
    });
  }
}
