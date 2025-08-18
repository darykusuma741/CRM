import 'package:get/get.dart';

import '../../../../presentation/product_service/controllers/product_service.controller.dart';

class ProductServiceControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProductServiceController());
  }
}
