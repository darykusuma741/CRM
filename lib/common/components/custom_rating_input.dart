import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/image_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomRatingInput extends StatelessWidget {
  const CustomRatingInput({
    super.key,
    required this.count,
    this.max = 3,
    this.label,
    this.required = true,
    this.onTap,
  });
  final int count;
  final int max;
  final bool required;
  final String? label;
  final void Function(int v)? onTap;

  @override
  Widget build(BuildContext context) {
    final labelStyle = BaseText.blueMuted.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w400);
    final requiredStyle = BaseText.redCherry.copyWith(fontSize: 12.sp);

    return Column(
      children: [
        if (label != null)
          Row(
            children: [
              Text(label!, style: labelStyle),
              if (required) Text(' *', style: requiredStyle),
            ],
          ),
        if (label != null) SizedBox(height: 5.h),
        Row(
          spacing: 2.w,
          children: List.generate(
            max,
            (index) {
              return InkWell(
                onTap: () {
                  if (count == (index + 1)) {
                    if (count < 0) {
                      onTap?.call(0);
                    } else {
                      onTap?.call(index);
                    }
                  } else {
                    onTap?.call(index + 1);
                  }
                },
                child: SvgPicture.asset(
                  count <= index ? ImageAssets.iconSvgStarGray : ImageAssets.iconSvgStar,
                  width: 25.59935760498047.w,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
