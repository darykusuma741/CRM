import 'package:crm/controller/product_category.main.controller.dart';
import 'package:crm/data/model/product_category.model.dart';
import 'package:crm/infrastructure/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCategoryController extends GetxController {
  ProductCategoryMainController ctrProductCategoryMain = Get.put(ProductCategoryMainController());
  Rx<List<ProductCategoryModel>> data = Rx([]);
  Rx<TextEditingController> searchProductCtr = Rx(TextEditingController());
  Rxn<String?> transportBy = Rxn();

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
    transportBy.value = null;
    searchProductCtr.value.text = "";
    ctrProductCategoryMain.getData().then((v) {
      data.value = ctrProductCategoryMain.data.value;
    });
  }

  void searchProduct(String? query) {
    if (query == null || query.isEmpty) {
      data.value = ctrProductCategoryMain.data.value;
    } else {
      query = query.toLowerCase();

      data.value = [
        ...ctrProductCategoryMain.data.value.where((v) {
          return v.name.toLowerCase().contains(query!);
        })
      ];
    }
    data.value = data.value.where((v) {
      return transportBy.value == null ? true : transportBy.value == v.transportBy.toShortString();
    }).toList();
  }

  void onApplyTransportBy(String? value) {
    transportBy.value = value;
    searchProduct(searchProductCtr.value.text);
  }

  void onClickItem(ProductCategoryModel item) async {
    await Get.toNamed(Routes.PRODUCT_CATEGORY_DETAIL, arguments: item);
  }
}
