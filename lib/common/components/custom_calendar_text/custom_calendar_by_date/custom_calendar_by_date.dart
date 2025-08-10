// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:crm/common/components/custom_calendar_text/controller/custom_calendar_text.controller.dart';
import 'package:crm/common/components/custom_calendar_text/custom_calendar_by_date/custom_calendar_by_date.builder.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalendarByDate extends GetView<CustomCalendarTextController> {
  const CustomCalendarByDate({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime firstDay = DateTime.now();
    // DateTime tempSelected = rangeStartDay;
    TextStyle styleDate = BaseText.grayCharcoal.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w400);
    TextStyle titleTextStyle = BaseText.grayCharcoal.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w500);
    TextStyle styleWeekend = BaseText.redCherry.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w400);
    TextStyle styleOutside = BaseText.grayFoggy.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w400);
    TextStyle styleDateSelect = BaseText.white.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w400);

    return Obx(
      () => TableCalendar(
        firstDay: firstDay,
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: controller.focusedDay.value,
        rangeStartDay: controller.startDate.value,
        rangeEndDay: controller.multipleDate.value ? controller.endDate.value : null,
        daysOfWeekVisible: true,
        headerVisible: true,
        sixWeekMonthsEnforced: false,
        pageJumpingEnabled: true,
        rangeSelectionMode: RangeSelectionMode.enforced,
        calendarFormat: CalendarFormat.month,
        startingDayOfWeek: StartingDayOfWeek.sunday,
        selectedDayPredicate: (day) => isSameDay(day, controller.startDate.value),
        onDaySelected: controller.onDaySelected,
        onHeaderTapped: controller.onHeaderTapped,
        daysOfWeekStyle: DaysOfWeekStyle(
          dowTextFormatter: (date, locale) {
            return DateFormat.E(locale).format(date); // misal "Sun", "Mon"
          },
          weekdayStyle: styleDate,
          weekendStyle: styleWeekend,
        ),
        rowHeight: 37.h,
        daysOfWeekHeight: 30.h,
        calendarBuilders: CalendarBuilders(
          dowBuilder: CustomCalendarByDateBuilder.dowBuilder,
          defaultBuilder: CustomCalendarByDateBuilder.defaultBuilder,
          todayBuilder: CustomCalendarByDateBuilder.todayBuilder,
        ),
        headerStyle: HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
          formatButtonShowsNext: true,
          headerPadding: EdgeInsets.symmetric(vertical: 12.h),
          rightChevronPadding: EdgeInsets.zero,
          leftChevronPadding: EdgeInsets.zero,
          titleTextStyle: titleTextStyle,
          leftChevronIcon: Icon(Icons.chevron_left, color: ColorsName.grayGraphiteDark),
          rightChevronIcon: Icon(Icons.chevron_right, color: ColorsName.grayGraphiteDark),
        ),
        calendarStyle: CalendarStyle(
          defaultTextStyle: styleDate,
          selectedTextStyle: styleDateSelect,
          todayTextStyle: styleDate,
          holidayTextStyle: styleDate,
          weekendTextStyle: styleWeekend,
          outsideTextStyle: styleOutside,
          disabledTextStyle: styleOutside,
          rangeEndTextStyle: styleDateSelect,
          rangeStartTextStyle: styleDateSelect,
          weekNumberTextStyle: styleDate,
          withinRangeTextStyle: styleDate,
          rangeStartDecoration: BoxDecoration(
            color: ColorsName.blueBright,
            shape: BoxShape.circle,
          ),
          rangeHighlightColor: ColorsName.blueTransparent.withOpacity(.6),
          rangeEndDecoration: BoxDecoration(
            color: ColorsName.blueBright,
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            color: ColorsName.blueBright,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
