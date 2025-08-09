import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crm/common/constants/colors_name.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key, this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color ?? ColorsName.grayCloud,
      height: 0.h,
      thickness: 1.h,
    );
  }
}
