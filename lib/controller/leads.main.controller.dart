import 'package:crm/data/dummy/leads.dummy.dart';
import 'package:crm/data/model/leads.model.dart';
import 'package:get/get.dart';

class LeadsMainController extends GetxController {
  Rx<List<LeadsModel>> data = Rx([]);

  Future getData() async {
    data.value = data.value.isEmpty ? LeadsDummy.data : data.value;
  }
}
