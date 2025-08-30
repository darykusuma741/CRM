import '../../../../common/processing/future_processing.dart';
import '../../models/achievementpercentageandtargetpoint/achievement_percentage_and_target_point_parameter.dart';
import '../../models/achievementpercentageandtargetpoint/achievement_percentage_and_target_point_response.dart';
import '../../models/latestleads/latest_leads_parameter.dart';
import '../../models/latestleads/latest_leads_response.dart';
import '../../models/pipelineactivityoverview/pipeline_activity_overview_parameter.dart';
import '../../models/pipelineactivityoverview/pipeline_activity_overview_response.dart';
import '../../models/salesmilestone/sales_milestone_parameter.dart';
import '../../models/salesmilestone/sales_milestone_response.dart';
import '../../models/salesprogressoverview/sales_progress_overview_parameter.dart';
import '../../models/salesprogressoverview/sales_progress_overview_response.dart';

abstract class DashboardRemoteDataSource {
  FutureProcessing<SalesProgressOverviewResponse> salesProgressOverview(SalesProgressOverviewParameter salesProgressOverviewParameter);
  FutureProcessing<SalesMilestoneResponse> salesMilestone(SalesMilestoneParameter salesMilestoneParameter);
  FutureProcessing<AchievementPercentageAndTargetPointResponse> achievementPercentageAndTargetPoint(AchievementPercentageAndTargetPointParameter achievementPercentageAndTargetPointParameter);
  FutureProcessing<PipelineActivityOverviewResponse> pipelineActivityOverview(PipelineActivityOverviewParameter pipelineActivityOverviewParameter);
  FutureProcessing<LatestLeadsResponse> latestLeads(LatestLeadsParameter latestLeadsParameter);
}