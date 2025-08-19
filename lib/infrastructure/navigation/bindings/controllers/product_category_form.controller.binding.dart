import 'package:get/get.dart';

import '../../../../presentation/product_category_form/controllers/product_category_form.controller.dart';

class ProductCategoryFormControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProductCategoryFormController());
  }
}
