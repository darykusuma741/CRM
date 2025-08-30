import '../short_activity.dart';

class ActivityCalendarCheckInOutResponse {
  String status;
  ShortActivity? checkedInShortActivity;

  ActivityCalendarCheckInOutResponse({
    required this.status,
    required this.checkedInShortActivity
  });
}