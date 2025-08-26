import 'package:crm/common/components/custom_scaffold.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/quotations.controller.dart';

class QuotationsScreen extends GetView<QuotationsController> {
  const QuotationsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        title: 'Quotations',
      ),
      backgroundColor: ColorsName.white,
      body: const Center(
        child: Text(
          'Page is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
