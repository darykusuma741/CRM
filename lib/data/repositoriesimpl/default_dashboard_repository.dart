import '../../common/load_data_result/load_data_result.dart';
import '../../common/processing/future_processing.dart';
import '../../data/models/latestleads/latest_leads_parameter.dart';
import '../../data/models/latestleads/latest_leads_response.dart';
import '../models/achievementpercentageandtargetpoint/achievement_percentage_and_target_point_parameter.dart';
import '../models/achievementpercentageandtargetpoint/achievement_percentage_and_target_point_response.dart';
import '../models/pipelineactivityoverview/pipeline_activity_overview_parameter.dart';
import '../models/pipelineactivityoverview/pipeline_activity_overview_response.dart';
import '../models/salesmilestone/sales_milestone_parameter.dart';
import '../models/salesmilestone/sales_milestone_response.dart';
import '../models/salesprogressoverview/sales_progress_overview_parameter.dart';
import '../models/salesprogressoverview/sales_progress_overview_response.dart';
import '../remotedatasources/dashboardremotedatasource/dashboard_remote_data_source.dart';
import '../repositories/dashboard_repository.dart';

class DefaultDashboardRepository implements DashboardRepository {
  final DashboardRemoteDataSource dashboardRemoteDataSource;

  DefaultDashboardRepository({
    required this.dashboardRemoteDataSource
  });

  @override
  FutureProcessing<LoadDataResult<SalesProgressOverviewResponse>> salesProgressOverview(SalesProgressOverviewParameter salesProgressOverviewParameter) {
    return dashboardRemoteDataSource.salesProgressOverview(salesProgressOverviewParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<LatestLeadsResponse>> latestLeads(LatestLeadsParameter latestLeadsParameter) {
    return dashboardRemoteDataSource.latestLeads(latestLeadsParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<PipelineActivityOverviewResponse>> pipelineActivityOverview(PipelineActivityOverviewParameter pipelineActivityOverviewParameter) {
    return dashboardRemoteDataSource.pipelineActivityOverview(pipelineActivityOverviewParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<SalesMilestoneResponse>> salesMilestone(SalesMilestoneParameter salesMilestoneParameter) {
    return dashboardRemoteDataSource.salesMilestone(salesMilestoneParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<AchievementPercentageAndTargetPointResponse>> achievementPercentageAndTargetPoint(AchievementPercentageAndTargetPointParameter achievementPercentageAndTargetPointParameter) {
    return dashboardRemoteDataSource.achievementPercentageAndTargetPoint(achievementPercentageAndTargetPointParameter).mapToLoadDataResult();
  }
}