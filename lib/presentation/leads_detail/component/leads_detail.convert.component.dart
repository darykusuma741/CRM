import 'package:crm/common/components/custom_button.dart';
import 'package:crm/common/components/custom_dropdown.dart';
import 'package:crm/common/components/custom_modal_button.dart';
import 'package:crm/common/components/custom_radio_list.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/common/helper/my_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LeadsDetailConvertComponent extends StatelessWidget {
  const LeadsDetailConvertComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final selectC = 'Create a new customer'.obs;
    final existingCs = Rxn<String>();
    final existingCsErr = Rxn<String>();

    return Obx(() {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Convert to opportunity',
              style: BaseText.grayCharcoalDark.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 16.h),
            CustomRadioList<String>(
              vertical: true,
              selectItems: selectC.value,
              items: ['Create a new customer', 'Link to an existing customer'],
              onClick: (v) {
                selectC.value = v;
              },
            ),
            if (selectC.value == 'Link to an existing customer')
              Column(
                children: [
                  SizedBox(height: 8.h),
                  CustomDropdown<String>(
                    offset: Offset(0.0, -65.0),
                    selectedItem: existingCs.value,
                    error: existingCsErr.value,
                    items: ['PT Aktif Digital', 'PT Jaya Bangunan', 'PT Setia Abadi', 'ScaleOcean'],
                    customContent: (p0) => p0 == null ? 'Select existing customer' : p0.toString(),
                    onChanged: (v) {
                      existingCsErr.value = null;
                      existingCs.value = v;
                    },
                  ),
                ],
              ),
            SizedBox(height: 16.h),
            CustomButton(
              title: 'Convert',
              bgColor: ColorsName.blueDeep,
              onTap: () async {
                existingCsErr.value = null;
                if (selectC.value == 'Link to an existing customer' && existingCs.value == null) {
                  existingCsErr.value = 'Field is required';
                  return;
                }

                Get.back();
                final resultChoice = await customModalButton<bool?>(
                  Get.context!,
                  title: 'Convert to opporunity',
                  saveTitle: 'Yes',
                  content: 'Are you sure you want to\nConvert this Leads?',
                  onSave: () => true,
                );
                if (resultChoice == true) {
                  MySnackBar.success(Get.context!, title: 'Leads Conversion Successful!', subTitle: 'Take this chance to move forward\nand close the deal!');
                }
              },
            ),
          ],
        ),
      );
    });
  }
}
