import 'package:crm/controller/customer.main.controller.dart';
import 'package:crm/data/model/customer.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerController extends GetxController {
  CustomerMainController ctrCustomerMain = Get.put(CustomerMainController());
  Rx<List<CustomerModel>> data = Rx([]);
  Rx<TextEditingController> searchCustomerCtr = Rx(TextEditingController());

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    getData();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getData() {
    searchCustomerCtr.value.text = "";
    ctrCustomerMain.getData().then((v) {
      data.value = ctrCustomerMain.data.value;
    });
  }

  void onClickItem(CustomerModel item) {}
}
