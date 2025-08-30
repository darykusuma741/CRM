class PipelineActivityOverview {
  String category;
  String action;
  String name;
  int count;
  int index;

  PipelineActivityOverview({
    required this.category,
    required this.action,
    required this.name,
    required this.count,
    required this.index
  });
}

class PipelineActivityOverviewGroup {
  List<PipelineActivityOverview> pipelineActivityOverviewList;

  PipelineActivityOverviewGroup({
    required this.pipelineActivityOverviewList
  });
}