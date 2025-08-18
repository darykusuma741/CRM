import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/common/constants/image_assets.dart';
import 'package:crm/presentation/home/controllers/home.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeProfileHeader extends GetView<HomeController> {
  const HomeProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    double paddingTop = MediaQuery.of(context).padding.top;
    double height = paddingTop + 126.h;

    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: height,
          child: Image.asset(
            ImageAssets.homeBgProfile,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 2.h),
              Container(
                height: 48.w,
                width: 48.w,
                decoration: BoxDecoration(color: ColorsName.beigeCream, borderRadius: BorderRadius.circular(100.r)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.r),
                  child: Image.network(
                    'https://www.georgetown.edu/wp-content/uploads/2022/02/Jkramerheadshot-scaled-e1645036825432-1050x1050-c-default.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Text('Melina Jasmine Alayana', style: BaseText.white.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w500)),
              SizedBox(height: 2.h),
              Text('Sales Executive', style: BaseText.white.copyWith(fontSize: 11.sp, fontWeight: FontWeight.w300)),
            ],
          ),
        ),
      ],
    );
  }
}
