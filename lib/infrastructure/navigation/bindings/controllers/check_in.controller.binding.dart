import 'package:get/get.dart';

import '../../../../presentation/check_in/controllers/check_in.controller.dart';

class CheckInControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CheckInController());
  }
}
