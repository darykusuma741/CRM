import 'package:get/get.dart';

import '../../../../presentation/freight_product_detail/controllers/freight_product_detail.controller.dart';

class FreightProductDetailControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FreightProductDetailController());
  }
}
