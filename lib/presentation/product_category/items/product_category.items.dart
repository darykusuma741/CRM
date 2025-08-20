import 'package:crm/common/components/custom_list.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/data/enum/transport_by.dart';
import 'package:crm/data/model/product_category.model.dart';
import 'package:crm/presentation/product_category/controllers/product_category.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProductCategoryItems extends GetView<ProductCategoryController> {
  const ProductCategoryItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final List<ProductCategoryModel> data = controller.data.value;
      return CustomList<ProductCategoryModel>(
        scroll: false,
        items: data,
        paddingDivider: EdgeInsets.symmetric(horizontal: 16.w),
        itemBuilder: (context, index) {
          final ProductCategoryModel item = data[index];
          return ProductCategoryItemsItem(item);
        },
      );
    });
  }
}

class ProductCategoryItemsItem extends GetView<ProductCategoryController> {
  const ProductCategoryItemsItem(this.item, {super.key});
  final ProductCategoryModel item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => controller.onClickItem(item),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.name,
              style: BaseText.grayCharcoal.copyWith(fontSize: 13.sp),
            ),
            SizedBox(height: 4.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Transport: ${item.transportBy.toShortString()}',
                  style: BaseText.grayGraphiteDark.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
