import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../date_format/anthony_input_date_format.dart';
import '../date_separation/date_separation.dart';
import '../date_separation/different_date_separation.dart';
import '../date_separation/same_date_but_different_time_date_separation.dart';

class DateHelper {
  static String get _currentLocale => "en_US";
  static DateFormat get standardDateFormat => DateFormat("yyyy-MM-dd HH:mm:ss", _currentLocale);
  static DateFormat get standardDateFormat2 => DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'", _currentLocale);
  static DateFormat get standardDateFormat3 => DateFormat("yyyy-MM-dd", _currentLocale);
  static DateFormat get standardDateFormat4 => DateFormat("dd MMMM yyyy", _currentLocale);
  static DateFormat get standardDateFormat5 => DateFormat("MMMM yyyy", _currentLocale);
  static DateFormat get standardDateFormat6 => DateFormat("dd MMMM yyyy HH:mm:ss", _currentLocale);
  static DateFormat get standardDateFormat7 => DateFormat("dd MMM yyyy", _currentLocale);
  static DateFormat get standardDateFormat8 => DateFormat("dd MMM yyyy HH:mm:ss", _currentLocale);
  static DateFormat get standardDateFormat9 => DateFormat("dd MMM", _currentLocale);
  static DateFormat get standardDateFormat10 => DateFormat("dd MMMM yyyy, HH:mm:ss", _currentLocale);
  static DateFormat get standardDateFormat11 => DateFormat("MMM yyyy", _currentLocale);
  static DateFormat get standardDateFormat12 => DateFormat("yyyy-MM-dd HH:mm:ss.SSS", _currentLocale);
  static DateFormat get standardDateFormat13 => DateFormat("ddMMyyHHmmss");
  static DateFormat get standardDateFormat14 => DateFormat('M/d/yyyy h:mm:ss a');
  static DateFormat get standardDateFormat15 => DateFormat('yyyy-MM-ddTHH:mm:ss.SSSSSSSZ', _currentLocale);
  static DateFormat get standardDateFormat16 => DateFormat('yyyy-MM-ddTHH:mm:ss', _currentLocale);
  static DateFormat get standardDateFormat17 => DateFormat("dd MMM yyyy, HH:mm", _currentLocale);
  static DateFormat get standardDateFormat18 => DateFormat("dd/MM/yyyy", _currentLocale);
  static DateFormat get standardDateFormat19 => DateFormat("EEEE, MMMM d yyyy");
  static DateFormat get standardDateFormat20 => DateFormat("EEEE, MMMM d yyyy, HH:mm");
  static DateFormat get standardDateFormat21 => DateFormat("yyyy-MM", _currentLocale);
  static DateFormat get standardTimeFormat => DateFormat("HH:mm:ss", _currentLocale);
  static DateFormat get standardHourMinuteTimeFormat => DateFormat("HH:mm", _currentLocale);
  static DateFormat get anthonyInputDateFormat => AnthonyInputDateFormat();

  static String formatDateBasedTodayOrNot(DateTime? willBeFormatting) {
    return willBeFormatting == null
        ? "(Empty)"
        : (willBeFormatting == DateTime.now()
            ? standardHourMinuteTimeFormat.format(willBeFormatting)
            : standardDateFormat4.format(willBeFormatting));
  }

  static DateTime convertUtcOffset(DateTime dateTime, int newUtcOffset, {int? oldUtcOffset}) {
    Duration offsetDifference = Duration(hours: newUtcOffset - (oldUtcOffset ?? dateTime.timeZoneOffset.inHours));
    DateTime convertedDateTime = dateTime.add(offsetDifference);
    return convertedDateTime;
  }

  static bool isTodayWithoutCheckingTime(DateTime dateTime) {
    DateTime now = DateTime.now();
    return now.year == dateTime.year &&
      now.month == dateTime.month &&
      now.day == dateTime.day;
  }

  static bool comparingEqualsWithoutCheckingTime(DateTime dateTime1, DateTime dateTime2) {
    return dateTime1.year == dateTime2.year &&
      dateTime1.month == dateTime2.month &&
      dateTime1.day == dateTime2.day;
  }

  static String convertDateTimeToTimeConsidered(DateTime dateTime) {
    if (isTodayWithoutCheckingTime(dateTime)) {
      return standardHourMinuteTimeFormat.format(dateTime);
    } else {
      return standardDateFormat6.format(dateTime);
    }
  }

  static bool isInRangeInclusiveIgnoringTime(DateTime target, DateTime start, DateTime end) {
    DateTime targetIgnoringTime = DateTime(target.year, target.month, target.day);
    DateTime startIgnoringTime = DateTime(start.year, start.month, start.day);
    DateTime endIgnoringTime = DateTime(end.year, end.month, end.day);
    return (targetIgnoringTime.isAtSameMomentAs(startIgnoringTime)
        || targetIgnoringTime.isAfter(startIgnoringTime)) &&
        (targetIgnoringTime.isAtSameMomentAs(endIgnoringTime)
        || targetIgnoringTime.isBefore(endIgnoringTime));
  }

