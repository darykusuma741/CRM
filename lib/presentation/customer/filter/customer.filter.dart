import 'package:crm/common/components/custom_select_category.dart';
import 'package:crm/common/components/custom_text_editing.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/common/constants/image_assets.dart';
import 'package:crm/data/model/customer.model.dart';
import 'package:crm/presentation/customer/controllers/customer.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CustomerFilter extends GetView<CustomerController> {
  const CustomerFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: CustomTextEditing(
              onChanged: (v) {
                controller.searchCustomer(v);
              },
              controller: controller.searchCustomerCtr.value,
              hint: 'Search your product',
              borderRadius: BorderRadius.circular(100.r),
              borderSide: BorderSide(width: 0.0, color: Colors.transparent),
              fillColor: ColorsName.grayCloudy,
              prefixIcon: Container(
                // color: Colors.amber,
                padding: EdgeInsets.only(right: 6.w, left: 12.w, top: 10.h, bottom: 10.h),
                child: SvgPicture.asset(ImageAssets.iconSvgSearch, width: 14.w),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          CustomSelectCategory<CustomerDetailType?>(
            selectItem: controller.detailType.value,
            onTap: (e) {
              controller.detailType.value = e;
              controller.searchCustomer(controller.searchCustomerCtr.value.text);
            },
            items: [
              CustomSelectCategoryState<CustomerDetailType?>(count: controller.countAll.value, label: 'All', value: null),
              CustomSelectCategoryState<CustomerDetailType?>(count: controller.countCompany.value, label: 'Company', value: CustomerDetailType.company),
              CustomSelectCategoryState<CustomerDetailType?>(
                  count: controller.countIndividual.value, label: 'Individual', value: CustomerDetailType.individual),
            ],
          ),
        ],
      );
    });
  }
}
