import 'package:crm/common/ext/string_ext.dart';

import '../../data/models/activitycalendar/activity_calendar_check_in_out_response.dart';
import '../../data/models/short_activity.dart';

class ActivityHelper {
  static ActivityCalendarCheckInOutResponse checkActivityCheckInAndOutStatus(List<ShortActivity> shortActivityList) {
    var shortActivity = shortActivityList.where(
      (value) {
        if (value.activityAttendance != null) {
          if (value.activityAttendance!.activityState.toLowerCase() == "check_in") {
            return true;
          }
        }
        return false;
      }
    ).firstOrNull;
    var shortActivityAttendance = shortActivity?.activityAttendance;
    var activityState = (shortActivityAttendance?.activityState).toEmptyStringNonNull;
    var stateResult = () {
      if (activityState.isNotEmptyString) {
        var lowercaseActivityState = activityState.toEmptyStringNonNull.toLowerCase();
        if (lowercaseActivityState == "check_in") {
          return "check-out";
        }
      }
      return "check-in";
    }();
    return ActivityCalendarCheckInOutResponse(
      status: stateResult,
      checkedInShortActivity: shortActivity
    );
  }
}