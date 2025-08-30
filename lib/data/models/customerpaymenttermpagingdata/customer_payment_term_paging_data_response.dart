import '../paging/paging_data.dart';
import '../short_customer_payment_term.dart';

class CustomerPaymentTermPagingDataResponse {
  PagingData<ShortCustomerPaymentTerm> shortCustomerPaymentTermPagingData;

  CustomerPaymentTermPagingDataResponse({
    required this.shortCustomerPaymentTermPagingData
  });
}