import 'package:crm/common/components/custom_divider.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/common/constants/image_assets.dart';
import 'package:crm/infrastructure/navigation/routes.dart';
import 'package:crm/presentation/home/controllers/home.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HomeProfileMenu extends GetView<HomeController> {
  const HomeProfileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('General', style: BaseText.grayCharcoal.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w500)),
          SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6.r)),
            child: Column(
              children: [
                HomeProfileMenuItem(
                  label: 'Customer',
                  icon: ImageAssets.iconSvgCustomer,
                  onTap: () {
                    Get.toNamed(Routes.CUSTOMER);
                  },
                ),
                Padding(padding: EdgeInsets.only(left: 38.w), child: CustomDivider()),
                HomeProfileMenuItem(
                  label: 'Product Services',
                  icon: ImageAssets.iconSvgProductServices,
                  onTap: () {
                    Get.toNamed(Routes.PRODUCT_SERVICE);
                  },
                ),
                Padding(padding: EdgeInsets.only(left: 38.w), child: CustomDivider()),
                HomeProfileMenuItem(
                  label: 'Freight Product',
                  icon: ImageAssets.iconSvgFreightProduct,
                  onTap: () {
                    Get.toNamed(Routes.FREIGHT_PRODUCT);
                  },
                ),
                Padding(padding: EdgeInsets.only(left: 38.w), child: CustomDivider()),
                HomeProfileMenuItem(
                  label: 'Product Category',
                  icon: ImageAssets.iconSvgProductCategory,
                  onTap: () {
                    Get.toNamed(Routes.PRODUCT_CATEGORY);
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Text('Sales', style: BaseText.grayCharcoal.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w500)),
          SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6.r)),
            child: Column(
              children: [
                HomeProfileMenuItem(
                  label: 'Quotations',
                  icon: ImageAssets.iconSvgQuotations,
                  onTap: () {
                    Get.toNamed(Routes.QUOTATIONS);
                  },
                ),
                Padding(padding: EdgeInsets.only(left: 38.w), child: CustomDivider()),
                HomeProfileMenuItem(label: 'Customer Lost', icon: ImageAssets.iconSvgCustomerLost),
                Padding(padding: EdgeInsets.only(left: 38.w), child: CustomDivider()),
                HomeProfileMenuItem(
                  label: 'Activity History',
                  icon: ImageAssets.iconSvgActivityHistory,
                  onTap: () {
                    Get.toNamed(Routes.ACTIVITY_HISTORY);
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6.r)),
            child: Column(
              children: [
                HomeProfileMenuItemLogout(
                  label: 'Logout',
                  onTap: () {
                    Get.offAllNamed(Routes.SPLASH_SCREEN);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomeProfileMenuItem extends StatelessWidget {
  const HomeProfileMenuItem({super.key, required this.label, required this.icon, this.onTap});
  final String label;
  final String icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          child: Row(
            children: [
              Container(
                width: 28.w,
                height: 28.w,
                decoration: BoxDecoration(
                  color: ColorsName.graySoftLight,
                  borderRadius: BorderRadius.circular(100.r),
                  border: Border.all(color: ColorsName.bluePastel.withOpacity(0.5)),
                ),
                child: Center(
                  child: SvgPicture.asset(icon, width: 14.w),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(child: Text(label, style: BaseText.grayCharcoal.copyWith(fontSize: 12.sp))),
              SizedBox(width: 15.73.w),
              SvgPicture.asset(ImageAssets.iconSvgArrowRight, height: 8.h)
            ],
          ),
        ),
      ),
    );
  }
}

class HomeProfileMenuItemLogout extends StatelessWidget {
  const HomeProfileMenuItemLogout({super.key, required this.label, this.onTap});
  final String label;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          child: Row(
            children: [
              Container(
                width: 28.w,
                height: 28.w,
                decoration: BoxDecoration(
                  color: ColorsName.graySoftLight,
                  borderRadius: BorderRadius.circular(100.r),
                  border: Border.all(color: ColorsName.bluePastel.withOpacity(0.5)),
                ),
                child: Center(
                  child: SvgPicture.asset(ImageAssets.iconSvgLogout, width: 14.w),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(child: Text(label, style: BaseText.grayCharcoal.copyWith(fontSize: 12.sp))),
              SizedBox(width: 15.73.w),
              Text(
                'App Version 2.0',
                style: BaseText.blueDust.copyWith(fontSize: 10.sp),
              )
            ],
          ),
        ),
      ),
    );
  }
}
