import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSelectCategory<T> extends StatelessWidget {
  const CustomSelectCategory({super.key, required this.items, this.onTap, this.selectItem});
  final List<CustomSelectCategoryState<T>> items;
  final T? selectItem;
  final void Function(T v)? onTap;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(left: 16.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8.w,
            children: items.map((e) {
              return _CustomSelectCategoryItem(
                s: e,
                select: e.value == selectItem,
                onTap: (onTap == null) ? null : () => onTap!(e.value),
              );
            }).toList(),
          ),
          SizedBox(width: 16.w),
        ],
      ),
    );
  }
}

class _CustomSelectCategoryItem extends StatelessWidget {
  const _CustomSelectCategoryItem({required this.s, required this.select, this.onTap});
  final CustomSelectCategoryState s;
  final bool select;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(100.r),
      color: select ? ColorsName.bluePastel.withOpacity(.5) : ColorsName.grayFaint,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(100.r),
        child: Container(
          height: 26.h,
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            border: Border.all(color: select ? ColorsName.bluePastel : ColorsName.grayCloud),
            borderRadius: BorderRadius.circular(100.r),
          ),
          child: Center(
            child: Text(
              '${s.label} (${s.count.toString()})',
              style: (select ? BaseText.blueDusty : BaseText.grayGraphiteDark)
                  .copyWith(fontSize: 11.sp, fontWeight: FontWeight.w400, letterSpacing: 0.0, height: 1.0),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomSelectCategoryState<T> {
  final String label;
  final int count;
  final T value;

  CustomSelectCategoryState({required this.label, required this.count, required this.value});
}
