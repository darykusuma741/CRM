import 'package:crm/common/components/custom_gradient_text.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/image_assets.dart';
import 'package:crm/presentation/home/controllers/home.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HomeHeaderLeads extends GetView<HomeController> {
  const HomeHeaderLeads({super.key});

  @override
  Widget build(BuildContext context) {
    double paddingTop = MediaQuery.of(context).padding.top;
    double height = paddingTop + 120.h;

    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: height,
          child: SvgPicture.asset(ImageAssets.homeBg2, fit: BoxFit.cover),
        ),
        Container(
          width: double.infinity,
          height: height,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: paddingTop + 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('My Leads', style: BaseText.white.copyWith(fontSize: 16.sp)),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF2E7ACB).withOpacity(0.2), // warna shadow
                          offset: const Offset(0, 1), // x = 0, y = 1
                          blurRadius: 12.r, // radius blur
                          spreadRadius: 0, // sesuai CSS
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        CustomGradientText(text: 'See My Pipeline', style: BaseText.white.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w500)),
                        SizedBox(width: 3.5.w),
                        SvgPicture.asset(ImageAssets.iconSvgChevronRightGradient, height: 8.h),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
