import 'package:crm/data/dummy/activity.dummy.dart';
import 'package:crm/data/model/activity.model.dart';
import 'package:get/get.dart';

class ActivityMainController extends GetxController {
  Rx<List<ActivityModel>> allDataCall = Rx([]);
  Rx<List<ActivityModel>> allDataDoc = Rx([]);
  Rx<List<ActivityModel>> allDataMeeting = Rx([]);
  Rx<List<ActivityModel>> allDataToDo = Rx([]);

  Future getData() async {
    allDataCall.value = ActivityDummy.dataCall;
    allDataDoc.value = ActivityDummy.dataDocument;
    allDataMeeting.value = ActivityDummy.dataMeeting;
    allDataToDo.value = ActivityDummy.dataToDo;
  }

  Future<List<ActivityModel>> onDoneDocActivity(ActivityModel item) async {
    final items = allDataDoc.value;
    final index = items.indexWhere((e) => e.id == item.id);
    if (index > 0) {
      items.removeAt(index);
      allDataDoc.value = [...items];
    }
    return items;
  }

  Future<List<ActivityModel>> onDoneCallActivity(ActivityModel item) async {
    final items = allDataCall.value;
    final index = items.indexWhere((e) => e.id == item.id);
    if (index > 0) {
      items.removeAt(index);
      allDataCall.value = [...items];
    }
    return items;
  }
}
