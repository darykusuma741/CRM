import 'package:crm/data/model/leads.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeadsFormController extends GetxController {
  final item = Rxn<LeadsModel?>(Get.arguments);
  final priority = Rx<int>(0);
  final leadNameCtr = Rx<TextEditingController>(TextEditingController());
  final leadNameErr = Rxn<String?>();
  final companyNameCtr = Rx<TextEditingController>(TextEditingController());
  final companyWebsiteCtr = Rx<TextEditingController>(TextEditingController());
  final companyWebsiteErr = Rxn<String?>();

  final contactNameCtr = Rx<TextEditingController>(TextEditingController());
  final contactNameErr = Rxn<String?>();

  final phoneNumberCtr = Rx<TextEditingController>(TextEditingController());
  final phoneNumberErr = Rxn<String?>();

  final cityCtr = Rx<TextEditingController>(TextEditingController());
  final cityErr = Rxn<String?>();

  final streetAddressCtr = Rx<TextEditingController>(TextEditingController());
  final streetAddressErr = Rxn<String?>();

  final postalCodeCtr = Rx<TextEditingController>(TextEditingController());
  final postalCodeErr = Rxn<String?>();

  final state = Rxn<String?>();
  final stateErr = Rxn<String?>();

  final country = Rxn<String?>();
  final countryErr = Rxn<String?>();

  final emailCtr = Rx<TextEditingController>(TextEditingController());

  final productCategory = Rx<List<String>>([]);
  final productCategoryErr = Rxn<String?>();

  final title = Rxn<String?>();

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
    if (Get.arguments != null) {
      item.value = Get.arguments;
      leadNameCtr.value.text = item.value?.leadName ?? '';
      priority.value = item.value?.rating ?? 0;
      companyNameCtr.value.text = item.value?.companyName ?? '';
      companyWebsiteCtr.value.text = item.value?.companyWebsite ?? '';
      productCategory.value = item.value?.productCategoty ?? [];
      title.value = item.value?.title;
      contactNameCtr.value.text = item.value?.contactName ?? '';
      emailCtr.value.text = item.value?.email ?? '';
      phoneNumberCtr.value.text = item.value?.phoneNumber ?? '';
      cityCtr.value.text = item.value?.city ?? '';
      state.value = item.value?.state;
      country.value = item.value?.country;
      streetAddressCtr.value.text = item.value?.streetAddress ?? '';
      postalCodeCtr.value.text = item.value?.postalCode ?? '';
    }
  }

  void onSubmit() {
    bool next = true;

    leadNameErr.value = null;
    if (leadNameCtr.value.text.isEmpty) {
      leadNameErr.value = 'Field is required';
      next = false;
    }

    companyWebsiteErr.value = null;
    if (companyWebsiteCtr.value.text.isEmpty) {
      companyWebsiteErr.value = 'Field is required';
      next = false;
    }

    productCategoryErr.value = null;
    if (productCategory.value.isEmpty) {
      productCategoryErr.value = 'Field is required';
      next = false;
    }

    contactNameErr.value = null;
    if (contactNameCtr.value.text.isEmpty) {
      contactNameErr.value = 'Field is required';
      next = false;
    }

    phoneNumberErr.value = null;
    if (phoneNumberCtr.value.text.isEmpty) {
      phoneNumberErr.value = 'Field is required';
      next = false;
    }

    cityErr.value = null;
    if (cityCtr.value.text.isEmpty) {
      cityErr.value = 'Field is required';
      next = false;
    }

    stateErr.value = null;
    if (state.value == null) {
      stateErr.value = 'Field is required';
      next = false;
    }

    countryErr.value = null;
    if (country.value == null) {
      countryErr.value = 'Field is required';
      next = false;
    }

    streetAddressErr.value = null;
    if (streetAddressCtr.value.text.isEmpty) {
      streetAddressErr.value = 'Field is required';
      next = false;
    }

    postalCodeErr.value = null;
    if (postalCodeCtr.value.text.isEmpty) {
      postalCodeErr.value = 'Field is required';
      next = false;
    }

    if (!next) return;
    Get.back();
  }
}
