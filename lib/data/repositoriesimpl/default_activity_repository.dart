import '../../common/load_data_result/load_data_result.dart';
import '../../common/processing/future_processing.dart';
import '../models/activitycalendar/activity_calendar_check_in_out_parameter.dart';
import '../models/activitycalendar/activity_calendar_check_in_out_response.dart';
import '../models/activitycalendar/activity_calendar_data_parameter.dart';
import '../models/activitycalendar/activity_calendar_data_response.dart';
import '../models/activitycalendar/activity_calendar_paging_data_parameter.dart';
import '../models/activitycalendar/activity_calendar_paging_data_response.dart';
import '../models/activitydetail/activity_detail_parameter.dart';
import '../models/activitydetail/activity_detail_response.dart';
import '../models/activitypipelinecategory/activity_pipeline_category_parameter.dart';
import '../models/activitypipelinecategory/activity_pipeline_category_response.dart';
import '../models/activitypipelinepagingdata/activity_pipeline_paging_data_parameter.dart';
import '../models/activitypipelinepagingdata/activity_pipeline_paging_data_response.dart';
import '../models/activitypipelineschedule/activity_pipeline_schedule_parameter.dart';
import '../models/activitypipelineschedule/activity_pipeline_schedule_response.dart';
import '../models/addactivity/add_activity_parameter.dart';
import '../models/addactivity/add_activity_response.dart';
import '../models/addactivitypipeline/add_activity_pipeline_parameter.dart';
import '../models/addactivitypipeline/add_activity_pipeline_response.dart';
import '../models/checkinactivitycalendar/check_in_activity_calendar_parameter.dart';
import '../models/checkinactivitycalendar/check_in_activity_calendar_response.dart';
import '../models/checkinactivitypipeline/check_in_activity_pipeline_parameter.dart';
import '../models/checkinactivitypipeline/check_in_activity_pipeline_response.dart';
import '../models/checkoutactivitycalendar/check_out_activity_calendar_parameter.dart';
import '../models/checkoutactivitycalendar/check_out_activity_calendar_response.dart';
import '../models/checkoutactivitypipeline/check_out_activity_pipeline_parameter.dart';
import '../models/checkoutactivitypipeline/check_out_activity_pipeline_response.dart';
import '../models/deleteactivity/delete_activity_parameter.dart';
import '../models/deleteactivity/delete_activity_response.dart';
import '../models/doneactivitypipeline/done_activity_pipeline_parameter.dart';
import '../models/doneactivitypipeline/done_activity_pipeline_response.dart';
import '../models/editactivity/edit_activity_parameter.dart';
import '../models/editactivity/edit_activity_response.dart';
import '../models/historyactivity/history_activity_parameter.dart';
import '../models/historyactivity/history_activity_response.dart';
import '../models/historypipelineactivity/history_pipeline_activity_parameter.dart';
import '../models/historypipelineactivity/history_pipeline_activity_response.dart';
import '../models/recommendationactivitypipelinetype/recommendation_activity_pipeline_type_parameter.dart';
import '../models/recommendationactivitypipelinetype/recommendation_activity_pipeline_type_response.dart';
import '../models/undoneactivitypipeline/undone_activity_pipeline_parameter.dart';
import '../models/undoneactivitypipeline/undone_activity_pipeline_response.dart';
import '../remotedatasources/activityremotedatasource/activity_remote_data_source.dart';
import '../repositories/activity_repository.dart';

class DefaultActivityRepository implements ActivityRepository {
  final ActivityRemoteDataSource activityRemoteDataSource;

  DefaultActivityRepository({
    required this.activityRemoteDataSource
  });

