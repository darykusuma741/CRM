import '../../common/load_data_result/load_data_result.dart';
import '../../common/processing/future_processing.dart';
import '../../data/models/activitycountbasedpipeline/activity_count_based_pipeline_parameter.dart';
import '../../data/models/activitycountbasedpipeline/activity_count_based_pipeline_response.dart';
import '../../data/models/addpipeline/add_pipeline_parameter.dart';
import '../../data/models/addpipeline/add_pipeline_response.dart';
import '../../data/models/converttolostpipeline/convert_to_lost_pipeline_parameter.dart';
import '../../data/models/converttolostpipeline/convert_to_lost_pipeline_response.dart';
import '../../data/models/editpipeline/edit_pipeline_parameter.dart';
import '../../data/models/editpipeline/edit_pipeline_response.dart';
import '../../data/models/pipelinecategory/pipeline_category_parameter.dart';
import '../../data/models/pipelinecategory/pipeline_category_response.dart';
import '../../data/models/pipelinedetail/pipeline_detail_parameter.dart';
import '../../data/models/pipelinedetail/pipeline_detail_response.dart';
import '../../data/models/pipelinenextstage/pipeline_next_stage_parameter.dart';
import '../../data/models/pipelinenextstage/pipeline_next_stage_response.dart';
import '../../data/models/pipelinepagingdata/pipeline_paging_data_parameter.dart';
import '../../data/models/pipelinepagingdata/pipeline_paging_data_response.dart';
import '../../data/models/pipelinestages/pipeline_stages_parameter.dart';
import '../../data/models/pipelinestages/pipeline_stages_response.dart';
import '../../data/models/quotationcountbasedpipeline/quotation_count_based_pipeline_parameter.dart';
import '../../data/models/quotationcountbasedpipeline/quotation_count_based_pipeline_response.dart';
import '../../data/models/restorepipeline/restore_pipeline_parameter.dart';
import '../../data/models/restorepipeline/restore_pipeline_response.dart';

abstract class PipelineRepository {
  FutureProcessing<LoadDataResult<PipelinePagingDataResponse>> pipelinePagingData(PipelinePagingDataParameter pipelinePagingDataParameter);
  FutureProcessing<LoadDataResult<PipelineCategoryResponse>> pipelineCategory(PipelineCategoryParameter pipelineCategoryParameter);
  FutureProcessing<LoadDataResult<AddPipelineResponse>> addPipeline(AddPipelineParameter addPipelineParameter);
  FutureProcessing<LoadDataResult<EditPipelineResponse>> editPipeline(EditPipelineParameter editPipelineParameter);
  FutureProcessing<LoadDataResult<PipelineDetailResponse>> pipelineDetail(PipelineDetailParameter pipelineDetailParameter);
  FutureProcessing<LoadDataResult<PipelineStagesResponse>> pipelineStages(PipelineStagesParameter pipelineStagesParameter);
  FutureProcessing<LoadDataResult<ConvertToLostPipelineResponse>> convertToLostPipeline(ConvertToLostPipelineParameter convertToLostPipelineParameter);
  FutureProcessing<LoadDataResult<PipelineNextStageResponse>> pipelineNextStage(PipelineNextStageParameter pipelineNextStageParameter);
  FutureProcessing<LoadDataResult<RestorePipelineResponse>> restorePipeline(RestorePipelineParameter restorePipelineParameter);
  FutureProcessing<LoadDataResult<ActivityCountBasedPipelineResponse>> activityCountBasedPipelineResponse(ActivityCountBasedPipelineParameter activityCountBasedPipelineParameter);
  FutureProcessing<LoadDataResult<QuotationCountBasedPipelineResponse>> quotationCountBasedPipelineResponse(QuotationCountBasedPipelineParameter quotationCountBasedPipelineParameter);
}