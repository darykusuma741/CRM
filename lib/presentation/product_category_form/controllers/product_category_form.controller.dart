import 'dart:math';

import 'package:crm/common/components/my_snack_bar.dart';
import 'package:crm/controller/product_category.main.controller.dart';
import 'package:crm/data/model/product_category.model.dart';
import 'package:crm/presentation/product_category/controllers/product_category.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCategoryFormController extends GetxController {
  ProductCategoryMainController ctrProductCategoryMain = Get.put(ProductCategoryMainController());
  ProductCategoryController ctrProductCategory = Get.put(ProductCategoryController());
  Rxn<ProductCategoryModel> item = Rxn(Get.arguments);

  Rx<TextEditingController> productNameCtr = Rx(TextEditingController());
  Rxn<String?> productNameErr = Rxn();

  Rx<TextEditingController> hsCodeCtr = Rx(TextEditingController());
  Rxn<String?> hsCodeErr = Rxn();

  Rx<TextEditingController> descriptionCtr = Rx(TextEditingController());

  Rx<List<String>> selectTransportBy = Rx([]);
  Rxn<String?> selectTransportByErr = Rxn();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    if (Get.arguments != null) {
      item.value = Get.arguments;
      productNameCtr.value.text = item.value!.name;
      descriptionCtr.value.text = item.value!.description ?? '';
      selectTransportBy.value = item.value!.transportBy == ProductCategoryTrBy.all ? ['Air', 'Ocean'] : [item.value!.transportBy.toShortString()];
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

    selectTransportByErr.value = null;
    if (selectTransportBy.value.isEmpty) {
      selectTransportByErr.value = 'Field is required';
      next = false;
    }

    hsCodeErr.value = null;
    if (hsCodeCtr.value.text.isEmpty) {
      hsCodeErr.value = 'Field is required';
      next = false;
    }

    if (!next) return;
    final ProductCategoryTrBy transportBy = selectTransportBy.value.length == 2
        ? ProductCategoryTrBy.all
        : selectTransportBy.value.contains('Ocean')
            ? ProductCategoryTrBy.ocean
            : ProductCategoryTrBy.air;

    if (item.value == null) {
      final newData = ProductCategoryModel(
        id: Random().nextInt(99999),
        name: productNameCtr.value.text,
        transportBy: transportBy,
        hsCode: hsCodeCtr.value.text,
        description: descriptionCtr.value.text.isEmpty ? null : descriptionCtr.value.text,
      );
      ctrProductCategory.getData();
      await ctrProductCategoryMain.createData(newData);
      Get.back(result: newData);
    } else {
      final ProductCategoryModel editData = item.value!.copyWith(
        name: productNameCtr.value.text,
        transportBy: transportBy,
        hsCode: hsCodeCtr.value.text,
        description: descriptionCtr.value.text.isEmpty ? null : descriptionCtr.value.text,
      );
      ctrProductCategory.getData();
      await ctrProductCategoryMain.editData(editData);
      Get.back(result: editData);
    }

    MySnackBar.success(
      Get.context!,
      title: 'Product cateogory successfully added!',
      subTitle: 'New product cateogory added to your list.',
    );
  }
}
