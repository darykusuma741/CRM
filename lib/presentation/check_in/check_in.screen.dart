import 'package:crm/common/components/custom_scaffold.dart';
import 'package:crm/presentation/check_in/map/check_in.map.dart';
import 'package:crm/presentation/check_in/navigation/check_in.navigation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/check_in.controller.dart';

class CheckInScreen extends GetView<CheckInController> {
  const CheckInScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      // backgroundColor: Colors.orange,
      body: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            CheckInMap(),
            CheckInNavigation(),
          ],
        ),
      ),
    );
  }
}
