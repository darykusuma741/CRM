import 'package:get/get.dart';

import '../../../../presentation/pipeline/controllers/pipeline.controller.dart';

class PipelineControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PipelineController());
  }
}
