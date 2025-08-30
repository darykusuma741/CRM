import '../paging/paging_data.dart';
import '../short_product.dart';

class ProductPagingDataResponse {
  PagingData<ShortProduct> shortProductPagingData;

  ProductPagingDataResponse({
    required this.shortProductPagingData
  });
}