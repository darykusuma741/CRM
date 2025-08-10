import 'package:crm/common/components/custom_error_text.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSelectLabel<T> extends StatelessWidget {
  const CustomSelectLabel({
    super.key,
    this.label,
    this.required = true,
    this.error,
    this.onSelected,
    required this.selectedItems,
    required this.items,
  });
  final String? label;
  final bool required;
  final String? error;
  final void Function(bool value, T items)? onSelected;
  final List<T> selectedItems;
  final List<T> items;

  @override
  Widget build(BuildContext context) {
    final labelStyle = BaseText.blueMuted.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w500);
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
        Wrap(
          spacing: 6.w,
          runSpacing: 6.h,
          children: items.map((text) {
            final bool isSelected = selectedItems.contains(text);
            return ChoiceChip(
              label: Text(
                text.toString(),
                style: (isSelected ? BaseText.blueSteel : BaseText.grayDarker).copyWith(fontSize: 12.sp),
              ),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              showCheckmark: false,
              selected: isSelected,
              padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 7.w),
              selectedColor: ColorsName.blueSoftPale,
              backgroundColor: ColorsName.grayFaint,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.r),
                side: BorderSide(
                  color: isSelected ? ColorsName.blueCalm : ColorsName.grayDim,
                ),
              ),
              onSelected: (value) {
                if (onSelected != null) onSelected!(value, text);
              },
            );
          }).toList(),
        ),
        if (error != null) CustomErrorText(error: error)
      ],
    );
  }
}