  static bool last2MonthFromNow(DateTime target) {
    DateTime nowDateTime = DateTime.now();
    DateTime last2MonthDateTime = DateTime(nowDateTime.year, nowDateTime.month - 1, nowDateTime.day);
    return DateHelper.isInRangeInclusiveIgnoringTime(target, last2MonthDateTime, nowDateTime);
  }

  static bool isInRangeInclusive(DateTime target, DateTime start, DateTime end) {
    return (target.isAtSameMomentAs(start)
        || target.isAfter(start)) &&
        (target.isAtSameMomentAs(end)
        || target.isBefore(end));
  }

  static DateTimeRange startAndEndOfWeek(DateTime value) {
    return DateTimeRange(
      start: value.subtract(Duration(days: value.weekday - 1)),
      end: value.add(Duration(days: DateTime.daysPerWeek - value.weekday))
    );
  }

  static DateTimeRange startAndEndOfMonth(DateTime value) {
    return DateTimeRange(
      start: DateTime(value.year, value.month, 1),
      end: (value.month < 12)
        ? DateTime(value.year, value.month + 1, 1).subtract(const Duration(days: 1))
        : DateTime(value.year + 1, 1, 1).subtract(const Duration(days: 1))
    );
  }

  static DateSeparation separateDateTime({
    required DateTime dateTimeFrom,
    required DateTime dateTimeTo,
    required DateFormat dateFormat,
    required DateFormat timeFormat,
  }) {
    bool isSameDate = dateFormat.format(dateTimeFrom) == dateFormat.format(dateTimeTo);
    Duration difference = dateTimeTo.difference(dateTimeFrom);

    int days = difference.inDays;
    int hours = difference.inHours % 24;
    int minutes = difference.inMinutes % 60;
    int seconds = difference.inSeconds % 60;

    List<String> parts = [];
    if (days > 0) parts.add("$days ${days == 1 ? 'day' : 'days'}");
    if (hours > 0) parts.add("$hours ${hours == 1 ? 'hour' : 'hours'}");
    if (minutes > 0) parts.add("$minutes ${minutes == 1 ? 'minute' : 'minutes'}");
    if (seconds > 0) parts.add("$seconds ${seconds == 1 ? 'second' : 'seconds'}");

    String durationString = parts.join(" ").trim();

    if (isSameDate) {
      return SameDateButDifferentTimeDateSeparation(
        date: dateFormat.format(dateTimeFrom),
        startTime: timeFormat.format(dateTimeFrom),
        endTime: timeFormat.format(dateTimeTo),
        durationString: durationString
      );
    } else {
      return DifferentDateSeparation(
        startDate: dateFormat.format(dateTimeFrom),
        startTime: timeFormat.format(dateTimeFrom),
        endDate: dateFormat.format(dateTimeTo),
        endTime: timeFormat.format(dateTimeTo),
        durationString: durationString
      );
    }
  }

  DateTime combineDateAndTime(DateTime date, TimeOfDay time) {
    return DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
  }

