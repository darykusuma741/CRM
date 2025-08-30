import '../paging/paging_data.dart';
import '../short_product_uom.dart';

class ProductUomPagingDataResponse {
  PagingData<ShortProductUom> shortProductUomPagingData;

  ProductUomPagingDataResponse({
    required this.shortProductUomPagingData
  });
}