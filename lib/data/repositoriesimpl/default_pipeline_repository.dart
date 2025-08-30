import '../../common/load_data_result/load_data_result.dart';
import '../../common/processing/future_processing.dart';
import '../models/activitycountbasedpipeline/activity_count_based_pipeline_parameter.dart';
import '../models/activitycountbasedpipeline/activity_count_based_pipeline_response.dart';
import '../models/addpipeline/add_pipeline_parameter.dart';
import '../models/addpipeline/add_pipeline_response.dart';
import '../models/converttolostpipeline/convert_to_lost_pipeline_parameter.dart';
import '../models/converttolostpipeline/convert_to_lost_pipeline_response.dart';
import '../models/editpipeline/edit_pipeline_parameter.dart';
import '../models/editpipeline/edit_pipeline_response.dart';
import '../models/pipelinecategory/pipeline_category_parameter.dart';
import '../models/pipelinecategory/pipeline_category_response.dart';
import '../models/pipelinedetail/pipeline_detail_parameter.dart';
import '../models/pipelinedetail/pipeline_detail_response.dart';
import '../models/pipelinenextstage/pipeline_next_stage_parameter.dart';
import '../models/pipelinenextstage/pipeline_next_stage_response.dart';
import '../models/pipelinepagingdata/pipeline_paging_data_parameter.dart';
import '../models/pipelinepagingdata/pipeline_paging_data_response.dart';
import '../models/pipelinestages/pipeline_stages_parameter.dart';
import '../models/pipelinestages/pipeline_stages_response.dart';
import '../models/quotationcountbasedpipeline/quotation_count_based_pipeline_parameter.dart';
import '../models/quotationcountbasedpipeline/quotation_count_based_pipeline_response.dart';
import '../models/restorepipeline/restore_pipeline_parameter.dart';
import '../models/restorepipeline/restore_pipeline_response.dart';
import '../remotedatasources/pipelineremotedatasource/pipeline_remote_data_source.dart';
import '../repositories/pipeline_repository.dart';

class DefaultPipelineRepository implements PipelineRepository {
  final PipelineRemoteDataSource pipelineRemoteDataSource;

  DefaultPipelineRepository({
    required this.pipelineRemoteDataSource
  });

  @override
  FutureProcessing<LoadDataResult<PipelinePagingDataResponse>> pipelinePagingData(PipelinePagingDataParameter pipelinePagingDataParameter) {
    return pipelineRemoteDataSource.pipelinePagingData(pipelinePagingDataParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<PipelineCategoryResponse>> pipelineCategory(PipelineCategoryParameter pipelineCategoryParameter) {
    return pipelineRemoteDataSource.pipelineCategory(pipelineCategoryParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<AddPipelineResponse>> addPipeline(AddPipelineParameter addPipelineParameter) {
    return pipelineRemoteDataSource.addPipeline(addPipelineParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<EditPipelineResponse>> editPipeline(EditPipelineParameter editPipelineParameter) {
    return pipelineRemoteDataSource.editPipeline(editPipelineParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<PipelineDetailResponse>> pipelineDetail(PipelineDetailParameter pipelineDetailParameter) {
    return pipelineRemoteDataSource.pipelineDetail(pipelineDetailParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<PipelineStagesResponse>> pipelineStages(PipelineStagesParameter pipelineStagesParameter) {
    return pipelineRemoteDataSource.pipelineStages(pipelineStagesParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<ConvertToLostPipelineResponse>> convertToLostPipeline(ConvertToLostPipelineParameter convertToLostPipelineParameter) {
    return pipelineRemoteDataSource.convertToLostPipeline(convertToLostPipelineParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<PipelineNextStageResponse>> pipelineNextStage(PipelineNextStageParameter pipelineNextStageParameter) {
    return pipelineRemoteDataSource.pipelineNextStage(pipelineNextStageParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<RestorePipelineResponse>> restorePipeline(RestorePipelineParameter restorePipelineParameter) {
    return pipelineRemoteDataSource.restorePipeline(restorePipelineParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<ActivityCountBasedPipelineResponse>> activityCountBasedPipelineResponse(ActivityCountBasedPipelineParameter activityCountBasedPipelineParameter) {
    return pipelineRemoteDataSource.activityCountBasedPipelineResponse(activityCountBasedPipelineParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<QuotationCountBasedPipelineResponse>> quotationCountBasedPipelineResponse(QuotationCountBasedPipelineParameter quotationCountBasedPipelineParameter) {
    return pipelineRemoteDataSource.quotationCountBasedPipelineResponse(quotationCountBasedPipelineParameter).mapToLoadDataResult();
  }
}