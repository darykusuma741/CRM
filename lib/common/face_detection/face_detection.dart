// ignore_for_file: avoid_print

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:crm/common/face_detection/convertYUV420ToNV21.dart';

class FaceDetection {
  final CameraController cameraController;
  bool _isDetecting = false;
  bool _isFaceDetecting = false;
  bool _isWinkDetecting = false;
  bool _isSmileDetecting = false;
  bool _isFaceRightDetecting = false;
  bool _isFaceLeftDetecting = false;
  late FaceDetector _faceDetector;
  Function(bool value) faceDetection;
  Function(bool value) winkDetection;
  Function(bool value) smileDetection;
  Function(bool value) faceRightDetection;
  Function(bool value) faceLeftDetection;
  Function(bool value) faceCompleteDetection;

  FaceDetection({
    required this.cameraController,
    required this.faceDetection,
    required this.winkDetection,
    required this.smileDetection,
    required this.faceRightDetection,
    required this.faceLeftDetection,
    required this.faceCompleteDetection,
  });

  Future initial() async {
    final permissionStatus = await Permission.camera.request();
    final permissionMediaStatus = await Permission.mediaLibrary.request();
    if (!permissionStatus.isGranted) {
      print("Izin kamera ditolak!");
      return;
    }
    if (!permissionMediaStatus.isGranted) {
      print("Izin media ditolak!");
      return;
    }
    _faceDetector = FaceDetector(
      options: FaceDetectorOptions(
        enableClassification: true,
        enableLandmarks: true,
        enableContours: false,
        enableTracking: false,
      ),
    );

    print("Kamera: ${cameraController.description}");
    print("Sensor orientation: ${cameraController.description.sensorOrientation}");

    await cameraController.startImageStream(_processCameraImage);
  }

  Future<void> _processCameraImage(CameraImage image) async {
    if (_isDetecting) return;
    _isDetecting = true;

    try {
      // Gabungkan semua bytes dari planes
      final allBytes = WriteBuffer();
      for (final plane in image.planes) {
        allBytes.putUint8List(plane.bytes);
      }

      final nv21Bytes = convertYUV420ToNV21(image);
      // Buat metadata input image
      final inputImage = InputImage.fromBytes(
        bytes: nv21Bytes,
        metadata: InputImageMetadata(
          size: Size(image.width.toDouble(), image.height.toDouble()),
          rotation: _rotationIntToImageRotation(cameraController.description.sensorOrientation),
          format: InputImageFormat.nv21,
          bytesPerRow: image.planes[0].bytesPerRow,
        ),
      );

      final faces = await _faceDetector.processImage(inputImage);

      if (faces.isEmpty) {
        _falseEntry();
      } else {
        _evaluateFace(faces.first);
      }
    } catch (e) {
      print('Error saat proses image: $e');
    }

    _isDetecting = false;
  }

  close() async {
    await _faceDetector.close();
  }

  _falseEntry() {
    faceDetection(false);
    winkDetection(false);
    smileDetection(false);
    faceRightDetection(false);
    faceLeftDetection(false);
    _isFaceDetecting = false;
    _isWinkDetecting = false;
    _isSmileDetecting = false;
    _isFaceRightDetecting = false;
    _isFaceLeftDetecting = false;
    faceCompleteDetection(false);
  }

  InputImageRotation _rotationIntToImageRotation(int rotation) {
    switch (rotation) {
      case 0:
        return InputImageRotation.rotation0deg;
      case 90:
        return InputImageRotation.rotation90deg;
      case 180:
        return InputImageRotation.rotation180deg;
      case 270:
        return InputImageRotation.rotation270deg;
      default:
        throw Exception("Rotasi kamera tidak valid: $rotation");
    }
  }

  void _evaluateFace(Face face) {
    final yaw = face.headEulerAngleY ?? 0;
    final smile = face.smilingProbability ?? 0;
    final leftEye = face.leftEyeOpenProbability ?? 1;
    final rightEye = face.rightEyeOpenProbability ?? 1;

    if (yaw > 15) {
      faceLeftDetection(true);
      _isFaceLeftDetecting = true;
    } else if (yaw < -15) {
      faceRightDetection(true);
      _isFaceRightDetecting = true;
    } else if (smile > 0.6) {
      smileDetection(true);
      _isSmileDetecting = true;
    } else if (leftEye < 0.7 && rightEye < 0.7) {
      winkDetection(true);
      _isWinkDetecting = true;
    } else {
      faceDetection(true);
      _isFaceDetecting = true;
    }
    faceCompleteDetection(_isFaceDetecting && _isWinkDetecting && _isSmileDetecting && _isFaceRightDetecting && _isFaceLeftDetecting);
  }
}
