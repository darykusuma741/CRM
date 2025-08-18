import 'package:crm/data/dummy/product_service.dummy.dart';
import 'package:crm/data/model/product_service.model.dart';
import 'package:get/get.dart';

class ProductServiceMainController extends GetxController {
  Rx<List<ProductServiceModel>> data = Rx([]);

  Future getData() async {
    data.value = ProductServiceDummy.data;
  }
}
