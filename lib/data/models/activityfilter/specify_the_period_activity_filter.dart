import 'activity_filter.dart';

class SpecifyThePeriodActivityFilter extends ActivityFilter {
  DateTime? startDateTime;
  DateTime? untilDate;

  SpecifyThePeriodActivityFilter({
    required this.startDateTime,
    required this.untilDate
  });

  @override
  String get title => "Specify The Period";
}