import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:crm/common/components/custom_calendar_text/controller/custom_calendar_text.controller.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:intl/intl.dart';

class CustomCalendarByMonth extends GetView<CustomCalendarTextController> {
  const CustomCalendarByMonth({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle titleTextStyle = BaseText.grayCharcoal.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w500);
    DateTime now = DateTime.now();
    final months = List.generate(
      12,
      (index) => DateFormat.MMM().format(DateTime(now.year, index + 1)), // 'Jan', 'Feb', etc.
    );

    return Obx(() {
      return Column(
        children: [
          SizedBox(height: 12.0),
          SizedBox(
            width: double.infinity,
            height: 28.h,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    borderRadius: BorderRadius.circular(100.r),
                    onTap: () {
                      controller.focusedDay.value = DateTime(controller.focusedDay.value.year - 1, controller.focusedDay.value.month);
                    },
                    child: Icon(Icons.chevron_left, color: ColorsName.grayGraphiteDark)),
                Expanded(
                  child: InkWell(
                      onTap: () {
                        controller.by.value = 'Year';
                      },
                      child: Center(child: Text(DateFormat('yyyy').format(controller.focusedDay.value), style: titleTextStyle))),
                ),
                InkWell(
                    borderRadius: BorderRadius.circular(100.r),
                    onTap: () {
                      controller.focusedDay.value = DateTime(controller.focusedDay.value.year + 1, controller.focusedDay.value.month);
                    },
                    child: Icon(Icons.chevron_right, color: ColorsName.grayGraphiteDark)),
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
                padding: EdgeInsets.zero, // <--- Pastikan tidak ada padding default
                crossAxisCount: crossAxisCount,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: spacing,
                crossAxisSpacing: spacing + 9.2,
                childAspectRatio: aspectRatio,
                children: List.generate(12, (index) {
                  bool disable = (controller.focusedDay.value.year < now.year) ? true : controller.focusedDay.value.year <= now.year && (index + 1) < now.month;
                  // bool disable = yearMonthDifference(focusedSelectDay.value, DateTime(now.year, index + 1))['year'] < 0;
                  bool nowMonth = (now.month == index + 1) && controller.focusedDay.value.year == now.year;
                  bool selectDate = controller.startDate.value == null
                      ? false
                      : controller.startDate.value!.month == (index + 1) && controller.startDate.value!.year == controller.focusedDay.value.year;

                  Color bgColor = selectDate ? ColorsName.blueBright : ColorsName.white;
                  Color borderColor = selectDate
                      ? ColorsName.blueBright
                      : nowMonth
                          ? ColorsName.blueDeep
                          : ColorsName.white;
                  TextStyle monthStyleText = selectDate
                      ? BaseText.white
                      : disable
                          ? BaseText.grayFoggy
                          : BaseText.grayCharcoal;

                  return InkWell(
                    onTap: () {
                      if (!disable) {
                        controller.by.value = 'Date';
                        controller.focusedDay.value = DateTime(controller.focusedDay.value.year, index + 1);
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(6.r),
                        border: Border.all(color: borderColor),
                      ),
                      child: Text(months[index], style: monthStyleText.copyWith(fontSize: 12.sp)),
                    ),
                  );
                }),
              );
            }),
          )
        ],
      );
    });
  }
}
