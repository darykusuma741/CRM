import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/face_scan.controller.dart';

class FaceScanScreen extends GetView<FaceScanController> {
  const FaceScanScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FaceScanScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'FaceScanScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
