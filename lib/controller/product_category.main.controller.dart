import 'package:crm/data/dummy/product_category.dummy.dart';
import 'package:crm/data/model/product_category.model.dart';
import 'package:get/get.dart';

class ProductCategoryMainController extends GetxController {
  Rx<List<ProductCategoryModel>> data = Rx([]);

  Future getData() async {
    data.value = data.value.isEmpty ? ProductCategoryDummy.data : data.value;
  }
}
