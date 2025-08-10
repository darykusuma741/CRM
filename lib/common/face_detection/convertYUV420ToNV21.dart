import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';

Uint8List convertYUV420ToNV21(CameraImage image) {
  final int width = image.width;
  final int height = image.height;
  final int uvRowStride = image.planes[1].bytesPerRow;
  final int uvPixelStride = image.planes[1].bytesPerPixel!;

  final Uint8List nv21 = Uint8List(width * height * 3 ~/ 2);

  // Copy Y
  int pos = 0;
  for (int i = 0; i < height; i++) {
    nv21.setRange(pos, pos + width, image.planes[0].bytes, i * image.planes[0].bytesPerRow);
    pos += width;
  }

  // U and V are swapped, so we need to interleave them in NV21 order (VU)
  for (int i = 0; i < height ~/ 2; i++) {
    for (int j = 0; j < width ~/ 2; j++) {
      final int uvIndex = i * uvRowStride + j * uvPixelStride;
      nv21[pos++] = image.planes[2].bytes[uvIndex]; // V
      nv21[pos++] = image.planes[1].bytes[uvIndex]; // U
    }
  }

  return nv21;
}
