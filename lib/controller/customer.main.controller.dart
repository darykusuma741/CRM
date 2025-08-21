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
}
