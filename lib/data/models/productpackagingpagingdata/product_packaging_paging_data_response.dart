import '../paging/paging_data.dart';
import '../short_product_packaging.dart';

class ProductPackagingPagingDataResponse {
  PagingData<ShortProductPackaging> shortProductPackagingPagingData;

  ProductPackagingPagingDataResponse({
    required this.shortProductPackagingPagingData
  });
}