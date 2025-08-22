import 'dart:io';
import 'dart:math';

import 'package:crm/common/components/custom_modal_bottom.dart';
import 'package:crm/data/enum/customer_detail_type.dart';
import 'package:crm/data/enum/customer_type.dart';
import 'package:crm/data/enum/transport_by.dart';
import 'package:crm/data/model/additional_address.model.dart';
import 'package:crm/data/model/customer.model.dart';
import 'package:crm/presentation/address_form/controllers/address_form.controller.dart';
import 'package:crm/presentation/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerFormController extends GetxController {
  final item = Rxn<CustomerModel?>(Get.arguments);

  final productCategory = Rx<List<String>>([]);
  final productCategoryErr = Rxn<String?>();

  final customerDetailType = Rx<String>(CustomerDetailType.individual.toShortString());

  final customerType = Rxn<String?>();
  final customerTypeErr = Rxn<String?>();

  final selectTransportBy = Rx<List<String>>([]);
  final selectTransportByErr = Rxn<String?>();

  final nikCtr = TextEditingController().obs;
  final nikErr = Rxn<String?>();

  final nameCtr = TextEditingController().obs;
  final nameErr = Rxn<String?>();

  final country = Rxn<String?>();
  final countryErr = Rxn<String?>();

  final emailCtr = TextEditingController().obs;
  final emailErr = Rxn<String?>();

  final streetAddressCtr = TextEditingController().obs;
  final streetAddressErr = Rxn<String?>();

  final companyNameCtr = TextEditingController().obs;
  final companyNameErr = Rxn<String?>();

  final taxIdCtr = TextEditingController().obs;
  final taxIdErr = Rxn<String?>();

  final phoneNumberCtr = TextEditingController().obs;
  final phoneNumberErr = Rxn<String?>();

  final postalCodeCtr = TextEditingController().obs;
  final postalCodeErr = Rxn<String?>();

  final state = Rxn<String?>();
  final stateErr = Rxn<String?>();

  final cityCtr = TextEditingController().obs;
  final cityErr = Rxn<String?>();

  final companyNameSelect = Rxn<String?>();

  final titleType = Rxn<String?>();
  final titleTypeErr = Rxn<String?>();

  final npwpCtr = TextEditingController().obs;

  final fileKtp = Rxn<File?>();

  final fileNpwp = Rxn<File?>();

  final additionalAddress = Rx<List<AdditionalAddressModel>>([]);

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
    item.value = Get.arguments;
    if (item.value != null) {
      final v = item.value!;
      customerType.value = v.customerType.toShortString();
      selectTransportBy.value = v.transportBy.isAll
          ? [TransportBy.air.toShortString(), TransportBy.ocean.toShortString()]
          : v.transportBy.isAir
              ? [TransportBy.air.toShortString()]
              : [TransportBy.ocean.toShortString()];
      productCategory.value = v.productCategory;
      customerDetailType.value = v.detailType.toShortString();
      if (v.detailType.isIndividual) {
        titleType.value = v.title;
        nameCtr.value.text = v.customerName ?? '';
        companyNameSelect.value = v.companyName;
      } else {
        companyNameCtr.value.text = v.companyName ?? '';
        taxIdCtr.value.text = v.taxId ?? '';
      }

      emailCtr.value.text = v.email ?? '';
      phoneNumberCtr.value.text = v.phoneNumber ?? '';
      cityCtr.value.text = v.city ?? '';
      state.value = v.state;
      country.value = v.country;
      streetAddressCtr.value.text = v.streetAddress ?? '';
      postalCodeCtr.value.text = v.postalCode ?? '';
      nikCtr.value.text = v.nik ?? '';
      npwpCtr.value.text = v.npwp ?? '';
      additionalAddress.value = v.additionalAddress;
    }
  }

  void onClickAddIndividual() async {
    Get.delete<AddressFormController>();
    final ctrForm = Get.put(AddressFormController());
    ctrForm.initial(titleValue: 'Add Individual');
    final AdditionalAddressModel? result = await customModalBottom<AdditionalAddressModel?>(AddressFormScreen());
    additionalAddress.value = [result, ...additionalAddress.value].whereType<AdditionalAddressModel>().toList();
  }

  void onTapEditAddress(AdditionalAddressModel v) async {
    Get.delete<AddressFormController>();
    final ctrForm = Get.put(AddressFormController());
    ctrForm.initial(titleValue: 'Edit Individual', v: v);
    final AdditionalAddressModel? result = await customModalBottom<AdditionalAddressModel?>(AddressFormScreen());
    if (result != null) {
      final existing = [...additionalAddress.value];
      final index = existing.indexWhere((e) => e.id == result.id);
      if (index >= 0) {
        existing[index] = result;
        additionalAddress.value = existing;
      }
    }
  }

  void onSubmit() {
    bool next = true;

    customerTypeErr.value = null;
    if (customerType.value == null) {
      customerTypeErr.value = 'Field is required';
      next = false;
    }

    selectTransportByErr.value = null;
    if (selectTransportBy.value.isEmpty) {
      selectTransportByErr.value = 'Field is required';
      next = false;
    }

    productCategoryErr.value = null;
    if (productCategory.value.isEmpty) {
      productCategoryErr.value = 'Field is required';
      next = false;
    }

    if (customerDetailType.value == CustomerDetailType.individual.toShortString()) {
      titleTypeErr.value = null;
      if (titleType.value == null) {
        titleTypeErr.value = 'Field is required';
        next = false;
      }
      nameErr.value = null;
      if (nameCtr.value.text.isEmpty) {
        nameErr.value = 'Field is required';
        next = false;
      }
    } else {
      companyNameErr.value = null;
      if (companyNameCtr.value.text.isEmpty) {
        companyNameErr.value = 'Field is required';
        next = false;
      }
      emailErr.value = null;
      if (emailCtr.value.text.isEmpty) {
        emailErr.value = 'Field is required';
        next = false;
      }
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
    nikErr.value = null;
    if (nikCtr.value.text.isEmpty) {
      nikErr.value = 'Field is required';
      next = false;
    }

    if (!next) return;

    final trBy = selectTransportBy.value.length >= 2 ? TransportBy.all : (TransportByExtension.fromString(selectTransportBy.value.first));
    CustomerModel newData = CustomerModel(
      id: Random().nextInt(999999),
      customerType: CustomerTypeExtension.fromString(customerType.value!),
      transportBy: trBy,
      productCategory: productCategory.value,
      detailType: CustomerDetailTypeExtension.fromString(customerDetailType.value),
      additionalAddress: additionalAddress.value,
      markings: [],
      phoneNumber: phoneNumberCtr.value.text,
      city: cityCtr.value.text,
      state: state.value,
      country: country.value,
      streetAddress: streetAddressCtr.value.text,
      postalCode: postalCodeCtr.value.text,
      nik: nikCtr.value.text,
      npwp: npwpCtr.value.text.isEmpty ? null : npwpCtr.value.text,
      email: emailCtr.value.value.text.isEmpty ? null : emailCtr.value.value.text,
    );
    if (newData.detailType.isCompany) {
      newData = newData.copyWith(
        companyName: companyNameCtr.value.text.isEmpty ? null : companyNameCtr.value.text,
        taxId: taxIdCtr.value.text.isEmpty ? null : taxIdCtr.value.text,
      );
    } else {
      newData = newData.copyWith(
        title: titleType.value,
        customerName: nameCtr.value.text,
        companyName: companyNameSelect.value,
      );
    }
    if (item.value == null) {
      Get.back(result: newData);
    } else {
      final CustomerModel editData = newData.copyWith(id: item.value!.id);
      Get.back(result: editData);
    }
  }
}
