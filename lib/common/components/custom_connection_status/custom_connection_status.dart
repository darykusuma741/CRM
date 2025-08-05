import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:crm/common/components/custom_connection_status/custom_connection_status.controller.dart';
import 'package:crm/common/constants/base_text.dart';

class CustomConnectionStatus extends GetView<CustomConnectionStatusController> {
  const CustomConnectionStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.status.value == null) return const SizedBox.shrink();
      final paddingBottom = MediaQuery.of(context).padding.bottom;
      return Align(
        alignment: Alignment.bottomCenter,
        child: SlideTransition(
          position: controller.slideAnimation,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            width: double.infinity,
            padding: EdgeInsets.only(bottom: paddingBottom < 10 ? 10.0 : paddingBottom, top: 10.0),
            // margin: EdgeInsets.only(bottom: 12.h),
            decoration: BoxDecoration(color: controller.connected.value ? Colors.green : Colors.grey),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(controller.connected.value ? Icons.signal_wifi_4_bar : Icons.signal_wifi_connected_no_internet_4, color: Colors.white, size: 18),
                SizedBox(width: 6.w),
                Text(
                  controller.connected.value ? 'reconnect to the internet' : controller.status.value!,
                  style: BaseText.white.copyWith(fontSize: 11.sp, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
