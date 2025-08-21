import 'package:crm/data/dummy/customer.dummy.dart';
import 'package:crm/data/model/customer.model.dart';
import 'package:get/get.dart';

class CustomerMainController extends GetxController {
  Rx<List<CustomerModel>> data = Rx([]);

  Future getData() async {
    if (data.value.isEmpty) {
      data.value = CustomerDummy.data;
    }
  }

  Future editData(CustomerModel v) async {
    final List<CustomerModel> existing = [...data.value];
    final index = existing.indexWhere((e) => e.id == v.id);
    if (index >= 0) {
      existing[index] = v;
      data.value = existing;
    }
  }
}
