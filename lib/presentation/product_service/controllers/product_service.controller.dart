import 'package:crm/controller/product_service.main.controller.dart';
import 'package:crm/data/model/product_service.model.dart';
import 'package:get/get.dart';

class ProductServiceController extends GetxController {
  ProductServiceMainController ctrProductServiceMain = Get.put(ProductServiceMainController());
  Rx<List<ProductServiceModel>> data = Rx([]);

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    ctrProductServiceMain.getData().then((v) {
      data.value = ctrProductServiceMain.data.value;
    });
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void searchProduct(String? query) {
    if (query == null || query.isEmpty) {
      data.value = ctrProductServiceMain.data.value;
    } else {
      query = query.toLowerCase();

      data.value = [
        ...ctrProductServiceMain.data.value.where((lead) {
          return lead.title.toLowerCase().contains(query!);
        })
      ];
    }
  }
}
