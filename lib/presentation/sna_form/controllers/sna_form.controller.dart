import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnaFormController extends GetxController {
  List<String> activityRecItems = ['Call', 'Email', 'Meeting', 'Order Upsell', 'To Do', 'Upload Document'];
  Rx<List<String>> activityRec = Rx([]);
  Rxn<String?> activityRecErr = Rxn();

  Rxn<DateTime?> dueDate = Rxn();
  Rxn<String?> dueDateErr = Rxn();
  Rx<TextEditingController> dueDateCtr = Rx(TextEditingController());

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

  void onClickSubmit() {
    bool next = true;
    dueDateErr.value = null;
    if (dueDate.value == null) {
      dueDateErr.value = "Field is required";
      next = false;
    }

    if (activityRec.value.isEmpty) {
      activityRecErr.value = "Field is required";
      next = false;
    }

    if (!next) return;
    Get.back();
  }
}
