import '../../../../common/processing/future_processing.dart';
import '../../models/addproduct/add_product_parameter.dart';
import '../../models/addproduct/add_product_response.dart';
import '../../models/editproduct/edit_product_parameter.dart';
import '../../models/editproduct/edit_product_response.dart';
import '../../models/productdetail/product_detail_parameter.dart';
import '../../models/productdetail/product_detail_response.dart';
import '../../models/productpackagingpagingdata/product_packaging_paging_data_parameter.dart';
import '../../models/productpackagingpagingdata/product_packaging_paging_data_response.dart';
import '../../models/productpagingdata/product_paging_data_parameter.dart';
import '../../models/productpagingdata/product_paging_data_response.dart';
import '../../models/producttaxpagingdata/product_tax_paging_data_parameter.dart';
import '../../models/producttaxpagingdata/product_tax_paging_data_response.dart';
import '../../models/productuompagingdata/product_uom_paging_data_parameter.dart';
import '../../models/productuompagingdata/product_uom_paging_data_response.dart';

abstract class ProductRemoteDataSource {
  FutureProcessing<ProductPagingDataResponse> productPagingData(ProductPagingDataParameter productPagingDataParameter);
  FutureProcessing<ProductDetailResponse> productDetail(ProductDetailParameter productDetailParameter);
  FutureProcessing<ProductPackagingPagingDataResponse> productPackagingPagingData(ProductPackagingPagingDataParameter productPackagingPagingDataParameter);
  FutureProcessing<ProductTaxPagingDataResponse> productTaxPagingData(ProductTaxPagingDataParameter productTaxPagingDataParameter);
  FutureProcessing<ProductUomPagingDataResponse> productUomPagingData(ProductUomPagingDataParameter productTaxPagingDataParameter);
  FutureProcessing<AddProductResponse> addProduct(AddProductParameter addProductParameter);
  FutureProcessing<EditProductResponse> editProduct(EditProductParameter editProductParameter);
}