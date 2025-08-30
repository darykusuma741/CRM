import '../../../common/memory_local_data_storage.dart';
import '../pipeline_category.dart';

abstract class PipelinePagingDataType {}

class InitialPipelinePagingDataType extends PipelinePagingDataType {}

class NonInitialPipelinePagingDataType extends PipelinePagingDataType {}

class WithCategoryPipelinePagingDataType extends PipelinePagingDataType {
  PipelineCategory pipelineCategory;

  WithCategoryPipelinePagingDataType({
    required this.pipelineCategory
  });
}

class PipelinePagingDataParameter {
  int page;
  int dataCountPerPage;
  PipelinePagingDataType pipelinePagingDataType;
  String search;
  MemoryLocalDataStorage memoryLocalDataStorage;

  PipelinePagingDataParameter({
    required this.page,
    this.dataCountPerPage = 15,
    required this.pipelinePagingDataType,
    this.search = "",
    required this.memoryLocalDataStorage
  });
}