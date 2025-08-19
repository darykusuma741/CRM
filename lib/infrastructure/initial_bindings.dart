import 'package:crm/common/components/custom_connection_status/custom_connection_status.controller.dart';
import 'package:crm/common/components/custom_loading/custom_loading.controller.dart';
import 'package:crm/controller/activity.main.controller.dart';
import 'package:crm/controller/freight_product.main.controller.dart';
import 'package:crm/controller/leads.main.controller.dart';
import 'package:crm/controller/product_category.main.controller.dart';
import 'package:crm/controller/product_service.main.controller.dart';
import 'package:get/get.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(CustomLoadingController());
    Get.put(CustomConnectionStatusController());
    Get.put(ActivityMainController());
    Get.put(FreightProductMainController());
    Get.put(LeadsMainController());
    Get.put(ProductServiceMainController());
    Get.put(ProductCategoryMainController());
  }
}
