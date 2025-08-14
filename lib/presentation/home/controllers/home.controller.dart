import 'package:crm/controller/activity.main.controller.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  ActivityMainController ctrActivityMain = Get.put(ActivityMainController());
  Rx<DateTime> initialDate = Rx(DateTime.now());
  Rx<int> selectedIndexWidget = Rx(0);

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    ctrActivityMain.getData();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
