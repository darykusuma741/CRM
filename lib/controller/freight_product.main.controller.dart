import 'package:crm/data/dummy/freight_product.dummy.dart';
import 'package:crm/data/model/freight_product.model.dart';
import 'package:get/get.dart';

class FreightProductMainController extends GetxController {
  Rx<List<FreightProductModel>> data = Rx([]);

  Future getData() async {
    data.value = FreightProductDummy.data;
  }
}
