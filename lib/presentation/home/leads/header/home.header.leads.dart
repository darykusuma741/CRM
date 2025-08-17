import 'package:crm/common/components/custom_gradient_text.dart';
import 'package:crm/common/components/custom_text_editing.dart';
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
    double height = paddingTop + 96.h;

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
              Expanded(child: Container()),
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
              SizedBox(height: 12.h),
              CustomTextEditing(
                onChanged: (v) {
                  controller.searchLeads(v);
                },
                hint: 'Search your leads name...',
                borderRadius: BorderRadius.circular(100.r),
                borderSide: BorderSide(width: 0.0),
                prefixIcon: Container(
                  // color: Colors.amber,
                  padding: EdgeInsets.only(right: 6.w, left: 12.w, top: 10.h, bottom: 10.h),
                  child: SvgPicture.asset(ImageAssets.iconSvgSearch, width: 14.w),
                ),
              ),
              SizedBox(height: 14.h),
            ],
          ),
        ),
      ],
    );
  }
}
