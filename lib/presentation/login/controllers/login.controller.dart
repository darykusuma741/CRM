import 'package:crm/common/components/custom_loading/custom_loading.controller.dart';
import 'package:crm/common/ext/error_provider_ext.dart';
import 'package:crm/common/ext/load_data_result_ext.dart';
import 'package:crm/common/ext/string_ext.dart';
import 'package:crm/infrastructure/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/error_provider/error_provider.dart';
import '../../../common/helper/device_info_helper.dart';
import '../../../common/helper/my_snack_bar.dart';
import '../../../common/injections/injections.dart';
import '../../../data/models/login_state.dart';
import '../../../data/service/auth.service.dart';

class LoginController extends GetxController {
  late final AuthService authService;

  final loadingCtr = Get.find<CustomLoadingController>();
  Rx<bool> saveLogin = Rx(false);
  Rx<bool> waitingApproval = Rx(false);
  Rx<TextEditingController> ctrUser = Rx(TextEditingController());
  Rxn<String> errUser = Rxn();
  Rx<TextEditingController> ctrPass = Rx(TextEditingController());
  Rxn<String> errPass = Rxn();

  LoginController() {
    authService = AuthService(
      userRepository: sl(),
      email: () => ctrUser.value.text,
      password: () => ctrPass.value.text,
      imeiCode: () => DeviceInfoHelper.getImeiCode(),
      deviceId: () => DeviceInfoHelper.getDeviceId(),
      deviceName: () => DeviceInfoHelper.getDeviceName(),
      deviceModel: () => DeviceInfoHelper.getDeviceModel(),
      isSaveForFutureLogin: () => saveLogin.value,
    );
  }

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
    authService.login(
      onUpdateLoginResultStateLoadDataResult: (loginResultStateLoadDataResult) {
        loadingCtr.isLoading.value = loginResultStateLoadDataResult.isLoading;
        if (loginResultStateLoadDataResult.isSuccess) {
          var loginResultState = loginResultStateLoadDataResult.resultIfSuccess!;
          if (loginResultState is WaitingForApprovalLoginResultState) {
            waitingApproval.value = true;
          } else if (loginResultState is FinalLoginResultState) {
            Get.offAllNamed(Routes.HOME);
          } else if (loginResultState is RejectLoginResultState) {
            waitingApproval.value = false;
            MySnackBar.error(
              Get.context!,
              title: "Login Request Rejected",
              subTitle: "Your login request has been rejected"
            );
          }
        } else if (loginResultStateLoadDataResult.isFailed) {
          var errorProviderResult = sl<ErrorProvider>().onGetErrorProviderResult(
            loginResultStateLoadDataResult.resultIfFailed
          ).toErrorProviderResultNonNull();
          MySnackBar.error(
            Get.context!,
            title: errorProviderResult.title,
            subTitle: errorProviderResult.message
          );
        }
      }
    );
  }
}
