import '../paging/paging_data.dart';
import '../short_product_tax.dart';

class ProductTaxPagingDataResponse {
  PagingData<ShortProductTax> shortProductTaxPagingData;

  ProductTaxPagingDataResponse({
    required this.shortProductTaxPagingData
  });
}