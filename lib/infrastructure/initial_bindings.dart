import 'package:crm/common/components/custom_connection_status/custom_connection_status.controller.dart';
import 'package:crm/common/components/custom_loading/custom_loading.controller.dart';
import 'package:get/get.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(CustomLoadingController());
    Get.put(CustomConnectionStatusController());
    // Get.lazyPut(() => GetUserData(Get.find<UserRepository>()));
    // Get.put(UserController(Get.find<GetUserData>()));
  }
}
