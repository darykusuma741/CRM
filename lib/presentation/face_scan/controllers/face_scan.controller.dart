import 'dart:io';

import 'package:camera/camera.dart';
import 'package:crm/common/components/custom_loading/custom_loading.controller.dart';
import 'package:crm/common/face_detection/face_detection.dart';
import 'package:get/get.dart';

class FaceScanController extends GetxController {
  Rxn<CameraController?> cameraController = Rxn();
  Rxn<FaceDetection> faceDetection = Rxn();
  Rx<bool> isDetecting = Rx(false);
  Rx<bool> complete = Rx(false);
  Rx<bool> flashOn = Rx(false);

  Rx<bool> frontCamera = Rx(true);

  Rx<bool> isCaptured = Rx(false);
  Rx<bool> isFaceDetecting = Rx(false);
  Rx<bool> isWinkDetecting = Rx(false);
  Rx<bool> isSmileDetecting = Rx(false);
  Rx<bool> isFaceRightDetecting = Rx(false);
  Rx<bool> isFaceLeftDetecting = Rx(false);
  Rxn<XFile> picture = Rxn();

  final CustomLoadingController ctrLoading = Get.find<CustomLoadingController>();

  @override
  void onInit() {
    _init();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() async {
    cameraController.value?.removeListener;
    await cameraController.value?.dispose();
    super.onClose();
  }

  _init() async {
    try {
      // ctrLoading.isLoading.value = true;
      // untuk emulator front camera tidak tersedia
      // await toFrontCamera();
      await toBackCamera();
    } catch (e) {
      print('Error');
    } finally {
      // ctrLoading.isLoading.value = false;
    }
  }

  Future toFrontCamera() async {
    if (faceDetection.value != null) {
      faceDetection.value?.close();
    }
    await intialFaceDetection(front: true);
  }

  Future toBackCamera() async {
    if (faceDetection.value != null) {
      faceDetection.value?.close();
    }
    await intialFaceDetection(front: false);
  }

  onTapFlipCamera() async {
    try {
      ctrLoading.isLoading.value = true;
      await Future.delayed(Duration(seconds: 2));
      frontCamera.value = !frontCamera.value;
      flashOn.value = false;
      await cameraController.value!.setFlashMode(FlashMode.off);

      // await cameraController.value?.dispose();
      if (frontCamera.value) {
        await toFrontCamera();
      } else {
        await toBackCamera();
      }
    } catch (e) {
      print('Error');
    } finally {
      ctrLoading.isLoading.value = false;
    }
  }

  Future intialFaceDetection({required bool front}) async {
    final cameras = await availableCameras();
    final backCamera = cameras.firstWhere((cam) => cam.lensDirection == (front ? CameraLensDirection.front : CameraLensDirection.back));
    cameraController.value = CameraController(backCamera, ResolutionPreset.medium, enableAudio: false);
    await cameraController.value!.initialize();
    cameraController.update((fn) {});
    faceDetection.value = FaceDetection(
      cameraController: cameraController.value!,
      faceDetection: (value) {
        isFaceDetecting.value = value;
        if (!value) {
          isWinkDetecting.value = false;
          isSmileDetecting.value = false;
          isFaceRightDetecting.value = false;
          isFaceLeftDetecting.value = false;
        }
      },
      winkDetection: (value) {
        if (value) isWinkDetecting.value = true;
      },
      smileDetection: (value) {
        if (value) isSmileDetecting.value = true;
      },
      faceLeftDetection: (value) {
        if (value) isFaceLeftDetecting.value = true;
      },
      faceRightDetection: (value) {
        if (value) isFaceRightDetecting.value = true;
      },
      faceCompleteDetection: (value) async {
        complete.value = value;
      },
    );

    await faceDetection.value?.initial();
  }

  Future handleFlashMode() async {
    if (cameraController.value != null) {
      try {
        ctrLoading.isLoading.value = true;
        await cameraController.value!.setFlashMode(!flashOn.value ? FlashMode.torch : FlashMode.off);
        flashOn.value = !flashOn.value;
      } catch (e) {
        print(e);
      } finally {
        ctrLoading.isLoading.value = false;
      }
    }
  }

  Future onChapture() async {
    if (!complete.value) return;
    if (isCaptured.value) return;
    try {
      ctrLoading.isLoading.value = true;
      await cameraController.value!.stopImageStream();
      isCaptured.value = true;
      await Future.delayed(Duration(milliseconds: 2000));
      picture.value = await cameraController.value!.takePicture();
      // final inputSize = 112;
      // final inputTensor = await preprocessImage(picture.value!.path, inputSize);

      cameraController.value!.dispose();

      Get.back(result: File(picture.value!.path));
      print('Foto berhasil diambil: ${picture.value!.path}');
    } catch (e) {
      print('Gagal mengambil foto: $e');
    } finally {
      ctrLoading.isLoading.value = false;
    }
  }
}
