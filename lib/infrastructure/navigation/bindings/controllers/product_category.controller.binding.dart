import 'package:get/get.dart';

import '../../../../presentation/product_category/controllers/product_category.controller.dart';

class ProductCategoryControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProductCategoryController());
  }
}
