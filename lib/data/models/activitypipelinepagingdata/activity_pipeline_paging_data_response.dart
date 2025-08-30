import '../paging/paging_data.dart';
import '../short_activity.dart';

class ActivityPipelinePagingDataResponse {
  PagingData<ShortActivity> activityPagingData;

  ActivityPipelinePagingDataResponse({
    required this.activityPagingData
  });
}