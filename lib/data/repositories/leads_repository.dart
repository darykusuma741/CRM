import '../../common/load_data_result/load_data_result.dart';
import '../../common/processing/future_processing.dart';
import '../../data/models/addleads/add_leads_parameter.dart';
import '../../data/models/addleads/add_leads_response.dart';
import '../../data/models/converttolostleads/convert_to_lost_leads_parameter.dart';
import '../../data/models/converttolostleads/convert_to_lost_leads_response.dart';
import '../../data/models/converttopipeline/convert_to_pipeline_parameter.dart';
import '../../data/models/converttopipeline/convert_to_pipeline_response.dart';
import '../../data/models/editleads/edit_leads_parameter.dart';
import '../../data/models/editleads/edit_leads_response.dart';
import '../../data/models/leadscategory/leads_category_parameter.dart';
import '../../data/models/leadscategory/leads_category_response.dart';
import '../../data/models/leadsdetail/leads_detail_parameter.dart';
import '../../data/models/leadsdetail/leads_detail_response.dart';
import '../../data/models/leadspagingdata/leads_paging_data_parameter.dart';
import '../../data/models/leadspagingdata/leads_paging_data_response.dart';
import '../../data/models/restoreleads/restore_leads_parameter.dart';
import '../../data/models/restoreleads/restore_leads_response.dart';

abstract class LeadsRepository {
  FutureProcessing<LoadDataResult<LeadsDetailResponse>> leadsDetail(LeadsDetailParameter leadsDetailParameter);
  FutureProcessing<LoadDataResult<LeadsPagingDataResponse>> leadsPagingData(LeadsPagingDataParameter leadsPagingDataParameter);
  FutureProcessing<LoadDataResult<LeadsCategoryResponse>> leadsCategory(LeadsCategoryParameter leadsCategoryParameter);
  FutureProcessing<LoadDataResult<AddLeadsResponse>> addLeads(AddLeadsParameter addLeadsParameter);
  FutureProcessing<LoadDataResult<EditLeadsResponse>> editLeads(EditLeadsParameter addLeadsParameter);
  FutureProcessing<LoadDataResult<ConvertToLostLeadsResponse>> convertToLostLeads(ConvertToLostLeadsParameter convertToLostLeadsParameter);
  FutureProcessing<LoadDataResult<ConvertToPipelineResponse>> convertToPipeline(ConvertToPipelineParameter convertToPipelineParameter);
  FutureProcessing<LoadDataResult<RestoreLeadsResponse>> restoreLeads(RestoreLeadsParameter restoreLeadsParameter);
}