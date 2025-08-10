import 'package:get/get.dart';

import '../../../../presentation/add_lead/controllers/add_lead.controller.dart';

class AddLeadControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AddLeadController());
  }
}
