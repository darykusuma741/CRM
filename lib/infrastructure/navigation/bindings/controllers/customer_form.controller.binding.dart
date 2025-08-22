import 'package:get/get.dart';

import '../../../../presentation/customer_form/controllers/customer_form.controller.dart';

class CustomerFormControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CustomerFormController());
  }
}
