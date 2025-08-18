import 'package:get/get.dart';

import '../../../../presentation/freight_product/controllers/freight_product.controller.dart';

class FreightProductControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FreightProductController());
  }
}
