import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/common/constants/image_assets.dart';

class CustomErrorText extends StatelessWidget {
  const CustomErrorText({super.key, required this.error});
  final String? error;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 5.h),
        Row(
          children: [
            SvgPicture.asset(
              height: 10.h,
              ImageAssets.iconSvgInfo,
              colorFilter: ColorFilter.mode(ColorsName.redTomato, BlendMode.srcIn),
            ),
            SizedBox(width: 4.w),
            Expanded(
              child: Text(
                error ?? 'Error',
                style: BaseText.redTomato.copyWith(fontSize: 11.sp),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        )
      ],
    );
  }
}
