import 'package:intl/intl.dart';

extension DateFormatExt on DateFormat? {
  String formatToNonNullableString(DateTime? dateTime) {
    if (this == null) {
      return "";
    }
    if (dateTime == null) {
      return "";
    }
    return this!.format(dateTime);
  }
}