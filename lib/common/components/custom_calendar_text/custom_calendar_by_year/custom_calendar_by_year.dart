import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:crm/common/components/custom_calendar_text/controller/custom_calendar_text.controller.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';

class CustomCalendarByYear extends GetView<CustomCalendarTextController> {
  const CustomCalendarByYear({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      TextStyle titleTextStyle = BaseText.grayCharcoal.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w500);
      final now = DateTime.now();
      final focusedYear = controller.focusedDay.value.year;
      final startYear = focusedYear - (focusedYear % 12); // e.g., 2025 → 2020

      return Column(
        children: [
          SizedBox(height: 12.0),
          SizedBox(
            width: double.infinity,
            height: 28.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(100.r),
                  onTap: () {
                    controller.focusedDay.value = DateTime(controller.focusedDay.value.year - 12, controller.focusedDay.value.month);
                  },
                  child: Icon(Icons.chevron_left, color: ColorsName.grayGraphiteDark),
                ),
                Text('$startYear - ${startYear + 11}', style: titleTextStyle),
                InkWell(
                  borderRadius: BorderRadius.circular(100.r),
                  onTap: () {
                    controller.focusedDay.value = DateTime(controller.focusedDay.value.year + 12, controller.focusedDay.value.month);
                  },
                  child: Icon(Icons.chevron_right, color: ColorsName.grayGraphiteDark),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.0),
          SizedBox(
            height: 173.h,
            child: LayoutBuilder(builder: (context, constraints) {
              const crossAxisCount = 4;
              const rowCount = 3;
              final spacing = 8.h;

              final totalSpacing = (rowCount - 1) * spacing;
              final itemHeight = (constraints.maxHeight - totalSpacing) / rowCount;
              final itemWidth = constraints.maxWidth / crossAxisCount;
              final aspectRatio = (itemWidth / itemHeight) - 0.23;

              return GridView.count(
                padding: EdgeInsets.zero,
                crossAxisCount: crossAxisCount,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: spacing,
                crossAxisSpacing: spacing + 9.2,
                childAspectRatio: aspectRatio,
                children: List.generate(12, (index) {
                  final year = startYear + index;
                  bool disable = year < now.year;
                  bool isNowYear = year == now.year;
                  bool isSelected = controller.startDate.value?.year == year;

                  Color bgColor = isSelected ? ColorsName.blueBright : ColorsName.white;
                  Color borderColor = isSelected
                      ? ColorsName.blueBright
                      : isNowYear
                          ? ColorsName.blueDeep
                          : ColorsName.white;
                  TextStyle yearTextStyle = isSelected
                      ? BaseText.white
                      : disable
                          ? BaseText.grayFoggy
                          : BaseText.grayCharcoal;

                  return InkWell(
                    onTap: () {
                      if (!disable) {
                        controller.by.value = 'Month';
                        controller.focusedDay.value = DateTime(year, controller.focusedDay.value.month);
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(6.r),
                        border: Border.all(color: borderColor),
                      ),
                      child: Text('$year', style: yearTextStyle.copyWith(fontSize: 12.sp)),
                    ),
                  );
                }),
              );
            }),
          ),
        ],
      );
    });
  }
}
