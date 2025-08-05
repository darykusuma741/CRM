import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomLoadingController extends GetxController with GetSingleTickerProviderStateMixin {
  late Rx<AnimationController> ctrAnim = Rx(AnimationController(
    duration: const Duration(milliseconds: 600),
    vsync: this,
  ));
  // ..repeat(reverse: true);
  final Rx<bool> isLoading = Rx(false);

  void setTrue() => isLoading.value = true;
  void setFalse() => isLoading.value = false;
}
