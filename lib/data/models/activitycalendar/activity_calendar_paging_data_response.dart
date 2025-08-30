import '../paging/paging_data.dart';
import '../short_activity.dart';

class ActivityCalendarPagingDataResponse {
  PagingData<ShortActivity> activityPagingData;

  ActivityCalendarPagingDataResponse({
    required this.activityPagingData
  });
}