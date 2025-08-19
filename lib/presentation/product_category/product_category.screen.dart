import 'package:crm/common/components/custom_floating_action_container.dart';
import 'package:crm/common/components/custom_scaffold.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/presentation/product_category/filter/product_category.filter.dart';
import 'package:crm/presentation/product_category/items/product_category.items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'controllers/product_category.controller.dart';

class ProductCategoryScreen extends GetView<ProductCategoryController> {
  const ProductCategoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        title: 'Product Category',
      ),
      floatingActionButton: CustomFloatingActionContainer(onTap: () {
        // Get.toNamed(Routes.FREIGHT_PRODUCT_FORM);
      }),
      backgroundColor: ColorsName.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductCategoryFilter(),
            SizedBox(height: 6.h),
            ProductCategoryItems(),
          ],
        ),
      ),
    );
  }
}
