import 'package:crm/common/components/custom_scaffold.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/customer_detail.controller.dart';

class CustomerDetailScreen extends GetView<CustomerDetailController> {
  const CustomerDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(title: 'Customer Detail'),
      body: const Center(
        child: Text(
          'CustomerDetailScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
