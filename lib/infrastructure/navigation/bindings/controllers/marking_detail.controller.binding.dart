import 'package:get/get.dart';

import '../../../../presentation/marking_detail/controllers/marking_detail.controller.dart';

class MarkingDetailControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MarkingDetailController());
  }
}
