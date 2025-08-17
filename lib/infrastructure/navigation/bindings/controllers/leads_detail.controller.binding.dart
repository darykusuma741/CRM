import 'package:get/get.dart';

import '../../../../presentation/leads_detail/controllers/leads_detail.controller.dart';

class LeadsDetailControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LeadsDetailController());
  }
}
