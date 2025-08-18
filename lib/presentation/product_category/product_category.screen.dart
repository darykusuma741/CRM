import 'package:crm/common/components/custom_scaffold.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:flutter/material.dart';

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
      backgroundColor: ColorsName.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // CustomTextEditing(hint: 'Search your product'),
          ],
        ),
      ),
    );
  }
}
