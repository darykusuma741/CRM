import '../../common/load_data_result/load_data_result.dart';
import '../../common/processing/future_processing.dart';
import '../models/addleads/add_leads_parameter.dart';
import '../models/addleads/add_leads_response.dart';
import '../models/converttolostleads/convert_to_lost_leads_parameter.dart';
import '../models/converttolostleads/convert_to_lost_leads_response.dart';
import '../models/converttopipeline/convert_to_pipeline_parameter.dart';
import '../models/converttopipeline/convert_to_pipeline_response.dart';
import '../models/editleads/edit_leads_parameter.dart';
import '../models/editleads/edit_leads_response.dart';
import '../models/leadscategory/leads_category_parameter.dart';
import '../models/leadscategory/leads_category_response.dart';
import '../models/leadsdetail/leads_detail_parameter.dart';
import '../models/leadsdetail/leads_detail_response.dart';
import '../models/leadspagingdata/leads_paging_data_parameter.dart';
import '../models/leadspagingdata/leads_paging_data_response.dart';
import '../models/restoreleads/restore_leads_parameter.dart';
import '../models/restoreleads/restore_leads_response.dart';
import '../remotedatasources/leadsremotedatasource/leads_remote_data_source.dart';
import '../repositories/leads_repository.dart';

class DefaultLeadsRepository implements LeadsRepository {
  final LeadsRemoteDataSource leadsRemoteDataSource;

  DefaultLeadsRepository({
    required this.leadsRemoteDataSource
  });

  @override
  FutureProcessing<LoadDataResult<LeadsDetailResponse>> leadsDetail(LeadsDetailParameter leadsDetailParameter) {
    return leadsRemoteDataSource.leadsDetail(leadsDetailParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<LeadsPagingDataResponse>> leadsPagingData(LeadsPagingDataParameter leadsPagingDataParameter) {
    return leadsRemoteDataSource.leadsPagingData(leadsPagingDataParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<LeadsCategoryResponse>> leadsCategory(LeadsCategoryParameter leadsCategoryParameter) {
    return leadsRemoteDataSource.leadsCategory(leadsCategoryParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<AddLeadsResponse>> addLeads(AddLeadsParameter addLeadsParameter) {
    return leadsRemoteDataSource.addLeads(addLeadsParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<EditLeadsResponse>> editLeads(EditLeadsParameter editLeadsParameter) {
    return leadsRemoteDataSource.editLeads(editLeadsParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<ConvertToLostLeadsResponse>> convertToLostLeads(ConvertToLostLeadsParameter convertToLostLeadsParameter) {
    return leadsRemoteDataSource.convertToLostLeads(convertToLostLeadsParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<ConvertToPipelineResponse>> convertToPipeline(ConvertToPipelineParameter convertToPipelineParameter) {
    return leadsRemoteDataSource.convertToPipeline(convertToPipelineParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<RestoreLeadsResponse>> restoreLeads(RestoreLeadsParameter restoreLeadsParameter) {
    return leadsRemoteDataSource.restoreLeads(restoreLeadsParameter).mapToLoadDataResult();
  }
}