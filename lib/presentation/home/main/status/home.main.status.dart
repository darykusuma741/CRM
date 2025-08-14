import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/presentation/home/controllers/home.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeMainStatus extends GetView<HomeController> {
  const HomeMainStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        scrollDirection: Axis.horizontal,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8.w,
            children: [
              HomeMainStatusItem(
                title: 'Overdues',
                count: 4,
                color: ColorsName.redLightSoft,
                borderColor: ColorsName.pinkPale,
                style: BaseText.redLight,
              ),
              HomeMainStatusItem(
                title: 'Planned',
                count: 12,
                color: ColorsName.blueUltraSoft,
                borderColor: ColorsName.bluePastelLight,
                style: BaseText.blueOceanDeep,
              ),
              HomeMainStatusItem(
                title: 'Completed',
                count: 12,
                color: ColorsName.greenUltraSoft,
                borderColor: ColorsName.greenMintSoft,
                style: BaseText.greenPrimary,
              ),
              HomeMainStatusItem(
                title: 'Cancelled',
                count: 12,
                color: ColorsName.beigeLight,
                borderColor: ColorsName.beigePastel,
                style: BaseText.yellowBright,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeMainStatusItem extends StatelessWidget {
  const HomeMainStatusItem({super.key, required this.title, required this.count, required this.borderColor, required this.color, required this.style});
  final String title;
  final int count;
  final Color borderColor;
  final Color color;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Row(
        children: [
          Text(title, style: style.copyWith(fontSize: 11.sp)),
          SizedBox(width: 20.w),
          Text(count.toString(), style: style.copyWith(fontSize: 11.sp, fontWeight: FontWeight.w300)),
        ],
      ),
    );
  }
}
