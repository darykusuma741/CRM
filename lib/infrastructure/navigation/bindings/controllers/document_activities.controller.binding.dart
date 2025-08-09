import 'package:get/get.dart';

import '../../../../presentation/document_activities/controllers/document_activities.controller.dart';

class DocumentActivitiesControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DocumentActivitiesController());
  }
}
