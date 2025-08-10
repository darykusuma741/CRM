import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crm/common/components/custom_calendar_text/custom_calendar_dialog.dart';

class CustomCalendarTextController extends GetxController {
  final Rxn<DateTime?> startDate = Rxn();
  final Rxn<DateTime?> endDate = Rxn();
  final Rx<String> by = Rx('Date');
  final Rx<bool> multipleDate = Rx(false);
  final Rx<Function(DateTime? start, DateTime? end)> onSubmit = Rx((s, v) {});
  final Rx<DateTime> focusedDay = Rx(DateTime.now());

  void handleOnTap() async {
    await showDialog(
      context: Get.context!,
      builder: (context) {
        return CustomCalendarDialog();
      },
    );
  }

  void onDaySelected(DateTime selected, DateTime focused) {
    if (startDate.value == null) {
      startDate.value = selected;
      startDate.update((e) {});
    } else if (!multipleDate.value) {
      startDate.value = selected;
      startDate.update((e) {});
    } else if (endDate.value == null) {
      if (selected.difference(startDate.value!).inDays > 0) {
        endDate.value = selected;
      } else {
        startDate.value = selected;
      }
    } else {
      startDate.value = selected;
      endDate.value = null;
    }

    if (startDate.value != null) {
      focusedDay.value = startDate.value!;
    }
  }

  void onHeaderTapped(DateTime v) {
    by.value = 'Month';
  }
}
