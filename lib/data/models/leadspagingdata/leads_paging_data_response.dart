import '../lead.dart';
import '../paging/paging_data.dart';

class LeadsPagingDataResponse {
  PagingData<ShortLeads> leadsPagingData;

  LeadsPagingDataResponse({
    required this.leadsPagingData
  });
}