import 'package:crm/data/dummy/product_category.dummy.dart';
import 'package:crm/data/model/product_category.model.dart';
import 'package:get/get.dart';

class ProductCategoryMainController extends GetxController {
  Rx<List<ProductCategoryModel>> data = Rx([]);

  Future getData() async {
    data.value = data.value.isEmpty ? ProductCategoryDummy.data : data.value;
  }

  Future createData(ProductCategoryModel newData) async {
    data.value = [newData, ...data.value];
  }

  Future editData(ProductCategoryModel editData) async {
    final List<ProductCategoryModel> existing = [...data.value];

    final int index = existing.indexWhere((e) => e.id == editData.id);
    if (index >= 0) {
      existing[index] = editData;
    }
    // editData
    data.value = [...existing];
  }
}
