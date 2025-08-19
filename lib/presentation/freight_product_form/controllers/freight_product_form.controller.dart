import 'dart:io';

import 'package:crm/common/components/my_snack_bar.dart';
import 'package:crm/data/model/freight_product.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FreightProductFormController extends GetxController {
  Rxn<FreightProductModel> item = Rxn(Get.arguments);
  Rx<List<String>> selectTransportBy = Rx([]);
  Rxn<String?> selectTransportByErr = Rxn();
  Rx<List<File>> files = Rx([]);
  Rxn<String?> productType = Rxn();
  Rxn<String?> productTypeErr = Rxn();
  Rxn<String?> branch = Rxn();

  Rx<TextEditingController> internalReferenceCtr = Rx(TextEditingController());
  Rx<TextEditingController> productNameCtr = Rx(TextEditingController());
  Rxn<String?> productNameErr = Rxn();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    if (Get.arguments != null) {
      item.value = Get.arguments;
      productNameCtr.value.text = item.value!.name;
      branch.value = item.value!.branch;
      productType.value = item.value!.type.toShortString();
      selectTransportBy.value = item.value!.transportBy == FreightProductTrBy.all ? ['Air', 'Ocean'] : [item.value!.transportBy.toShortString()];
      internalReferenceCtr.value.text = item.value!.internalReference ?? '';
    }
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onSubmit() {
    bool next = true;

    productNameErr.value = null;
    if (productNameCtr.value.text.isEmpty) {
      productNameErr.value = 'Field is required';
      next = false;
    }

    productTypeErr.value = null;
    if (productType.value == null) {
      productTypeErr.value = 'Field is required';
      next = false;
    }

    selectTransportByErr.value = null;
    if (selectTransportBy.value.isEmpty) {
      selectTransportByErr.value = 'Field is required';
      next = false;
    }

    if (!next) return;
    Get.back();
    MySnackBar.success(
      Get.context!,
      title: 'Freight product successfully added!',
      subTitle: 'New freight product added to your list.',
    );
  }
}
