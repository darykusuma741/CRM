import 'package:crm/common/components/custom_select_modal/custom_select_modal.dart';
import 'package:crm/common/components/custom_text_editing.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/common/constants/image_assets.dart';
import 'package:crm/presentation/product_category/controllers/product_category.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ProductCategoryFilter extends GetView<ProductCategoryController> {
  const ProductCategoryFilter({super.key});

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
                controller.searchProduct(v);
              },
              controller: controller.searchProductCtr.value,
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              spacing: 8.w,
              children: [
                SizedBox(width: 8.w),
                CustomSelectModal<String>(
                  value: controller.transportBy.value,
                  hint: 'Transport By'.tr,
                  title: 'Transport By'.tr,
                  items: ['Air', 'Ocean', 'Air and Ocean'],
                  valueText: (v) {
                    return v;
                  },
                  onChange: controller.onApplyTransportBy,
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