  @override
  FutureProcessing<LoadDataResult<HistoryPipelineActivityResponse>> historyPipelineActivity(HistoryPipelineActivityParameter historyPipelineActivityParameter) {
    return activityRemoteDataSource.historyPipelineActivity(historyPipelineActivityParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<HistoryActivityResponse>> historyActivity(HistoryActivityParameter historyActivityParameter) {
    return activityRemoteDataSource.historyActivity(historyActivityParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<ActivityCalendarDataResponse>> activityCalendarData(ActivityCalendarDataParameter activityCalendarDataParameter) {
    return activityRemoteDataSource.activityCalendarData(activityCalendarDataParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<ActivityCalendarCheckInOutResponse>> activityCalendarCheckInOut(ActivityCalendarCheckInOutParameter activityCalendarCheckInOutParameter) {
    return activityRemoteDataSource.activityCalendarCheckInOut(activityCalendarCheckInOutParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<ActivityCalendarPagingDataResponse>> activityCalendarPagingData(ActivityCalendarPagingDataParameter activityCalendarPagingDataParameter) {
    return activityRemoteDataSource.activityCalendarPagingData(activityCalendarPagingDataParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<ActivityPipelineCategoryResponse>> activityPipelineCategory(ActivityPipelineCategoryParameter activityPipelineCategoryParameter) {
    return activityRemoteDataSource.activityPipelineCategory(activityPipelineCategoryParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<ActivityPipelinePagingDataResponse>> activityPipelinePagingData(ActivityPipelinePagingDataParameter activityPipelinePagingDataParameter) {
    return activityRemoteDataSource.activityPipelinePagingData(activityPipelinePagingDataParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<ActivityDetailResponse>> activityDetail(ActivityDetailParameter activityDetailParameter) {
    return activityRemoteDataSource.activityDetail(activityDetailParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<AddActivityResponse>> addActivity(AddActivityParameter addActivityParameter) {
    return activityRemoteDataSource.addActivity(addActivityParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<EditActivityResponse>> editActivity(EditActivityParameter editActivityParameter) {
    return activityRemoteDataSource.editActivity(editActivityParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<DeleteActivityResponse>> deleteActivity(DeleteActivityParameter deleteActivityParameter) {
    return activityRemoteDataSource.deleteActivity(deleteActivityParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<AddActivityPipelineResponse>> addActivityPipeline(AddActivityPipelineParameter addActivityPipelineParameter) {
    return activityRemoteDataSource.addActivityPipeline(addActivityPipelineParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<CheckInActivityCalendarResponse>> checkInActivityCalendar(CheckInActivityCalendarParameter checkInActivityCalendarParameter) {
    return activityRemoteDataSource.checkInActivityCalendar(checkInActivityCalendarParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<CheckOutActivityCalendarResponse>> checkOutActivityCalendar(CheckOutActivityCalendarParameter checkOutActivityCalendarParameter) {
    return activityRemoteDataSource.checkOutActivityCalendar(checkOutActivityCalendarParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<CheckInActivityPipelineResponse>> checkInActivityPipeline(CheckInActivityPipelineParameter checkInActivityPipelineParameter) {
    return activityRemoteDataSource.checkInActivityPipeline(checkInActivityPipelineParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<CheckOutActivityPipelineResponse>> checkOutActivityPipeline(CheckOutActivityPipelineParameter checkOutActivityPipelineParameter) {
    return activityRemoteDataSource.checkOutActivityPipeline(checkOutActivityPipelineParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<DoneActivityPipelineResponse>> doneActivityPipeline(DoneActivityPipelineParameter doneActivityPipelineParameter) {
    return activityRemoteDataSource.doneActivityPipeline(doneActivityPipelineParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<UndoneActivityPipelineResponse>> undoneActivityPipeline(UndoneActivityPipelineParameter undoneActivityPipelineParameter) {
    return activityRemoteDataSource.undoneActivityPipeline(undoneActivityPipelineParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<ActivityPipelineScheduleResponse>> activityPipelineSchedule(ActivityPipelineScheduleParameter activityPipelineScheduleParameter) {
    return activityRemoteDataSource.activityPipelineSchedule(activityPipelineScheduleParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<RecommendationActivityPipelineTypeResponse>> recommendationActivityPipelineType(RecommendationActivityPipelineTypeParameter recommendationActivityPipelineTypeParameter) {
    return activityRemoteDataSource.recommendationActivityPipelineType(recommendationActivityPipelineTypeParameter).mapToLoadDataResult();
  }
}