import 'dart:io';
import 'dart:math';

import 'package:crm/common/components/my_snack_bar.dart';
import 'package:crm/controller/freight_product.main.controller.dart';
import 'package:crm/data/model/freight_product.model.dart';
import 'package:crm/presentation/freight_product/controllers/freight_product.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FreightProductFormController extends GetxController {
  FreightProductMainController ctrFreightProductMain = Get.put(FreightProductMainController());
  FreightProductController ctrFreightProduct = Get.put(FreightProductController());

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

  void onSubmit() async {
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
    final FreightProductType type = productType.value == "Service" ? FreightProductType.service : FreightProductType.product;
    final FreightProductTrBy transportBy = selectTransportBy.value.length == 2
        ? FreightProductTrBy.all
        : selectTransportBy.value.contains('Ocean')
            ? FreightProductTrBy.ocean
            : FreightProductTrBy.air;

    if (item.value == null) {
      final newData = FreightProductModel(
        id: Random().nextInt(99999),
        name: productNameCtr.value.text,
        type: type,
        transportBy: transportBy,
        productCategory: [],
        branch: branch.value,
        internalReference: internalReferenceCtr.value.text.isEmpty ? null : internalReferenceCtr.value.text,
      );
      ctrFreightProduct.getData();
      await ctrFreightProductMain.createData(newData);
      Get.back(result: newData);
    } else {
      final FreightProductModel editData = item.value!.copyWith(
        name: productNameCtr.value.text,
        type: type,
        transportBy: transportBy,
        branch: branch.value,
        productCategory: [],
        internalReference: internalReferenceCtr.value.text.isEmpty ? null : internalReferenceCtr.value.text,
      );
      ctrFreightProduct.getData();
      await ctrFreightProductMain.editData(editData);
      Get.back(result: editData);
    }

    MySnackBar.success(
      Get.context!,
      title: 'Freight product successfully added!',
      subTitle: 'New freight product added to your list.',
    );
  }
}
