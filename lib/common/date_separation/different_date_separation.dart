import 'date_separation.dart';

class DifferentDateSeparation extends DateSeparation {
  String startDate;
  String startTime;
  String endDate;
  String endTime;
  String durationString;

  DifferentDateSeparation({
    required this.startDate,
    required this.startTime,
    required this.endDate,
    required this.endTime,
    required this.durationString
  });
}