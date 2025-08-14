import 'package:crm/common/components/custom_loading/custom_loading.controller.dart';
import 'package:crm/controller/activity.main.controller.dart';
import 'package:crm/data/model/activity.model.dart';
import 'package:get/get.dart';

class MeetingActivitiesController extends GetxController {
  Rx<List<ActivityModel>> data = Rx(Get.arguments ?? []);
  ActivityMainController ctrActivityMain = Get.put(ActivityMainController());
  CustomLoadingController ctrLoading = Get.put(CustomLoadingController());

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
