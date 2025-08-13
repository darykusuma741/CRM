import 'package:crm/common/components/custom_loading/custom_loading.controller.dart';
import 'package:crm/common/components/custom_modal/custom_modal.dart';
import 'package:crm/common/components/custom_modal_bottom.dart';
import 'package:crm/common/helper/my_snack_bar.dart';
import 'package:crm/controller/activity.main.controller.dart';
import 'package:crm/data/model/activity.model.dart';
import 'package:crm/presentation/document_activities/component/document_activities.detail.component.dart';
import 'package:get/get.dart';

class DocumentActivitiesController extends GetxController {
  Rx<List<ActivityModel>> data = Rx(Get.arguments ?? []);
  ActivityMainController ctrActivityMain = Get.put(ActivityMainController());
  CustomLoadingController ctrLoading = Get.put(CustomLoadingController());

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onClickDetail(ActivityModel item) {
    customModalBottom(DocumentActivitiesDetailComponent(item));
  }

  void onSubmit(ActivityModel item) async {
    Get.back();
    try {
      ctrLoading.isLoading.value = true;
      data.value = await ctrActivityMain.onDoneDocActivity(item);
      await CustomModal(
        Get.context!,
        title: 'Activity Done!',
        subTitle: 'You’ve successfully completed this activity.\nWell done!',
      ).success();
    } catch (e) {
      MySnackBar.error(Get.context!, title: e.toString());
    }
    ctrLoading.isLoading.value = false;
  }
}
