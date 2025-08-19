// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/common/constants/image_assets.dart';

class CustomFloatingActionContainer extends StatelessWidget {
  const CustomFloatingActionContainer({super.key, required this.onTap, this.shadow = true});
  final void Function() onTap;
  final bool shadow;

  @override
  Widget build(BuildContext context) {
    final onHighlightChanged = false.obs;
    return Obx(
      () => InkWell(
        onTap: onTap,
        onHighlightChanged: (e) {
          onHighlightChanged.value = e;
        },
        splashColor: Colors.orange,
        borderRadius: BorderRadius.circular(100.0),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          width: 42.h,
          height: 42.w,
          padding: EdgeInsets.all(15.7.r),
          decoration: BoxDecoration(
            color: onHighlightChanged.value ? ColorsName.orangeBold : ColorsName.blueDeep,
            borderRadius: BorderRadius.circular(100.0),
            boxShadow: !shadow
                ? []
                : [
                    BoxShadow(
                      // ignore: use_full_hex_values_for_flutter_colors
                      color: Color(0xFF333A5133),
                      blurRadius: 38.1,
                      offset: Offset(0, 22.86),
                      spreadRadius: 0,
                    ),
                    // BoxShadow(
                    //   color: Color(0x40000000), // hitam dengan 25% opacity
                    //   blurRadius: 4,
                    //   offset: Offset(0, 4),
                    //   spreadRadius: 0,
                    // ),
                  ],
          ),
          child: SvgPicture.asset(
            ImageAssets.iconSvgAdd,
            colorFilter: ColorFilter.mode(ColorsName.white, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }
}
