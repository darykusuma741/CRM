import '../../../../common/processing/future_processing.dart';
import '../../models/activitycountbasedpipeline/activity_count_based_pipeline_parameter.dart';
import '../../models/activitycountbasedpipeline/activity_count_based_pipeline_response.dart';
import '../../models/addpipeline/add_pipeline_parameter.dart';
import '../../models/addpipeline/add_pipeline_response.dart';
import '../../models/converttolostpipeline/convert_to_lost_pipeline_parameter.dart';
import '../../models/converttolostpipeline/convert_to_lost_pipeline_response.dart';
import '../../models/editpipeline/edit_pipeline_parameter.dart';
import '../../models/editpipeline/edit_pipeline_response.dart';
import '../../models/pipelinecategory/pipeline_category_parameter.dart';
import '../../models/pipelinecategory/pipeline_category_response.dart';
import '../../models/pipelinedetail/pipeline_detail_parameter.dart';
import '../../models/pipelinedetail/pipeline_detail_response.dart';
import '../../models/pipelinenextstage/pipeline_next_stage_parameter.dart';
import '../../models/pipelinenextstage/pipeline_next_stage_response.dart';
import '../../models/pipelinepagingdata/pipeline_paging_data_parameter.dart';
import '../../models/pipelinepagingdata/pipeline_paging_data_response.dart';
import '../../models/pipelinestages/pipeline_stages_parameter.dart';
import '../../models/pipelinestages/pipeline_stages_response.dart';
import '../../models/quotationcountbasedpipeline/quotation_count_based_pipeline_parameter.dart';
import '../../models/quotationcountbasedpipeline/quotation_count_based_pipeline_response.dart';
import '../../models/restorepipeline/restore_pipeline_parameter.dart';
import '../../models/restorepipeline/restore_pipeline_response.dart';

abstract class PipelineRemoteDataSource {
  FutureProcessing<PipelinePagingDataResponse> pipelinePagingData(PipelinePagingDataParameter pipelinePagingDataParameter);
  FutureProcessing<PipelineCategoryResponse> pipelineCategory(PipelineCategoryParameter pipelineCategoryParameter);
  FutureProcessing<AddPipelineResponse> addPipeline(AddPipelineParameter addPipelineParameter);
  FutureProcessing<EditPipelineResponse> editPipeline(EditPipelineParameter editPipelineParameter);
  FutureProcessing<PipelineDetailResponse> pipelineDetail(PipelineDetailParameter pipelineDetailParameter);
  FutureProcessing<PipelineStagesResponse> pipelineStages(PipelineStagesParameter pipelineStagesParameter);
  FutureProcessing<ConvertToLostPipelineResponse> convertToLostPipeline(ConvertToLostPipelineParameter convertToLostPipelineParameter);
  FutureProcessing<PipelineNextStageResponse> pipelineNextStage(PipelineNextStageParameter pipelineNextStageParameter);
  FutureProcessing<RestorePipelineResponse> restorePipeline(RestorePipelineParameter restorePipelineParameter);
  FutureProcessing<ActivityCountBasedPipelineResponse> activityCountBasedPipelineResponse(ActivityCountBasedPipelineParameter activityCountBasedPipelineParameter);
  FutureProcessing<QuotationCountBasedPipelineResponse> quotationCountBasedPipelineResponse(QuotationCountBasedPipelineParameter quotationCountBasedPipelineParameter);
}