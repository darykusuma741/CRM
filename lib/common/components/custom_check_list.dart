import 'package:crm/common/components/custom_error_text.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCheckList<T> extends StatelessWidget {
  const CustomCheckList({super.key, this.required = true, this.error, this.label, this.selectItems, this.items, this.onClick});
  final bool required;
  final String? error;
  final String? label;
  final List<T>? items;
  final List<T>? selectItems;
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items!.map((e) {
                bool select = selectItems == null ? false : selectItems!.contains(e);

                return InkWell(
                  onTap: () {
                    if (onClick != null) onClick!(e);
                  },
                  borderRadius: BorderRadius.circular(3.r),
                  child: Container(
                    constraints: BoxConstraints(minWidth: 85.w),
                    padding: EdgeInsets.only(top: 1.5.h, bottom: 1.5.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          select ? Icons.check_box : Icons.check_box_outline_blank_outlined,
                          color: select ? ColorsName.blueSteel : ColorsName.grayDim,
                          size: 18.sp,
                        ),
                        SizedBox(width: 8.25.w),
                        Text(e.toString(), style: BaseText.grayCharcoal.copyWith(fontSize: 12.sp)),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        if (error != null) CustomErrorText(error: error),
      ],
    );
  }
}
