import 'package:crm/controller/customer.main.controller.dart';
import 'package:crm/data/model/customer.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerController extends GetxController {
  CustomerMainController ctrCustomerMain = Get.put(CustomerMainController());
  Rx<List<CustomerModel>> data = Rx([]);
  Rx<TextEditingController> searchCustomerCtr = Rx(TextEditingController());
  Rxn<CustomerDetailType?> detailType = Rxn();

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

  void searchCustomer(String? query) {
    if (query == null || query.isEmpty) {
      data.value = ctrCustomerMain.data.value;
    } else {
      query = query.toLowerCase();

      data.value = [
        ...ctrCustomerMain.data.value.where((v) {
          final String? name = v.companyName ?? v.customerName;
          if (name == null) return true;

          return name.toLowerCase().contains(query!);
        })
      ];
    }
    data.value = data.value.where((v) {
      return detailType.value == null ? true : detailType.value == v.detailType;
    }).toList();
  }

  void onClickItem(CustomerModel item) {}
}
