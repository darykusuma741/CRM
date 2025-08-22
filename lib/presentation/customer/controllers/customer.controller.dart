import 'package:crm/controller/customer.main.controller.dart';
import 'package:crm/data/enum/customer_detail_type.dart';
import 'package:crm/data/model/customer.model.dart';
import 'package:crm/infrastructure/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerController extends GetxController {
  CustomerMainController ctrCustomerMain = Get.put(CustomerMainController());
  Rx<List<CustomerModel>> data = Rx([]);
  Rx<TextEditingController> searchCustomerCtr = Rx(TextEditingController());
  Rxn<CustomerDetailType?> detailType = Rxn();
  Rx<int> countAll = Rx(0);
  Rx<int> countCompany = Rx(0);
  Rx<int> countIndividual = Rx(0);

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
      countAll.value = data.value.length;
      countCompany.value = data.value.where((e) => e.detailType.isCompany).toList().length;
      countIndividual.value = data.value.where((e) => e.detailType.isIndividual).toList().length;
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

  void onClickItem(CustomerModel item) {
    Get.toNamed(Routes.CUSTOMER_DETAIL, arguments: item);
  }
}
