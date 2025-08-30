import '../paging/paging_data.dart';
import '../short_customer.dart';

class CustomerPagingDataResponse {
  PagingData<ShortCustomer> shortCustomerPagingData;

  CustomerPagingDataResponse({
    required this.shortCustomerPagingData
  });
}