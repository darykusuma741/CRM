import 'dart:io';

import 'package:crm/common/components/custom_loading/custom_loading.controller.dart';
import 'package:crm/common/components/custom_modal/custom_modal.dart';
import 'package:crm/common/components/custom_modal_bottom.dart';
import 'package:crm/common/helper/my_snack_bar.dart';
import 'package:crm/controller/activity.main.controller.dart';
import 'package:crm/data/model/activity.model.dart';
import 'package:crm/presentation/call_activities/component/call_activities.detail.component.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class CallActivitiesController extends GetxController {
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
    customModalBottom(CallActivitiesDetailComponent(item));
  }

  void onClickWhatsapp(ActivityModel item) async {
    try {
      if (item.wa == null) return;
      ctrLoading.isLoading.value = true;
      final url = Uri.parse(urlNya(item.wa!, ''));
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Tidak bisa membuka WhatsApp.';
      }
      // data.value = await ctrActivityMain.onDoneDocActivity(item);
      // await CustomModal(
      //   Get.context!,
      //   title: 'Activity Done!',
      //   subTitle: 'You’ve successfully completed this activity.\nWell done!',
      // ).success();
    } catch (e) {
      MySnackBar.error(Get.context!, title: e.toString());
    }
    ctrLoading.isLoading.value = false;
  }

  String urlNya(String phone, String message) {
    if (Platform.isAndroid) {
      // add the [https]
      return "https://wa.me/$phone/?text=${Uri.parse(message)}"; // new line
    } else {
      // add the [https]
      return "https://api.whatsapp.com/send?phone=$phone=${Uri.parse(message)}"; // new line
    }
  }

  void onSubmit(ActivityModel item) async {
    Get.back();
    try {
      ctrLoading.isLoading.value = true;
      data.value = await ctrActivityMain.onDoneCallActivity(item);
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
