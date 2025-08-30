import '../../common/load_data_result/load_data_result.dart';
import '../../common/processing/future_processing.dart';
import '../../data/models/achievementpercentageandtargetpoint/achievement_percentage_and_target_point_parameter.dart';
import '../../data/models/achievementpercentageandtargetpoint/achievement_percentage_and_target_point_response.dart';
import '../../data/models/latestleads/latest_leads_parameter.dart';
import '../../data/models/latestleads/latest_leads_response.dart';
import '../../data/models/pipelineactivityoverview/pipeline_activity_overview_parameter.dart';
import '../../data/models/pipelineactivityoverview/pipeline_activity_overview_response.dart';
import '../../data/models/salesmilestone/sales_milestone_parameter.dart';
import '../../data/models/salesmilestone/sales_milestone_response.dart';
import '../../data/models/salesprogressoverview/sales_progress_overview_parameter.dart';
import '../../data/models/salesprogressoverview/sales_progress_overview_response.dart';

abstract class DashboardRepository {
  FutureProcessing<LoadDataResult<SalesProgressOverviewResponse>> salesProgressOverview(SalesProgressOverviewParameter salesProgressOverviewParameter);
  FutureProcessing<LoadDataResult<SalesMilestoneResponse>> salesMilestone(SalesMilestoneParameter salesMilestoneParameter);
  FutureProcessing<LoadDataResult<AchievementPercentageAndTargetPointResponse>> achievementPercentageAndTargetPoint(AchievementPercentageAndTargetPointParameter achievementPercentageAndTargetPointParameter);
  FutureProcessing<LoadDataResult<PipelineActivityOverviewResponse>> pipelineActivityOverview(PipelineActivityOverviewParameter pipelineActivityOverviewParameter);
  FutureProcessing<LoadDataResult<LatestLeadsResponse>> latestLeads(LatestLeadsParameter latestLeadsParameter);
}