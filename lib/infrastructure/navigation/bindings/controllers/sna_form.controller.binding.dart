import 'package:get/get.dart';

import '../../../../presentation/sna_form/controllers/sna_form.controller.dart';

class SnaFormControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SnaFormController());
  }
}
