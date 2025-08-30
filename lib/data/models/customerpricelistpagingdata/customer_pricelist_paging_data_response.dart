import '../paging/paging_data.dart';
import '../short_customer_pricelist.dart';

class CustomerPricelistPagingDataResponse {
  PagingData<ShortCustomerPricelist> shortCustomerPricelistPagingData;

  CustomerPricelistPagingDataResponse({
    required this.shortCustomerPricelistPagingData
  });
}