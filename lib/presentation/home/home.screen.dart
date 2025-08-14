import 'package:crm/common/components/custom_scaffold.dart';
import 'package:crm/presentation/home/bottom_nav/home.bottom_nav.dart';
import 'package:crm/presentation/home/leads/home.leads.dart';
import 'package:crm/presentation/home/main/home.main.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/home.controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    List widgetBody = [
      HomeMain(),
      HomeLeads(),
      Container(),
      Container(),
    ];

    return Obx(() {
      return CustomScaffold(
        light: true,
        bottomNavigationBar: HomeBottomNav(),
        body: widgetBody[controller.selectedIndexWidget.value],
      );
    });
  }
}
