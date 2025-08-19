import 'package:get/get.dart';

import '../../../../presentation/product_category_detail/controllers/product_category_detail.controller.dart';

class ProductCategoryDetailControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProductCategoryDetailController());
  }
}
