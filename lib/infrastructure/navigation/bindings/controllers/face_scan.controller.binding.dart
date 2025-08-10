import 'package:get/get.dart';

import '../../../../presentation/face_scan/controllers/face_scan.controller.dart';

class FaceScanControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FaceScanController());
  }
}
