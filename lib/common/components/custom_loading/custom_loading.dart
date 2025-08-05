import 'dart:ui';

import 'package:crm/common/components/custom_loading/custom_loading.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomLoading extends GetView<CustomLoadingController> {
  const CustomLoading({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      late Animation<double> d = Tween<double>(begin: 0.0, end: 3.0).animate(controller.ctrAnim.value);
      late Animation<double> o = Tween<double>(begin: 0.0, end: 0.2).animate(controller.ctrAnim.value);
      if (controller.isLoading.value) {
        controller.ctrAnim.value.forward();
      } else {
        controller.ctrAnim.value.reverse();
      }
      return PopScope(
        canPop: !controller.isLoading.value, // <-- ini kuncinya sekarang
        onPopInvokedWithResult: (bool didPop, dynamic result) {
          // dipanggil setelah pop, hanya untuk notifikasi saja
          debugPrint('Pop attempted. Success: $didPop');
        },
        child: AnimatedBuilder(
          animation: controller.ctrAnim.value,
          builder: (context, childs) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  child,
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: d.value, sigmaY: d.value),
                    child: d.value <= 0.0 ? Container() : Opacity(opacity: o.value, child: Container(color: Colors.black)),
                  ),
                  Center(child: d.value <= 0.0 ? Container() : CircularProgressIndicator(color: Colors.white)),
                ],
              ),
            );
          },
        ),
      );
    });
  }
}
