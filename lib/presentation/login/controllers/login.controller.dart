import 'package:crm/common/components/custom_loading/custom_loading.controller.dart';
import 'package:crm/controller/auth.main.controller.dart';
import 'package:crm/infrastructure/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final loadingCtr = Get.find<CustomLoadingController>();
  final loginMainCtr = Get.put<AuthMainController>(AuthMainController());
  Rx<bool> saveLogin = Rx(false);
  Rx<bool> waitingApproval = Rx(false);
  Rx<TextEditingController> ctrUser = Rx(TextEditingController());
  Rxn<String> errUser = Rxn();
  Rx<TextEditingController> ctrPass = Rx(TextEditingController());
  Rxn<String> errPass = Rxn();

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

  void onCLickLogin() async {
    bool next = true;

    errUser.value = null;
    if (ctrUser.value.text.isEmpty) {
      next = false;
      errUser.value = "Field is required";
    }
    errPass.value = null;
    if (ctrPass.value.text.isEmpty) {
      next = false;
      errPass.value = "Field is required";
    }
    if (!next) return;
    // loadingCtr.isLoading.value = true;
    // await loginMainCtr.login(email: ctrUser.value.text, password: ctrPass.value.text);
    // loadingCtr.isLoading.value = false;
    waitingApproval.value = true;
    await Future.delayed(Duration(seconds: 2)).then((_) {
      Get.offAllNamed(Routes.HOME);
    });
  }
}
