import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:crm/common/components/custom_scaffold.dart';
import 'package:crm/presentation/face_scan/button/face_scan.button.dart';
import 'package:crm/presentation/face_scan/navigation/face_scan.navigation.dart';
import 'dart:math' as math;
import 'controllers/face_scan.controller.dart';

class FaceScanScreen extends GetView<FaceScanController> {
  const FaceScanScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return CustomScaffold(
        backgroundColor: Colors.black,
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              if (controller.cameraController.value?.value.previewSize != null && controller.picture.value == null)
                Positioned.fill(
                  child: Transform(
                    alignment: Alignment.center,
                    transform: controller.frontCamera.value ? Matrix4.rotationY(math.pi) : Matrix4.rotationY(0), // mirror front camera
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: controller.cameraController.value!.value.previewSize!.height,
                        height: controller.cameraController.value!.value.previewSize!.width,
                        child: CameraPreview(controller.cameraController.value!),
                      ),
                    ),
                  ),
                ),
              // if (controller.picture.value != null)
              //   SizedBox(
              //     width: double.infinity,
              //     height: double.infinity,
              //     child: Image.file(
              //       File(controller.picture.value!.path),
              //       fit: BoxFit.cover,
              //     ),
              //   ),
              // Center(
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Text(
              //         controller.isDetecting.value ? 'Terdeteksi' : 'Tidak Terdeteksi',
              //         style: TextStyle(color: Colors.red, fontSize: 30.0),
              //       ),
              //       // if (controller.complete.value != null)
              //       Text(
              //         status,
              //         style: TextStyle(color: Colors.red, fontSize: 30.0),
              //       ),
              //     ],
              //   ),
              // ),
              FaceScanNavigation(),
              FaceScanButton(),
            ],
          ),
        ),
      );
    });
  }
}
