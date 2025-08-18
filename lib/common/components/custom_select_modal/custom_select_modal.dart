import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:crm/common/components/custom_modal_bottom.dart';
import 'package:crm/common/components/custom_select_modal/custom_select_modal.custom_modal.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/common/constants/image_assets.dart';

class CustomSelectModal<T> extends StatelessWidget {
  const CustomSelectModal({
    super.key,
    required this.items,
    this.title,
    this.padding,
    required this.value,
    required this.hint,
    required this.valueText,
    required this.onChange,
  });
  final T? value;
  final List<T> items;
  final String hint;
  final String Function(T v) valueText;
  final String? title;
  final EdgeInsetsGeometry? padding;
  final void Function(T? v) onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16.h),
      padding: padding ?? EdgeInsets.symmetric(),
      child: GestureDetector(
        onTap: () => customModalBottom<T>(CustomSelectModalCustomModal<T>(
          valueText: valueText,
          valueData: value,
          items: items,
          title: title,
          onChange: onChange,
        )),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: ColorsName.grayFaint,
            border: Border.all(color: value == null ? ColorsName.grayFeather : ColorsName.blueCalm, width: 1.w),
            borderRadius: BorderRadius.circular(100.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value != null ? valueText(value as T) : hint,
                style: (value == null ? BaseText.grayGraphiteDark : BaseText.blueClassic).copyWith(fontSize: 11.5.sp, letterSpacing: 0.0, height: 0.0),
              ),
              SizedBox(width: 5.w),
              Container(
                margin: EdgeInsets.only(top: 1.5.h),
                child: SvgPicture.asset(
                  ImageAssets.iconSvgChevron,
                  height: 6.h,
                  colorFilter: ColorFilter.mode(value == null ? ColorsName.grayGraphiteDark : ColorsName.blueClassic, BlendMode.srcIn),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
