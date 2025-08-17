import 'package:crm/common/constants/image_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomRating extends StatelessWidget {
  const CustomRating({super.key, required this.count});
  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 2.w,
      children: List.generate(
        count,
        (index) => SvgPicture.asset(
          ImageAssets.iconSvgStar,
          width: 14.93.w,
        ),
      ),
    );
  }
}
