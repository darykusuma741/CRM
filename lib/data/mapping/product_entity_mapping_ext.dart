import 'package:crm/common/ext/response_wrapper_ext.dart';
import 'package:crm/data/mapping/paging_mapping_ext.dart';

import '../../common/error/message_error.dart';
import '../../common/responsewrapper/response_wrapper.dart';
import '../models/addproduct/add_product_response.dart';
import '../models/product_detail.dart';
import '../models/productdetail/product_detail_response.dart';
import '../models/productpackagingpagingdata/product_packaging_paging_data_response.dart';
import '../models/productpagingdata/product_paging_data_response.dart';
import '../models/producttaxpagingdata/product_tax_paging_data_response.dart';
import '../models/productuompagingdata/product_uom_paging_data_response.dart';
import '../models/short_product.dart';
import '../models/short_product_packaging.dart';
import '../models/short_product_tax.dart';
import '../models/short_product_uom.dart';

extension ProductEntityMappingExt on ResponseWrapper {
  ProductPagingDataResponse mapFromResponseToProductPagingDataResponse() {
    var shortProductPagingData = ResponseWrapper(response).mapFromResponseToPagingData<ShortProduct>(
      (dataResponse) => ResponseWrapper(dataResponse).mapFromResponseToList(
        (value) => ResponseWrapper(value).mapFromResponseToShortProduct(),
      ),
      dataFieldName: "result"
    );
    return ProductPagingDataResponse(
      shortProductPagingData: shortProductPagingData
    );
  }

  ProductDetailResponse mapFromResponseToProductDetailResponse() {
    var productDetailResponseWrapper = ResponseWrapper(response).mapFromResponseToDataResponseWrapper(dataFieldName: "result");
    var responseList = productDetailResponseWrapper.mapFromResponseToList((dataResponse) => dataResponse);
    if (responseList.isEmpty) {
      throw MessageError(
        title: "Product Detail Not Found",
        message: "Product detail is not found"
      );
    }
    return ProductDetailResponse(
      productDetail: ResponseWrapper(responseList.first).mapFromResponseToProductDetail()
    );
  }

  ShortProduct mapFromResponseToShortProduct() {
    return ShortProduct(
      id: ResponseWrapper(response["id"]).mapFromResponseToNonNullableString(),
      name: ResponseWrapper(response["name"]).mapFromResponseToNonNullableString(),
      description: ResponseWrapper(response["description"]).mapFromResponseToNonNullableString(),
      listPrice: ResponseWrapper(response["list_price"]).mapFromResponseToNonNullableDouble(),
      unitOfMeasurementId: ResponseWrapper(response["uom_id"]).getArrayData(0).mapFromResponseToNonNullableString(),
      unitOfMeasurementName: ResponseWrapper(response["uom_id"]).getArrayData(1).mapFromResponseToNonNullableString()
    );
  }

  ProductDetail mapFromResponseToProductDetail() {
    return ProductDetail(
      id: ResponseWrapper(response["id"]).mapFromResponseToNonNullableString(),
      name: ResponseWrapper(response["name"]).mapFromResponseToNonNullableString(),
      description: ResponseWrapper(response["description"]).mapFromResponseToNonNullableString(),
      listPrice: ResponseWrapper(response["list_price"]).mapFromResponseToNonNullableString(),
      unitOfMeasurementId: ResponseWrapper(response["uom_id"]).getArrayData(0).mapFromResponseToNonNullableString(),
      unitOfMeasurementName: ResponseWrapper(response["uom_id"]).getArrayData(1).mapFromResponseToNonNullableString()
    );
  }

  ProductTaxPagingDataResponse mapFromResponseToProductTaxPagingDataResponse() {
    var shortProductTaxPagingData = ResponseWrapper(response).mapFromResponseToPagingData<ShortProductTax>(
      (dataResponse) => ResponseWrapper(dataResponse).mapFromResponseToList(
        (value) => ResponseWrapper(value).mapFromResponseToShortProductTax(),
      ),
      dataFieldName: "result"
    );
    return ProductTaxPagingDataResponse(
      shortProductTaxPagingData: shortProductTaxPagingData
    );
  }

  ShortProductTax mapFromResponseToShortProductTax() {
    return ShortProductTax(
      id: ResponseWrapper(response["id"]).mapFromResponseToNonNullableString(),
      name: ResponseWrapper(response["name"]).mapFromResponseToNonNullableString()
    );
  }

  ProductUomPagingDataResponse mapFromResponseToProductUomPagingDataResponse() {
    var shortProductUomPagingData = ResponseWrapper(response).mapFromResponseToPagingData<ShortProductUom>(
      (dataResponse) => ResponseWrapper(dataResponse).mapFromResponseToList(
        (value) => ResponseWrapper(value).mapFromResponseToShortProductUom(),
      ),
      dataFieldName: "UomUom"
    );
    return ProductUomPagingDataResponse(
      shortProductUomPagingData: shortProductUomPagingData
    );
  }

  ShortProductUom mapFromResponseToShortProductUom() {
    var categoryIdResponseWrapper = ResponseWrapper(response).mapFromResponseToDataResponseWrapper(
      dataFieldName: "category_id"
    );
    return ShortProductUom(
      id: ResponseWrapper(response["id"]).mapFromResponseToNonNullableString(),
      name: ResponseWrapper(response["name"]).mapFromResponseToNonNullableString(),
      categoryId: categoryIdResponseWrapper.mapFromResponseToDataResponseWrapper(
        dataFieldName: "id"
      ).mapFromResponseToNonNullableString(),
      categoryName: categoryIdResponseWrapper.mapFromResponseToDataResponseWrapper(
        dataFieldName: "name"
      ).mapFromResponseToNonNullableString(),
    );
  }

  ProductPackagingPagingDataResponse mapFromResponseToProductPackagingPagingDataResponse() {
    var shortProductPackagingPagingData = ResponseWrapper(response).mapFromResponseToPagingData<ShortProductPackaging>(
      (dataResponse) => ResponseWrapper(dataResponse).mapFromResponseToList(
        (value) => ResponseWrapper(value).mapFromResponseToShortProductPackaging(),
      ),
      dataFieldName: "result"
    );
    return ProductPackagingPagingDataResponse(
      shortProductPackagingPagingData: shortProductPackagingPagingData
    );
  }

  ShortProductPackaging mapFromResponseToShortProductPackaging() {
    return ShortProductPackaging(
      id: ResponseWrapper(response["id"]).mapFromResponseToNonNullableString(),
      name: ResponseWrapper(response["name"]).mapFromResponseToNonNullableString()
    );
  }

  AddProductResponse mapFromResponseToAddProductResponse() {
    return AddProductResponse();
  }
}