import 'package:crm/common/constants/image_assets.dart';
import 'package:crm/presentation/home/controllers/home.controller.dart';
import 'package:crm/presentation/home/main/header/home.main.header.profile.dart';
import 'package:crm/presentation/home/main/header/home.main.header.sales_overview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeMainHeader extends GetView<HomeController> {
  const HomeMainHeader({super.key});

  @override
  Widget build(BuildContext context) {
    double paddingTop = MediaQuery.of(context).padding.top;
    double height = paddingTop + 151.h;
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: height,
          child: Image.asset(ImageAssets.homeBg1, fit: BoxFit.cover),
        ),
        Container(
          width: double.infinity,
          height: height,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: paddingTop + 16.h),
              HomeMainHeaderProfile(),
              SizedBox(height: 20.h),
              HomeMainHeaderSalesOverview(),
            ],
          ),
        ),
      ],
    );
  }
}
