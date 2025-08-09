import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/document_activities.controller.dart';

class DocumentActivitiesScreen extends GetView<DocumentActivitiesController> {
  const DocumentActivitiesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DocumentActivitiesScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DocumentActivitiesScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
