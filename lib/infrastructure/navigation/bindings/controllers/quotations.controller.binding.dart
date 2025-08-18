import 'package:get/get.dart';

import '../../../../presentation/quotations/controllers/quotations.controller.dart';

class QuotationsControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(QuotationsController());
  }
}
