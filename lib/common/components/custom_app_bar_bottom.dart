import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';

class CustomAppBarBottom extends StatelessWidget implements PreferredSizeWidget {
  final dividerHeight = 0.5;
  final List<Widget> tabs;
  final bool dividerTop;
  final double? tabBarHeight;
  final List<BoxShadow>? boxShadow;
  const CustomAppBarBottom({super.key, required this.tabs, this.dividerTop = true, this.boxShadow, this.tabBarHeight});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (dividerTop)
          Container(
            height: dividerHeight.h,
            color: ColorsName.grayPale,
          ),
        Container(
          decoration: BoxDecoration(
            color: ColorsName.white,
            boxShadow: boxShadow ??
                [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 2,
                    spreadRadius: 0.0,
                    offset: Offset(0, 0.44),
                  ),
                  BoxShadow(
                    color: ColorsName.grayIronDeep.withOpacity(0.05),
                    blurRadius: 12,
                    spreadRadius: 1.32,
                    offset: Offset(0, 4),
                  ),
                ],
          ),
          child: TabBar(
            splashBorderRadius: BorderRadius.circular(0.0),
            dividerColor: ColorsName.white,
            dividerHeight: 0.5.h,
            indicatorColor: ColorsName.blueSteel,
            labelColor: ColorsName.blueSteel,
            labelStyle: BaseText.blueSteel.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
            ),
            unselectedLabelStyle: BaseText.grayMedium.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 12.sp,
            ),
            indicatorWeight: 1.0.h,
            indicatorSize: TabBarIndicatorSize.tab,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            tabs: tabs,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize {
    return Size.fromHeight((tabBarHeight ?? 44.h) + (dividerTop ? dividerHeight.h : 0.0));
  }
}
