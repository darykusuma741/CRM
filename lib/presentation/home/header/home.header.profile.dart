import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/presentation/home/controllers/home.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeHeaderProfile extends GetView<HomeController> {
  const HomeHeaderProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 36.w,
          width: 36.w,
          decoration: BoxDecoration(color: ColorsName.beigeCream, borderRadius: BorderRadius.circular(100.r)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100.r),
            child: Image.network(
              'https://www.georgetown.edu/wp-content/uploads/2022/02/Jkramerheadshot-scaled-e1645036825432-1050x1050-c-default.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Hi, ', style: BaseText.white.copyWith(fontSize: 13.sp, fontWeight: BaseText.regular)),
                Text('Melina', style: BaseText.white.copyWith(fontSize: 13.sp, fontWeight: BaseText.semiBold)),
              ],
            ),
            SizedBox(height: 2.h),
            Text('Sales Executive', style: BaseText.grayMedium.copyWith(fontSize: 12.sp, fontWeight: BaseText.light)),
          ],
        )
      ],
    );
  }
}
