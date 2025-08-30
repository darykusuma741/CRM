import '../../../../common/processing/future_processing.dart';
import '../../models/addleads/add_leads_parameter.dart';
import '../../models/addleads/add_leads_response.dart';
import '../../models/converttolostleads/convert_to_lost_leads_parameter.dart';
import '../../models/converttolostleads/convert_to_lost_leads_response.dart';
import '../../models/converttopipeline/convert_to_pipeline_parameter.dart';
import '../../models/converttopipeline/convert_to_pipeline_response.dart';
import '../../models/editleads/edit_leads_parameter.dart';
import '../../models/editleads/edit_leads_response.dart';
import '../../models/leadscategory/leads_category_parameter.dart';
import '../../models/leadscategory/leads_category_response.dart';
import '../../models/leadsdetail/leads_detail_parameter.dart';
import '../../models/leadsdetail/leads_detail_response.dart';
import '../../models/leadspagingdata/leads_paging_data_parameter.dart';
import '../../models/leadspagingdata/leads_paging_data_response.dart';
import '../../models/restoreleads/restore_leads_parameter.dart';
import '../../models/restoreleads/restore_leads_response.dart';

abstract class LeadsRemoteDataSource {
  FutureProcessing<LeadsDetailResponse> leadsDetail(LeadsDetailParameter leadsDetailParameter);
  FutureProcessing<LeadsPagingDataResponse> leadsPagingData(LeadsPagingDataParameter leadsPagingDataParameter);
  FutureProcessing<LeadsCategoryResponse> leadsCategory(LeadsCategoryParameter leadsCategoryParameter);
  FutureProcessing<AddLeadsResponse> addLeads(AddLeadsParameter addLeadsParameter);
  FutureProcessing<EditLeadsResponse> editLeads(EditLeadsParameter addLeadsParameter);
  FutureProcessing<ConvertToLostLeadsResponse> convertToLostLeads(ConvertToLostLeadsParameter convertToLostLeadsParameter);
  FutureProcessing<ConvertToPipelineResponse> convertToPipeline(ConvertToPipelineParameter convertToPipelineParameter);
  FutureProcessing<RestoreLeadsResponse> restoreLeads(RestoreLeadsParameter restoreLeadsParameter);
}