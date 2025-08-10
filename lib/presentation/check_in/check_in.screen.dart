import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/check_in.controller.dart';

class CheckInScreen extends GetView<CheckInController> {
  const CheckInScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CheckInScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CheckInScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
