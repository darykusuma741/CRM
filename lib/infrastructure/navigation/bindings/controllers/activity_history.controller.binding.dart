import 'package:get/get.dart';

import '../../../../presentation/activity_history/controllers/activity_history.controller.dart';

class ActivityHistoryControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ActivityHistoryController());
  }
}
