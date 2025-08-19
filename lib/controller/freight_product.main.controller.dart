import 'package:crm/data/dummy/freight_product.dummy.dart';
import 'package:crm/data/model/freight_product.model.dart';
import 'package:get/get.dart';

class FreightProductMainController extends GetxController {
  Rx<List<FreightProductModel>> data = Rx([]);

  Future getData() async {
    if (data.value.isEmpty) {
      data.value = FreightProductDummy.data;
    }
  }

  Future createData(FreightProductModel newData) async {
    data.value = [newData, ...data.value];
  }

  Future editData(FreightProductModel editData) async {
    final List<FreightProductModel> existing = [...data.value];

    final int index = existing.indexWhere((e) => e.id == editData.id);
    if (index >= 0) {
      existing[index] = editData;
    }
    // editData
    data.value = [...existing];
  }
}
