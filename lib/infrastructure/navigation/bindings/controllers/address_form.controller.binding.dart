import 'package:get/get.dart';

import '../../../../presentation/address_form/controllers/address_form.controller.dart';

class AddressFormControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddressFormController>(
      () => AddressFormController(),
    );
  }
}
