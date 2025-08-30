import 'package:camera/camera.dart';

class PhotoResult {
  final String label;
  final XFile photo;
  final bool withButton;
  final String? networkImageUrl;

  PhotoResult({required this.label, required this.photo, this.withButton = true, this.networkImageUrl});
}
