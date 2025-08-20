import 'package:crm/controller/freight_product.main.controller.dart';
import 'package:crm/data/enum/transport_by.dart';
import 'package:crm/data/model/freight_product.model.dart';
import 'package:crm/infrastructure/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FreightProductController extends GetxController {
  FreightProductMainController ctrFreightProductMain = Get.put(FreightProductMainController());
  Rx<List<FreightProductModel>> data = Rx([]);
  Rx<TextEditingController> searchProductCtr = Rx(TextEditingController());
  Rxn<String?> transportBy = Rxn();
  Rxn<String?> productType = Rxn();

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
    productType.value = null;
    searchProductCtr.value.text = "";
    ctrFreightProductMain.getData().then((v) {
      data.value = ctrFreightProductMain.data.value;
    });
  }

  void searchProduct(String? query) {
    if (query == null || query.isEmpty) {
      data.value = ctrFreightProductMain.data.value;
    } else {
      query = query.toLowerCase();

      data.value = [
        ...ctrFreightProductMain.data.value.where((v) {
          return v.name.toLowerCase().contains(query!);
        })
      ];
    }
    data.value = data.value.where((v) {
      return transportBy.value == null ? true : transportBy.value == v.transportBy.toShortString();
    }).toList();
    data.value = data.value.where((v) {
      return productType.value == null ? true : productType.value == v.type.toShortString();
    }).toList();
  }

  void onApplyTransportBy(String? value) {
    transportBy.value = value;
    searchProduct(searchProductCtr.value.text);
  }

  void onApplyProductType(String? value) {
    productType.value = value;
    searchProduct(searchProductCtr.value.text);
  }

  void onClickItem(FreightProductModel item) async {
    await Get.toNamed(Routes.FREIGHT_PRODUCT_DETAIL, arguments: item);
  }
}
