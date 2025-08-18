import 'package:crm/common/components/custom_scaffold.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/customer.controller.dart';

class CustomerScreen extends GetView<CustomerController> {
  const CustomerScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        title: 'Customer',
      ),
      backgroundColor: ColorsName.white,
      body: const Center(
        child: Text(
          'CustomerScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
