import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/common/constants/image_assets.dart';
import 'package:crm/presentation/home/controllers/home.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeMainHeaderSalesOverview extends GetView<HomeController> {
  const HomeMainHeaderSalesOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Sales Overview', style: BaseText.white.copyWith(fontSize: 13.sp, letterSpacing: 0.0, height: 1.0, fontWeight: BaseText.light)),
              SizedBox(height: 4.h),
              Text('Rp 200.120.564.000', style: BaseText.white.copyWith(fontSize: 17.sp, letterSpacing: 0.0, fontWeight: BaseText.bold)),
              SizedBox(height: 6.h),
              Row(
                children: [
                  SvgPicture.asset(
                    ImageAssets.iconSvgTrendingUp,
                    width: 14.w,
                  ),
                  SizedBox(width: 4.w),
                  Text('18.3%', style: BaseText.greenPrimary.copyWith(fontSize: 11.sp, fontWeight: FontWeight.w400)),
                  SizedBox(width: 4.w),
                  Text('this month', style: BaseText.grayMedium.copyWith(fontSize: 11.sp, fontWeight: FontWeight.w400)),
                ],
              )
            ],
          ),
          InkWell(
            onTap: () {},
            child: Container(
              height: 25.h,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(color: ColorsName.white.withOpacity(0.1), borderRadius: BorderRadius.circular(100.r)),
              child: Row(
                children: [
                  SvgPicture.asset(ImageAssets.iconSvgCalendar, width: 8.w),
                  SizedBox(width: 4.w),
                  Text(
                    DateFormat('MMM yyyy').format(controller.initialDate.value),
                    style: BaseText.white.copyWith(fontSize: 10.sp, fontWeight: BaseText.regular),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
