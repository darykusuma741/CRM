import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/common/constants/image_assets.dart';
import 'package:crm/presentation/check_in/controllers/check_in.controller.dart';

class CheckInNavigation extends GetView<CheckInController> {
  const CheckInNavigation({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: Column(
        children: [
          SizedBox(height: 34.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: controller.onTapBack,
                child: Container(
                  width: 32.w,
                  height: 32.h,
                  decoration: BoxDecoration(color: ColorsName.white, borderRadius: BorderRadius.circular(100.r)),
                  child: Center(child: SvgPicture.asset(ImageAssets.iconSvgArrowLeftBlack, width: 16.w)),
                ),
              ),
              GestureDetector(
                onTap: controller.onTapGetMyLocation,
                child: Container(
                  width: 32.w,
                  height: 32.h,
                  decoration: BoxDecoration(color: ColorsName.white, borderRadius: BorderRadius.circular(100.r)),
                  child: Center(child: SvgPicture.asset(ImageAssets.iconSvgMyLocation, width: 16.w)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
