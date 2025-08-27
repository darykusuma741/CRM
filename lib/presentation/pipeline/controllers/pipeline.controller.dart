import 'package:crm/controller/pipeline.main.controller.dart';
import 'package:get/get.dart';

class PipelineController extends GetxController {
  final pipelineMainCtr = Get.put(PipelineMainController());

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    getData();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getData() {
    pipelineMainCtr.getData();
  }
}
