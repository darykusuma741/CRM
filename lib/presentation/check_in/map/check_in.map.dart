import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:crm/presentation/check_in/controllers/check_in.controller.dart';
import 'package:crm/presentation/check_in/form_location/check_in.form_location.dart';

class CheckInMap extends GetView<CheckInController> {
  const CheckInMap({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
              child: GoogleMap(
                initialCameraPosition: controller.initialCameraPosition.value,
                onMapCreated: controller.onMapCreated,
                markers: Set<Marker>.of(controller.markers.value.values),
              ),
            ),
            // 👇 Animated Container (appear from bottom)
            CheckInFormLocation(),
          ],
        ),
      );
    });
  }
}
