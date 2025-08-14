import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/common/constants/image_assets.dart';
import 'package:crm/presentation/home/controllers/home.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HomeBottomNav extends GetView<HomeController> {
  const HomeBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        height: 56.h + MediaQuery.of(context).padding.bottom, // tinggi total bottom nav
        decoration: BoxDecoration(
          color: ColorsName.white,
          boxShadow: [
            BoxShadow(
              color: ColorsName.grayDarkest.withOpacity(0.08),
              offset: Offset(0.0, 0.44),
              blurRadius: 10.0,
            ),
            BoxShadow(
              color: ColorsName.grayDarkest.withOpacity(0.05),
              offset: Offset(0.0, 2.0),
              blurRadius: 5.0,
              spreadRadius: 1.32,
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: controller.selectedIndexWidget.value,
          onTap: (v) => controller.selectedIndexWidget.value = v,
          elevation: 0, // matikan shadow bawaan
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: ColorsName.blueSteel,
          unselectedItemColor: ColorsName.graySoftMedium,
          selectedLabelStyle: BaseText.blueSteel.copyWith(fontSize: 11.sp, fontWeight: FontWeight.w500),
          unselectedLabelStyle: BaseText.graySoftMedium.copyWith(fontSize: 11.sp, fontWeight: FontWeight.w300),
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(ImageAssets.iconSvgHomeWhite, width: 24.w),
              activeIcon: SvgPicture.asset(ImageAssets.iconSvgHome1, width: 24.w),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(ImageAssets.iconSvgLeadsWhite, width: 24.w),
              activeIcon: SvgPicture.asset(ImageAssets.iconSvgLeads1, width: 24.w),
              label: "Leads",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(ImageAssets.iconSvgCalendarWhite, width: 24.w),
              activeIcon: SvgPicture.asset(ImageAssets.iconSvgCalendar1, width: 24.w),
              label: "Calendar",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(ImageAssets.iconSvgProfileWhite, width: 24.w),
              activeIcon: SvgPicture.asset(ImageAssets.iconSvgProfile1, width: 24.w),
              label: "Profile",
            ),
          ],
        ),
      );
    });
  }
}
