import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/common/constants/image_assets.dart';

class CustomCalendarForm extends StatelessWidget {
  const CustomCalendarForm({
    super.key,
    this.enabled = true,
    this.error,
    required this.hint,
    this.controller,
  });
  final bool enabled;
  final String? error;
  final String hint;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    final borderColor = !enabled
        ? ColorsName.grayPlatinum
        : error == null
            ? ColorsName.grayPearly
            : ColorsName.redTomato;
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.only(bottomRight: Radius.circular(8.r), topRight: Radius.circular(8.r)),
      borderSide: BorderSide(color: borderColor, width: 1.w),
    );

    final hintStyle = BaseText.grayMedium.copyWith(fontSize: 13.sp);
    final textStyle = BaseText.grayIronDark.copyWith(fontSize: 13.sp);

    return Row(
      children: [
        Container(
          height: 40.h,
          width: 40.w,
          decoration: BoxDecoration(
            color: ColorsName.grayWhiteSmoke,
            border: Border(
              top: BorderSide(color: borderColor, width: 1),
              left: BorderSide(color: borderColor, width: 1),
              bottom: BorderSide(color: borderColor, width: 1),
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8.r),
              topLeft: Radius.circular(8.r),
            ),
          ),
          child: Center(
            child: SvgPicture.asset(
              width: 12.w,
              ImageAssets.iconSvgCalendar,
              colorFilter: ColorFilter.mode(ColorsName.grayDark, BlendMode.srcIn),
            ),
          ),
        ),
        Expanded(
          child: TextField(
            style: textStyle,
            enabled: false,
            controller: controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: enabled ? ColorsName.white : ColorsName.grayWhiteSmoke,
              contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.3.h),
              constraints: BoxConstraints(maxHeight: 40.h),
              hintText: hint,
              hintStyle: hintStyle,
              border: border,
              enabledBorder: border,
              errorBorder: border,
              focusedBorder: border,
              disabledBorder: border,
              focusedErrorBorder: border,
            ),
          ),
        ),
      ],
    );
  }
}
