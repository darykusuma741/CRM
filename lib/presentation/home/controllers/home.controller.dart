import 'package:crm/controller/activity.main.controller.dart';
import 'package:crm/controller/leads.main.controller.dart';
import 'package:crm/data/model/leads.model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  ActivityMainController ctrActivityMain = Get.put(ActivityMainController());
  Rx<DateTime> initialDate = Rx(DateTime.now());
  Rx<int> selectedIndexWidget = Rx(0);
  Rxn<LeadsType> selectCategory = Rxn();

  LeadsMainController ctrLeadsMain = Get.put(LeadsMainController());
  Rx<List<LeadsModel>> dataLeads = Rx([]);

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    ctrActivityMain.getData();
    ctrLeadsMain.getData().then((e) {
      filterLeads();
    });

    super.onReady();
  }

  filterLeads() {
    dataLeads.value = ctrLeadsMain.data.value.where((e) => selectCategory.value == null ? true : e.type == selectCategory.value).toList();
  }

  searchLeads(String? query) {
    filterLeads();
    if (query == null || query.isEmpty) {
    } else {
      query = query.toLowerCase();

      dataLeads.value = dataLeads.value.where((lead) {
        return lead.title.toLowerCase().contains(query!) || lead.email.toLowerCase().contains(query) || lead.noHp.toLowerCase().contains(query);
      }).toList();
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