  // Future<List<DateTime?>?> showCalendarDatePicker(
  //   BuildContext context,
  //   DateTime? currentSelectedDateTime
  // ) {
  //   DateTime selectedDateTime = currentSelectedDateTime ?? DateTime.now();
  //   DateTime focusedDateTime = selectedDateTime;
  //   TextStyle getRedText() {
  //     return BaseText.redDark.copyWith(
  //       fontWeight: BaseText.regular,
  //       color: ColorsName.beigeCream,
  //     );
  //   }
  //   var calendarStyle = CalendarStyle(
  //     outsideTextStyle: BaseText.grayDark.copyWith(
  //       color: ColorsName.grayDark,
  //       fontWeight: BaseText.light,
  //     ),
  //     holidayTextStyle: getRedText(),
  //     weekendTextStyle: getRedText(),
  //     defaultTextStyle: BaseText.grayDark.copyWith(
  //       color: ColorsName.grayDark,
  //     ),
  //   );
  //   TextStyle getWeekendStyleText() {
  //     return BaseText.redDark.copyWith(
  //       fontWeight: BaseText.regular,
  //       color: ColorsName.redDark,
  //     );
  //   }
  //   var cellMargin = calendarStyle.cellMargin;
  //   return showDialog<List<DateTime?>?>(
  //     context: context,
  //     builder: (context) {
  //       return Dialog(
  //         insetPadding: const EdgeInsets.all(16),
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(8.r)
  //         ),
  //         child: StatefulBuilder(
  //           builder: (context, onSetState) {
  //             return Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 Padding(
  //                   padding: const EdgeInsets.all(16).copyWith(bottom: 0),
  //                   child: reusableTitleBottomSheet(context, title: "Date")
  //                 ),
  //                 SizedBox(height: 10.h),
  //                 Padding(
  //                   padding: const EdgeInsets.symmetric(horizontal: 4),
  //                   child: TableCalendar(
  //                     onDaySelected: (selected, focused) {
  //                       selectedDateTime = selected;
  //                       focusedDateTime = focused;
  //                       onSetState(() {});
  //                     },
  //                     calendarBuilders: CalendarBuilders(
  //                       markerBuilder: (context, dateTime, list) {
  //                         if (list.isEmpty) {
  //                           return null;
  //                         }
  //                         return Padding(
  //                           padding: const EdgeInsets.only(bottom: 11.5),
  //                           child: Container(
  //                             width: 4,
  //                             height: 4,
  //                             decoration: BoxDecoration(
  //                               color: DateHelper().comparingEqualsWithoutCheckingTime(selectedDateTime, dateTime)
  //                                 ? ColorName.whiteColor
  //                                 : ColorName.mainColor,
  //                               shape: BoxShape.circle
  //                             ),
  //                           ),
  //                         );
  //                       },
  //                       todayBuilder: (context, day, focusedDay) {
  //                         final text = DateFormat.d().format(day);
  //                         return Container(
  //                           margin: cellMargin,
  //                           decoration: const BoxDecoration(
  //                             color: ColorName.readySecondaryColor,
  //                             shape: BoxShape.circle,
  //                             // borderRadius: BorderRadius.circular(24),
  //                           ),
  //                           child: Center(
  //                             child: Text(
  //                               text.toString(),
  //                               style: BaseText.greyText14,
  //                             ),
  //                           ),
  //                         );
  //                       },
  //                       selectedBuilder: (context, date, _) {
  //                         final text = DateFormat.d().format(date);
  //                         return Container(
  //                           margin: cellMargin,
  //                           decoration: const BoxDecoration(
  //                             color: ColorName.mainColor,
  //                             shape: BoxShape.circle,
  //                           ),
  //                           child: Center(
  //                             child: Text(
  //                               text.toString(),
  //                               style: BaseText.greyText14.copyWith(color: Colors.white),
  //                             ),
  //                           ),
  //                         );
  //                       }
  //                     ),
  //                     headerStyle: HeaderStyle(
  //                       titleCentered: true,
  //                       formatButtonVisible: false,
  //                       // headerPadding: EdgeInsets.symmetric(vertical: 16.h),
  //                       titleTextStyle: BaseText.greyText14.copyWith(fontWeight: BaseText.medium),
  //                       leftChevronIcon: const Icon(
  //                         Icons.chevron_left,
  //                         color: ColorName.darkGreyColor
  //                       ),
  //                       rightChevronIcon: const Icon(
  //                         Icons.chevron_right,
  //                         color: ColorName.darkGreyColor
  //                       ),
  //                       leftChevronPadding: EdgeInsets.zero,
  //                       rightChevronPadding: EdgeInsets.zero,
  //                     ),
  //                     calendarFormat: CalendarFormat.month,
  //                     firstDay: DateTime.utc(2010, 10, 16),
  //                     lastDay: DateTime.utc(2030, 3, 14),
  //                     focusedDay: focusedDateTime,
  //                     selectedDayPredicate: (day) => isSameDay(selectedDateTime, day),
  //                     startingDayOfWeek: StartingDayOfWeek.monday,
  //                     weekendDays: const [DateTime.sunday],
  //                     calendarStyle: calendarStyle,
  //                     daysOfWeekHeight: 32.h,
  //                     daysOfWeekStyle: DaysOfWeekStyle(
  //                       decoration: BoxDecoration(
  //                         border: Border(
  //                           bottom: BorderSide(
  //                             width: 1.h,
  //                             color: ColorName.lightGreyColor,
  //                           )
  //                         )
  //                       ),
  //                       weekdayStyle: BaseText.greyText12.copyWith(
  //                         fontWeight: BaseText.regular,
  //                         color: ColorName.bottomSheetDescriptionColor
  //                       ),
  //                       weekendStyle: getWeekendStyleText(),
  //                     ),
  //                   ),
  //                 ),
  //                 SizedBox(height: 6.h),
  //                 Padding(
  //                   padding: const EdgeInsets.all(16).copyWith(top: 0),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Flexible(
  //                         child: PrimaryButtonDialog(
  //                           onPressed: () => Navigator.pop(
  //                             context,
  //                             [selectedDateTime]
  //                           ),
  //                           height: 40.h,
  //                           title: "Save",
  //                         ),
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             );
  //           }
  //         ),
  //       );
  //     }
  //   );
  // }
}