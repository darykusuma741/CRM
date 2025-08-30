import '../../common/load_data_result/load_data_result.dart';
import '../../common/processing/future_processing.dart';
import '../models/addproduct/add_product_parameter.dart';
import '../models/addproduct/add_product_response.dart';
import '../models/editproduct/edit_product_parameter.dart';
import '../models/editproduct/edit_product_response.dart';
import '../models/productdetail/product_detail_parameter.dart';
import '../models/productdetail/product_detail_response.dart';
import '../models/productpackagingpagingdata/product_packaging_paging_data_parameter.dart';
import '../models/productpackagingpagingdata/product_packaging_paging_data_response.dart';
import '../models/productpagingdata/product_paging_data_parameter.dart';
import '../models/productpagingdata/product_paging_data_response.dart';
import '../models/producttaxpagingdata/product_tax_paging_data_parameter.dart';
import '../models/producttaxpagingdata/product_tax_paging_data_response.dart';
import '../models/productuompagingdata/product_uom_paging_data_parameter.dart';
import '../models/productuompagingdata/product_uom_paging_data_response.dart';
import '../remotedatasources/productremotedatasource/product_remote_data_source.dart';
import '../repositories/product_repository.dart';

class DefaultProductRepository implements ProductRepository {
  final ProductRemoteDataSource productRemoteDataSource;

  DefaultProductRepository({
    required this.productRemoteDataSource
  });

  @override
  FutureProcessing<LoadDataResult<ProductPagingDataResponse>> productPagingData(ProductPagingDataParameter productPagingDataParameter) {
    return productRemoteDataSource.productPagingData(productPagingDataParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<ProductDetailResponse>> productDetail(ProductDetailParameter productDetailParameter) {
    return productRemoteDataSource.productDetail(productDetailParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<ProductPackagingPagingDataResponse>> productPackagingPagingData(ProductPackagingPagingDataParameter productPackagingPagingDataParameter) {
    return productRemoteDataSource.productPackagingPagingData(productPackagingPagingDataParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<ProductTaxPagingDataResponse>> productTaxPagingData(ProductTaxPagingDataParameter productTaxPagingDataParameter) {
    return productRemoteDataSource.productTaxPagingData(productTaxPagingDataParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<ProductUomPagingDataResponse>> productUomPagingData(ProductUomPagingDataParameter productUomPagingDataParameter) {
    return productRemoteDataSource.productUomPagingData(productUomPagingDataParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<AddProductResponse>> addProduct(AddProductParameter addProductParameter) {
    return productRemoteDataSource.addProduct(addProductParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<EditProductResponse>> editProduct(EditProductParameter editProductParameter) {
    return productRemoteDataSource.editProduct(editProductParameter).mapToLoadDataResult();
  }
}