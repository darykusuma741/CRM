import 'package:get/get.dart';

import '../../../../presentation/leads_form/controllers/leads_form.controller.dart';

class LeadsFormControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LeadsFormController());
  }
}
