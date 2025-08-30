import '../../../common/memory_local_data_storage.dart';
import '../activity_pipeline_category.dart';

abstract class ActivityPipelinePagingDataInputType {}

class AllActivityPipelinePagingDataInputType extends ActivityPipelinePagingDataInputType {}

class BasedPipelineActivityPipelinePagingDataInputType extends ActivityPipelinePagingDataInputType {
  String pipelineId;
  String pipelineName;

  BasedPipelineActivityPipelinePagingDataInputType({
    required this.pipelineId,
    required this.pipelineName
  });
}

abstract class ActivityPipelinePagingDataType {}

class InitialActivityPipelinePagingDataType extends ActivityPipelinePagingDataType {}

class NonInitialActivityPipelinePagingDataType extends ActivityPipelinePagingDataType {}

class WithCategoryActivityPipelinePagingDataType extends ActivityPipelinePagingDataType {
  ActivityPipelineCategory activityPipelineCategory;

  WithCategoryActivityPipelinePagingDataType({
    required this.activityPipelineCategory
  });
}

class ActivityPipelinePagingDataParameter {
  int page;
  int dataCountPerPage;
  ActivityPipelinePagingDataType activityPipelinePagingDataType;
  ActivityPipelinePagingDataInputType activityPipelinePagingDataInputType;
  String search;
  MemoryLocalDataStorage memoryLocalDataStorage;

  ActivityPipelinePagingDataParameter({
    required this.page,
    this.dataCountPerPage = 15,
    required this.activityPipelinePagingDataType,
    required this.activityPipelinePagingDataInputType,
    required this.search,
    required this.memoryLocalDataStorage
  });
}