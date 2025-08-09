import 'package:get/get.dart';

import '../../../../presentation/call_activities/controllers/call_activities.controller.dart';

class CallActivitiesControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CallActivitiesController());
  }
}
