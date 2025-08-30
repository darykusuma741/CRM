import 'date_separation.dart';

class SameDateButDifferentTimeDateSeparation extends DateSeparation {
  String date;
  String startTime;
  String endTime;
  String durationString;

  SameDateButDifferentTimeDateSeparation({
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.durationString
  });
}