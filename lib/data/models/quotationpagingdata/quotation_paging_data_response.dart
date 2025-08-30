import '../paging/paging_data.dart';
import '../short_quotation.dart';

class QuotationPagingDataResponse {
  PagingData<ShortQuotation> shortQuotationPagingData;

  QuotationPagingDataResponse({
    required this.shortQuotationPagingData
  });
}