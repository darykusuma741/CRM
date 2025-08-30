import 'package:crm/common/ext/future_ext.dart';
import 'package:crm/common/ext/load_data_result_ext.dart';
import 'package:crm/common/ext/response_wrapper_ext.dart';
import 'package:crm/data/mapping/product_entity_mapping_ext.dart';

import '../../../../common/constants/graph_ql_query_constants.dart';
import '../../../../common/error/message_error.dart';
import '../../../../common/graphql/graph_ql.dart';
import '../../../../common/graphql/graph_ql_mutate_parameter.dart';
import '../../../../common/graphql/graph_ql_query_parameter.dart';
import '../../../../common/helper/login_helper.dart';
import '../../../../common/processing/future_processing.dart';
import '../../../../common/processing/graph_ql_client_future_processing.dart';
import '../../../common/load_data_result/load_data_result.dart';
import '../../models/addproduct/add_product_parameter.dart';
import '../../models/addproduct/add_product_response.dart';
import '../../models/editproduct/edit_product_parameter.dart';
import '../../models/editproduct/edit_product_response.dart';
import '../../models/paging/paging_data.dart';
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
import '../../models/short_product.dart';
import 'product_remote_data_source.dart';

class DefaultProductRemoteDataSource implements ProductRemoteDataSource {
  final GraphQL graphQL;

  DefaultProductRemoteDataSource({
    required this.graphQL
  });

  @override
  FutureProcessing<ProductPagingDataResponse> productPagingData(ProductPagingDataParameter productPagingDataParameter) {
    return GraphQLFutureProcessing((_) async {
      String productEmptyTitle = "Product Empty";
      String productEmptyMessage = "Product is empty";
      var memoryLocalDataStorage = productPagingDataParameter.memoryLocalDataStorage;
      var productPagingDataResponse = await () async {
        var productPagingDataType = productPagingDataParameter.productPagingDataType;
        if (productPagingDataType is InitialProductPagingDataType) {
          var productPagingDataResponse = await graphQL.query(
            GraphQLQueryParameter(
              queryString: GraphQLQueryConstants().mutationProductPaging
            )
          ).map<ProductPagingDataResponse>(
            onMap: (value) => value.graphQLWrapResponse().mapFromResponseToProductPagingDataResponse()
          );
          if (productPagingDataParameter.page == 1) {
            memoryLocalDataStorage.shortProductListLoadDataResult = NoLoadDataResult<List<ShortProduct>>();
          }
          if (!memoryLocalDataStorage.shortProductListLoadDataResult.isSuccess) {
            memoryLocalDataStorage.shortProductListLoadDataResult = SuccessLoadDataResult<List<ShortProduct>>(
              value: productPagingDataResponse.shortProductPagingData.data
            );
          } else {
            memoryLocalDataStorage.shortProductListLoadDataResult.resultIfSuccess!.addAll(
              productPagingDataResponse.shortProductPagingData.data
            );
          }
          return productPagingDataResponse;
        } else {
          if (memoryLocalDataStorage.shortProductListLoadDataResult.isSuccess) {
            var shortProductList = memoryLocalDataStorage.shortProductListLoadDataResult.resultIfSuccess!;
            if (shortProductList.isEmpty) {
              throw MessageError(
                title: productEmptyTitle,
                message: productEmptyMessage
              );
            }
            return ProductPagingDataResponse(
              shortProductPagingData: PagingData(
                page: 1,
                data: shortProductList
              )
            );
          }
          throw MessageError(
            title: "All Product Not Loaded",
            message: "All product must be loaded"
          );
        }
      }();
      var productPagingData = productPagingDataResponse.shortProductPagingData;
      if (productPagingData.page == 1 && productPagingData.nextPage == null) {
        productPagingData.data = List.of(
          productPagingData.data.where(
            (value) => value.name.toLowerCase().contains(
              productPagingDataParameter.search.toLowerCase()
            )
          )
        );
        if (productPagingData.data.isEmpty) {
          throw MessageError(
            title: productEmptyTitle,
            message: productEmptyMessage
          );
        }
      }
      return productPagingDataResponse;
    });
  }

  @override
  FutureProcessing<ProductDetailResponse> productDetail(ProductDetailParameter productDetailParameter) {
    return GraphQLFutureProcessing((_) async {
      return graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().mutationProductDetail(productDetailParameter.productId),
        )
      ).map<ProductDetailResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToProductDetailResponse()
      );
    });
  }

  @override
  FutureProcessing<ProductPackagingPagingDataResponse> productPackagingPagingData(ProductPackagingPagingDataParameter productPackagingPagingDataParameter) {
    return GraphQLFutureProcessing((_) async {
      return graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().mutationProductPackagingPaging,
        )
      ).map<ProductPackagingPagingDataResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToProductPackagingPagingDataResponse()
      );
    });
  }

  @override
  FutureProcessing<ProductTaxPagingDataResponse> productTaxPagingData(ProductTaxPagingDataParameter productTaxPagingDataParameter) {
    return GraphQLFutureProcessing((_) async {
      return graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().mutationProductTaxesPaging,
        )
      ).map<ProductTaxPagingDataResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToProductTaxPagingDataResponse()
      );
    });
  }

  @override
  FutureProcessing<ProductUomPagingDataResponse> productUomPagingData(ProductUomPagingDataParameter productTaxPagingDataParameter) {
    return GraphQLFutureProcessing((_) async {
      return graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().queryUomList,
        )
      ).map<ProductUomPagingDataResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToProductUomPagingDataResponse()
      );
    });
  }

  @override
  FutureProcessing<AddProductResponse> addProduct(AddProductParameter addProductParameter) {
    return GraphQLFutureProcessing((_) async {
      return graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().mutationAddProduct(
            name: addProductParameter.name,
            description: addProductParameter.description,
            listPrice: addProductParameter.listPrice,
            uomId: addProductParameter.uomId
          ),
        )
      ).map<AddProductResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToAddProductResponse()
      );
    });
  }

  @override
  FutureProcessing<EditProductResponse> editProduct(EditProductParameter editProductParameter) {
    throw UnimplementedError();
  }
}