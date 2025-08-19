import 'package:get/get.dart';

import '../../../../presentation/freight_product_form/controllers/freight_product_form.controller.dart';

class FreightProductFormControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FreightProductFormController>(
      () => FreightProductFormController(),
    );
  }
}
