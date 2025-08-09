import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crm/common/components/custom_divider.dart';
import 'package:crm/common/constants/colors_name.dart';

class CustomList<T> extends StatelessWidget {
  const CustomList({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.scroll = false,
    this.paddingDivider,
    this.dividerColor = ColorsName.grayCloud,
    this.padding,
  });
  final List<T> items;
  final Widget? Function(BuildContext context, int index) itemBuilder;
  final bool scroll;
  final Color dividerColor;
  final EdgeInsetsGeometry? paddingDivider;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: items.length,
      shrinkWrap: scroll ? false : true,
      physics: scroll ? null : NeverScrollableScrollPhysics(),
      padding: padding ?? EdgeInsets.zero,
      separatorBuilder: (context, index) => Container(
        padding: paddingDivider ?? EdgeInsets.symmetric(horizontal: 16.w),
        child: CustomDivider(
          color: dividerColor,
        ),
      ),
      itemBuilder: itemBuilder,
    );
  }
}
