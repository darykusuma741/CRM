import '../../common/load_data_result/load_data_result.dart';
import '../../common/processing/future_processing.dart';
import '../../data/models/addproduct/add_product_parameter.dart';
import '../../data/models/addproduct/add_product_response.dart';
import '../../data/models/editproduct/edit_product_parameter.dart';
import '../../data/models/editproduct/edit_product_response.dart';
import '../../data/models/productdetail/product_detail_parameter.dart';
import '../../data/models/productdetail/product_detail_response.dart';
import '../../data/models/productpackagingpagingdata/product_packaging_paging_data_parameter.dart';
import '../../data/models/productpackagingpagingdata/product_packaging_paging_data_response.dart';
import '../../data/models/productpagingdata/product_paging_data_parameter.dart';
import '../../data/models/productpagingdata/product_paging_data_response.dart';
import '../../data/models/producttaxpagingdata/product_tax_paging_data_parameter.dart';
import '../../data/models/producttaxpagingdata/product_tax_paging_data_response.dart';
import '../../data/models/productuompagingdata/product_uom_paging_data_parameter.dart';
import '../../data/models/productuompagingdata/product_uom_paging_data_response.dart';

abstract class ProductRepository {
  FutureProcessing<LoadDataResult<ProductPagingDataResponse>> productPagingData(ProductPagingDataParameter productPagingDataParameter);
  FutureProcessing<LoadDataResult<ProductDetailResponse>> productDetail(ProductDetailParameter productDetailParameter);
  FutureProcessing<LoadDataResult<ProductPackagingPagingDataResponse>> productPackagingPagingData(ProductPackagingPagingDataParameter productPackagingPagingDataParameter);
  FutureProcessing<LoadDataResult<ProductTaxPagingDataResponse>> productTaxPagingData(ProductTaxPagingDataParameter productTaxPagingDataParameter);
  FutureProcessing<LoadDataResult<ProductUomPagingDataResponse>> productUomPagingData(ProductUomPagingDataParameter productTaxPagingDataParameter);
  FutureProcessing<LoadDataResult<AddProductResponse>> addProduct(AddProductParameter addProductParameter);
  FutureProcessing<LoadDataResult<EditProductResponse>> editProduct(EditProductParameter editProductParameter);
}