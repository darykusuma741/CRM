import 'dart:math';

import 'package:crm/common/components/custom_modal_bottom.dart';
import 'package:crm/common/helper/my_snack_bar.dart';
import 'package:crm/controller/customer.main.controller.dart';
import 'package:crm/data/enum/transport_by.dart';
import 'package:crm/data/model/marking.model.dart';
import 'package:crm/presentation/customer/controllers/customer.controller.dart';
import 'package:crm/presentation/customer_detail/controllers/customer_detail.controller.dart';
import 'package:crm/presentation/marking_detail/detail/marking_detail.detail.dart';
import 'package:crm/presentation/marking_detail/form/marking_detail.form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MarkingDetailController extends GetxController {
  Rx<List<MarkingModel>> markings = Rx(Get.arguments ?? []);
  Rx<List<MarkingModel>> markingsFix = Rx(Get.arguments ?? []);
  Rxn<String?> transportBy = Rxn();

  Rx<List<String>> selectTransportBy = Rx([]);
  Rxn<String?> selectTransportByErr = Rxn();

  Rx<TextEditingController> markingNameCtr = Rx(TextEditingController());
  Rxn<String?> markingNameErr = Rxn();

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

  void onClickAddMarking() {
    markingNameErr.value = null;
    selectTransportByErr.value = null;
    markingNameCtr.value.text = "";
    selectTransportBy.value = [];
    customModalBottom(MarkingDetailForm());
  }

  void onChangeTrBy(String? v) {
    transportBy.value = v;
    final markingsC = markings.value.where((e) {
      if (v == null) {
        return true;
      } else {
        return e.transportBy == TransportByExtension.fromString(v);
      }
    }).toList();
    markingsFix.value = markingsC;
  }

  void onClickDetail(MarkingModel item) {
    customModalBottom(MarkingDetailDetail(item: item));
  }

  void onClickEdit(MarkingModel item) {
    markingNameErr.value = null;
    selectTransportByErr.value = null;
    markingNameCtr.value.text = item.markingName;
    selectTransportBy.value = [];
    if (item.transportBy.isAll) {
      selectTransportBy.value = [TransportBy.air.toShortString(), TransportBy.ocean.toShortString()];
    } else if (item.transportBy.isOcean) {
      selectTransportBy.value = [TransportBy.ocean.toShortString()];
    } else {
      selectTransportBy.value = [TransportBy.air.toShortString()];
    }
    customModalBottom(MarkingDetailForm(item: item));
  }

  void onSubmit(MarkingModel? item) {
    bool next = true;

    markingNameErr.value = null;
    if (markingNameCtr.value.text.isEmpty) {
      markingNameErr.value = "Field is required";
      next = false;
    } else {
      if (markingNameCtr.value.text.toLowerCase() != (item?.markingName ?? '').toLowerCase()) {
        final exists = markings.value.where((e) => e.markingName.toLowerCase() == markingNameCtr.value.text.toLowerCase()).toList();
        if (exists.isNotEmpty) {
          markingNameErr.value = 'Marking already used. Type a unique name.';
          next = false;
        }
      }
    }

    selectTransportByErr.value = null;
    if (selectTransportBy.value.isEmpty) {
      selectTransportByErr.value = "Field is required";
      next = false;
    }

    if (!next) return;

    final trBy = selectTransportBy.value.length > 1
        ? TransportBy.all
        : selectTransportBy.value.contains(TransportBy.air.toShortString())
            ? TransportBy.air
            : TransportBy.ocean;

    if (item == null) {
      markings.value = [
        MarkingModel(
          id: Random().nextInt(999999),
          markingName: markingNameCtr.value.text,
          transportBy: trBy,
        ),
        ...markings.value,
      ];
    } else {
      final existing = [...markings.value];
      final index = existing.indexWhere((e) => e.id == item.id);
      if (index >= 0) {
        existing[index] = item.copyWith(
          markingName: markingNameCtr.value.text,
          transportBy: trBy,
        );
        markings.value = existing;
      }
    }
    final markingsC = markings.value.where((e) {
      if (transportBy.value == null) {
        return true;
      } else {
        return e.transportBy == TransportByExtension.fromString(transportBy.value!);
      }
    }).toList();
    markingsFix.value = markingsC;

    CustomerDetailController ctrCustomerDetail = Get.find<CustomerDetailController>();
    CustomerMainController ctrCustomerMain = Get.find<CustomerMainController>();
    CustomerController ctrCustomer = Get.find<CustomerController>();

    ctrCustomerDetail.item.value = ctrCustomerDetail.item.value.copyWith(markings: [...markings.value]);
    ctrCustomerMain.editData(ctrCustomerDetail.item.value);
    ctrCustomer.getData();

    Get.back();

    if (item == null) {
      MySnackBar.success(Get.context!, title: 'Marking Added!', subTitle: 'You’ve successfully created a new marking.');
    } else {
      MySnackBar.success(Get.context!, title: 'Marking Updated!', subTitle: 'You’ve successfully updated the marking.');
    }
  }
}
