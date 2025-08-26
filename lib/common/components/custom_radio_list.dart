import 'package:crm/common/components/custom_error_text.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomRadioList<T> extends StatelessWidget {
  const CustomRadioList({super.key, this.required = true, this.vertical = false, this.error, this.label, this.selectItems, this.items, this.onClick});
  final bool required;
  final String? error;
  final String? label;
  final List<T>? items;
  final T? selectItems;
  final bool vertical;
  final Function(T v)? onClick;

  @override
  Widget build(BuildContext context) {
    final labelStyle = BaseText.blueMuted.copyWith(fontSize: 12.sp);
    final requiredStyle = BaseText.redCherry.copyWith(fontSize: 12.sp);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Row(
            children: [
              Text(label!, style: labelStyle),
              if (required) Text(' *', style: requiredStyle),
            ],
          ),
        if (label != null) SizedBox(height: 5.h),
        if (items != null)
          (vertical)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8.h,
                  children: items!.map((e) {
                    return _buildComponent(e);
                  }).toList(),
                )
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: items!.map((e) {
                      return _buildComponent(e);
                    }).toList(),
                  ),
                ),
        if (error != null) CustomErrorText(error: error),
      ],
    );
  }

  Widget _buildComponent(T e) {
    bool select = selectItems == null ? false : selectItems == e;

    return InkWell(
      onTap: () {
        if (onClick != null) onClick!(e);
      },
      borderRadius: BorderRadius.circular(13.r),
      child: Container(
        constraints: BoxConstraints(minWidth: 85.w),
        padding: EdgeInsets.only(top: 1.5.h, bottom: 1.5.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              select ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded,
              color: select ? ColorsName.blueSteel : ColorsName.grayDim,
              size: 18.sp,
            ),
            SizedBox(width: 8.25.w),
            Text(e.toString(), style: BaseText.grayCharcoal.copyWith(fontSize: 12.sp)),
            SizedBox(width: 20.w),
          ],
        ),
      ),
    );
  }
}
