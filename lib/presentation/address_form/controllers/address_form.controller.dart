import 'dart:math';

import 'package:crm/data/enum/address_type.dart';
import 'package:crm/data/enum/title_type.dart';
import 'package:crm/data/model/additional_address.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressFormController extends GetxController {
  final Rxn<AdditionalAddressModel?> item = Rxn();
  final Rxn<String?> title = Rxn();

  final Rxn<String?> addressType = Rxn();
  final Rxn<String?> addressTypeErr = Rxn();

  final Rxn<String?> titleType = Rxn();
  final Rxn<String?> titleTypeErr = Rxn();

  final Rxn<String?> state = Rxn();
  final Rxn<String?> stateErr = Rxn();

  final Rxn<String?> country = Rxn();
  final Rxn<String?> countryErr = Rxn();

  final Rx<TextEditingController> contactNameCtr = Rx(TextEditingController());
  final Rxn<String?> contactNameErr = Rxn();

  final Rx<TextEditingController> streetAddressCtr = Rx(TextEditingController());
  final Rxn<String?> streetAddressErr = Rxn();

  final Rx<TextEditingController> postalCodeCtr = Rx(TextEditingController());
  final Rxn<String?> postalCodeErr = Rxn();

  final Rx<TextEditingController> phoneNumberCtr = Rx(TextEditingController());
  final Rxn<String?> phoneNumberErr = Rxn();

  final Rx<TextEditingController> cityCtr = Rx(TextEditingController());
  final Rxn<String?> cityErr = Rxn();

  final Rx<TextEditingController> jobPositionCtr = Rx(TextEditingController());
  final Rx<TextEditingController> emailCtr = Rx(TextEditingController());

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void initial({AdditionalAddressModel? v, required String titleValue}) {
    item.value = v;
    title.value = titleValue;
    if (v != null) {
      addressType.value = v.addressType.toShortString();
      titleType.value = v.title.toShortString();
      contactNameCtr.value.text = v.contactName;
      jobPositionCtr.value.text = v.jobPosition ?? '';
      emailCtr.value.text = v.email ?? '';
      cityCtr.value.text = v.city ?? '';
      state.value = v.state;
      country.value = v.country;
      streetAddressCtr.value.text = v.streetAddress ?? '';
      postalCodeCtr.value.text = v.postalCode ?? '';
      phoneNumberCtr.value.text = v.phoneNumber;
    }
  }

  void onSubmit() {
    bool next = true;

    addressTypeErr.value;
    if (addressType.value == null) {
      addressTypeErr.value = 'Field is required';
      next = false;
    }

    titleTypeErr.value;
    if (titleType.value == null) {
      titleTypeErr.value = 'Field is required';
      next = false;
    }

    contactNameErr.value;
    if (contactNameCtr.value.text.isEmpty) {
      contactNameErr.value = 'Field is required';
      next = false;
    }

    phoneNumberErr.value;
    if (phoneNumberCtr.value.text.isEmpty) {
      phoneNumberErr.value = 'Field is required';
      next = false;
    }

    cityErr.value = null;
    stateErr.value = null;
    countryErr.value = null;
    streetAddressErr.value = null;
    postalCodeErr.value = null;
    if (addressType.value != null && addressType.value != AddressType.contact.toShortString()) {
      if (cityCtr.value.text.isEmpty) {
        cityErr.value = 'Field is required';
        next = false;
      }
      if (state.value == null) {
        stateErr.value = 'Field is required';
        next = false;
      }
      if (country.value == null) {
        countryErr.value = 'Field is required';
        next = false;
      }
      if (streetAddressCtr.value.text.isEmpty) {
        streetAddressErr.value = 'Field is required';
        next = false;
      }
      if (postalCodeCtr.value.text.isEmpty) {
        postalCodeErr.value = 'Field is required';
        next = false;
      }
    }

    if (!next) return;
    if (item.value != null) {
      final editItem = item.value!.copyWith(
        addressType: AddressTypeExtension.fromString(addressType.value!),
        title: TitleTypeExtension.fromString(titleType.value!),
        contactName: contactNameCtr.value.text,
        jobPosition: jobPositionCtr.value.text.isEmpty ? null : jobPositionCtr.value.text,
        email: emailCtr.value.text.isEmpty ? null : emailCtr.value.text,
        phoneNumber: phoneNumberCtr.value.text,
        city: cityCtr.value.text,
        state: state.value,
        country: country.value,
        streetAddress: streetAddressCtr.value.text.isEmpty ? null : streetAddressCtr.value.text,
        postalCode: postalCodeCtr.value.text.isEmpty ? null : postalCodeCtr.value.text,
      );
      Get.back(result: editItem);
    } else {
      final addItem = AdditionalAddressModel(
        id: Random().nextInt(999999),
        addressType: AddressTypeExtension.fromString(addressType.value!),
        title: TitleTypeExtension.fromString(titleType.value!),
        contactName: contactNameCtr.value.text,
        jobPosition: jobPositionCtr.value.text.isEmpty ? null : jobPositionCtr.value.text,
        email: emailCtr.value.text.isEmpty ? null : emailCtr.value.text,
        phoneNumber: phoneNumberCtr.value.text,
        city: cityCtr.value.text,
        state: state.value,
        country: country.value,
        streetAddress: streetAddressCtr.value.text.isEmpty ? null : streetAddressCtr.value.text,
        postalCode: postalCodeCtr.value.text.isEmpty ? null : postalCodeCtr.value.text,
      );

      Get.back(result: addItem);
    }
  }
}
