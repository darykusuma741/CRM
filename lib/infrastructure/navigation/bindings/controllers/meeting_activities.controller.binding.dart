import 'package:get/get.dart';

import '../../../../presentation/meeting_activities/controllers/meeting_activities.controller.dart';

class MeetingActivitiesControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MeetingActivitiesController());
  }
}
