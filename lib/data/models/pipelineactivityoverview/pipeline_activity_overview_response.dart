import 'pipeline_activity_overview.dart';

class PipelineActivityOverviewResponse {
  int pipelineActivityGetReadyCount;
  List<PipelineActivityOverview> pipelineActivityOverviewList;
  List<PipelineActivityOverviewGroup> pipelineActivityOverviewGroupList;

  PipelineActivityOverviewResponse({
    required this.pipelineActivityGetReadyCount,
    required this.pipelineActivityOverviewList,
    required this.pipelineActivityOverviewGroupList
  });
}