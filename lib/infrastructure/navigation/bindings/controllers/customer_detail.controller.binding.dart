import 'package:get/get.dart';

import '../../../../presentation/customer_detail/controllers/customer_detail.controller.dart';

class CustomerDetailControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CustomerDetailController());
  }
}
