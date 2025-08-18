import 'package:crm/common/components/custom_scaffold.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/freight_product.controller.dart';

class FreightProductScreen extends GetView<FreightProductController> {
  const FreightProductScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        title: 'Freight Product',
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
