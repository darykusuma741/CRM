import 'package:crm/common/components/custom_scaffold.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/activity_history.controller.dart';

class ActivityHistoryScreen extends GetView<ActivityHistoryController> {
  const ActivityHistoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        title: 'Activity History',
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
