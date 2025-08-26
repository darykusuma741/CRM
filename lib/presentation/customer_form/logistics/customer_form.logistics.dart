import 'package:crm/common/components/custom_check_list.dart';
import 'package:crm/common/components/custom_dropdown_multiple.dart';
import 'package:crm/common/components/custom_radio_list.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/data/dummy/product_category.dummy.dart';
import 'package:crm/data/enum/customer_type.dart';
import 'package:crm/data/enum/transport_by.dart';
import 'package:crm/presentation/customer_form/controllers/customer_form.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomerFormLogistics extends GetView<CustomerFormController> {
  const CustomerFormLogistics({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Logistics Information', style: BaseText.grayCharcoal.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w500)),
          SizedBox(height: 12.h),
          CustomRadioList<String>(
            label: 'Customer Type',
            items: [CustomerType.broker.toShortString(), CustomerType.personal.toShortString()],
            error: controller.customerTypeErr.value,
            onClick: (v) {
              controller.customerTypeErr.value = null;
              controller.customerType.value = v;
            },
            selectItems: controller.customerType.value,
          ),
          SizedBox(height: 16.h),
          CustomCheckList<String>(
            label: 'Transport by',
            items: [TransportBy.air.toShortString(), TransportBy.ocean.toShortString()],
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
          CustomDropdownMultiple<String>(
            label: 'Product Category',
            selectedItem: controller.productCategory.value,
            items: ProductCategoryDummy.data.map((e) => e.name).toList(),
            hint: 'Select product category',
            customContent: (p0) => p0.toString(),
            error: controller.productCategoryErr.value,
            onDelete: (v) {
              controller.productCategoryErr.value = null;
              final exists = controller.productCategory.value;
              if (exists.contains(v)) exists.remove(v);
              controller.productCategory.value = [...exists];
            },
            onChanged: (v) {
              controller.productCategoryErr.value = null;
              final exists = controller.productCategory.value;
              (exists.contains(v)) ? exists.remove(v) : exists.add(v);
              controller.productCategory.value = [...exists];
            },
          ),
        ],
      );
    });
  }
}
