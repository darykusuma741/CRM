import 'package:crm/common/ext/future_ext.dart';
import 'package:crm/common/ext/load_data_result_ext.dart';
import 'package:crm/common/ext/response_wrapper_ext.dart';
import 'package:crm/common/ext/string_ext.dart';
import 'package:crm/data/mapping/quotation_entity_mapping_ext.dart';

import '../../../../common/constants/graph_ql_query_constants.dart';
import '../../../../common/error/message_error.dart';
import '../../../../common/graphql/graph_ql.dart';
import '../../../../common/graphql/graph_ql_mutate_parameter.dart';
import '../../../../common/graphql/graph_ql_query_parameter.dart';
import '../../../../common/helper/date_helper.dart';
import '../../../../common/helper/login_helper.dart';
import '../../../../common/processing/dummy_future_processing.dart';
import '../../../../common/processing/future_processing.dart';
import '../../../../common/processing/graph_ql_client_future_processing.dart';
import '../../../../common/responsewrapper/response_wrapper.dart';
import '../../../common/load_data_result/load_data_result.dart';
import '../../../common/memory_local_data_storage.dart';
import '../../models/addquotation/add_quotation_parameter.dart';
import '../../models/addquotation/add_quotation_response.dart';
import '../../models/addquotationsaleorder/add_quotation_sale_order_parameter.dart';
import '../../models/addquotationsaleorder/add_quotation_sale_order_response.dart';
import '../../models/detailamountquotationproduct/detail_amount_quotation_product_parameter.dart';
import '../../models/detailamountquotationproduct/detail_amount_quotation_product_response.dart';
import '../../models/editquotation/edit_quotation_parameter.dart';
import '../../models/editquotation/edit_quotation_response.dart';
import '../../models/editquotationsaleorder/edit_quotation_sale_order_parameter.dart';
import '../../models/editquotationsaleorder/edit_quotation_sale_order_response.dart';
import '../../models/paging/paging_data.dart';
import '../../models/quotation_category.dart';
import '../../models/quotation_stage.dart';
import '../../models/quotationapplyvouchercode/quotation_apply_voucher_code_parameter.dart';
import '../../models/quotationapplyvouchercode/quotation_apply_voucher_code_response.dart';
import '../../models/quotationcancel/quotation_cancel_parameter.dart';
import '../../models/quotationcancel/quotation_cancel_response.dart';
import '../../models/quotationcategory/quotation_category_parameter.dart';
import '../../models/quotationcategory/quotation_category_response.dart';
import '../../models/quotationconfirm/quotation_confirm_parameter.dart';
import '../../models/quotationconfirm/quotation_confirm_response.dart';
import '../../models/quotationcountbasedcustomer/quotation_count_based_customer_parameter.dart';
import '../../models/quotationcountbasedcustomer/quotation_count_based_customer_response.dart';
import '../../models/quotationdetail/quotation_detail_parameter.dart';
import '../../models/quotationdetail/quotation_detail_response.dart';
import '../../models/quotationpagingdata/quotation_paging_data_parameter.dart';
import '../../models/quotationpagingdata/quotation_paging_data_response.dart';
import '../../models/quotationproduct/quotation_product_parameter.dart';
import '../../models/quotationproduct/quotation_product_response.dart';
import '../../models/quotationproducttotalprice/quotation_product_total_price_parameter.dart';
import '../../models/quotationproducttotalprice/quotation_product_total_price_response.dart';
import '../../models/quotationreset/quotation_reset_parameter.dart';
import '../../models/quotationreset/quotation_reset_response.dart';
import '../../models/quotationselectvoucherreward/quotation_select_voucher_reward_parameter.dart';
import '../../models/quotationselectvoucherreward/quotation_select_voucher_reward_response.dart';
import '../../models/quotationstage/quotation_stage_parameter.dart';
import '../../models/quotationstage/quotation_stage_response.dart';
import '../../models/quotationupdatedataafterapplyvoucher/quotation_update_data_after_apply_voucher_parameter.dart';
import '../../models/quotationupdatedataafterapplyvoucher/quotation_update_data_after_apply_voucher_response.dart';
import '../../models/short_quotation.dart';
import '../../models/totalpriceofquotation/total_price_of_quotation_parameter.dart';
import '../../models/totalpriceofquotation/total_price_of_quotation_response.dart';
import 'quotation_remote_data_source.dart';

class DefaultQuotationRemoteDataSource implements QuotationRemoteDataSource {
  final GraphQL graphQL;

  DefaultQuotationRemoteDataSource({
    required this.graphQL
  });

  @override
  FutureProcessing<QuotationCountBasedCustomerResponse> quotationCountBasedCustomer(QuotationCountBasedCustomerParameter quotationCountBasedCustomerParameter) {
    return GraphQLFutureProcessing((_) async {
      return graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().mutationQuotationCountBasedCustomer(
            quotationCountBasedCustomerParameter.customerId
          )
        )
      ).map<QuotationCountBasedCustomerResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToQuotationCountBasedCustomerResponse()
      );
    });
  }

  @override
  FutureProcessing<DetailAmountQuotationProductResponse> detailAmountQuotationProduct(DetailAmountQuotationProductParameter detailAmountQuotationProductParameter) {
    return GraphQLFutureProcessing((_) async {
      return graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().queryDetailAmountQuotationProduct(
            detailAmountQuotationProductParameter.quotationId
          )
        )
      ).map<DetailAmountQuotationProductResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToDetailAmountQuotationProductResponse()
      );
    });
  }

  @override
  FutureProcessing<QuotationCategoryResponse> quotationCategory(QuotationCategoryParameter quotationCategoryParameter) {
    return DummyFutureProcessing((_) async {
      return QuotationCategoryResponse(
        quotationCategoryList: <QuotationCategory>[
          QuotationCategory(
            id: "-1",
            name: "All",
            value: "",
            count: 0
          ),
          QuotationCategory(
            id: "1",
            name: "Quotation",
            value: "draft",
            count: 0
          ),
          QuotationCategory(
            id: "2",
            name: "Quotation Sent",
            value: "sent",
            count: 0
          ),
          QuotationCategory(
            id: "3",
            name: "Sales Order",
            value: "sale",
            count: 0
          ),
          QuotationCategory(
            id: "3",
            name: "Cancelled",
            value: "cancel",
            count: 0
          ),
        ]
      );
    });
  }

  @override
  FutureProcessing<QuotationPagingDataResponse> quotationPagingData(QuotationPagingDataParameter quotationPagingDataParameter) {
    return GraphQLFutureProcessing((_) async {
      var quotationCategoryList = (await quotationCategory(QuotationCategoryParameter()).future()).quotationCategoryList;
      Map<String, dynamic> quotationEmptyTitleAndMessageMap = () {
        var quotationPagingDataType = quotationPagingDataParameter.quotationPagingDataType;
        if (quotationPagingDataType is WithCategoryQuotationPagingDataType) {
          var quotationCategory = quotationPagingDataType.quotationCategory;
          if (quotationCategory.id != "-1") {
            var quotationCategoryValue = quotationCategory.value.toLowerCase();
            if (quotationCategoryValue == "draft") {
              return <String, dynamic>{
                "title": "No Quotations Available",
                "message": "You don't have any quotations yet.\r\nPlease add one first."
              };
            } else if (quotationCategoryValue == "sent") {
              return <String, dynamic>{
                "title": "No Sent Quotations",
                "message": "You don't have any sent quotations.\r\nPlease confirm a quotation first to send it."
              };
            } else if (quotationCategoryValue == "sale") {
              return <String, dynamic>{
                "title": "No Sales Orders",
                "message": "You don't have any sales orders yet."
              };
            } else if (quotationCategoryValue == "cancel") {
              return <String, dynamic>{
                "title": "No Cancelled Quotation",
                "message": "You don't have any cancelled orders."
              };
            }
          }
        }
        return <String, dynamic>{
          "title": "No Quotations Available",
          "message": "You don't have any quotations yet.\r\nPlease add one first."
        };
      }();
      String quotationEmptyTitle = ResponseWrapper(quotationEmptyTitleAndMessageMap["title"]).mapFromResponseToNonNullableString();
      String quotationEmptyMessage = ResponseWrapper(quotationEmptyTitleAndMessageMap["message"]).mapFromResponseToNonNullableString();
      var memoryLocalDataStorage = quotationPagingDataParameter.memoryLocalDataStorage;
      var quotationPagingDataResponse = await () async {
        var quotationPagingDataType = quotationPagingDataParameter.quotationPagingDataType;
        if (quotationPagingDataType is InitialQuotationPagingDataType) {
          var quotationPagingDataResponse = await graphQL.query(
            GraphQLQueryParameter(
              queryString: () {
                var quotationPagingDataInputType = quotationPagingDataParameter.quotationPagingDataInputType;
                if (quotationPagingDataInputType is BasedPipelineQuotationPagingDataInputType) {
                  return GraphQLQueryConstants().queryQuotationPagingBasedPipeline(
                    userId: (LoginHelper.getLoginData()?.id).toEmptyStringNonNull,
                    pipelineId: quotationPagingDataInputType.pipelineId
                  );
                } else if (quotationPagingDataInputType is BasedCustomerQuotationPagingDataInputType) {
                  return GraphQLQueryConstants().queryQuotationPagingBasedCustomer(
                    userId: (LoginHelper.getLoginData()?.id).toEmptyStringNonNull,
                    customerId: quotationPagingDataInputType.customerId
                  );
                } else {
                  return GraphQLQueryConstants().queryQuotationPaging(
                    (LoginHelper.getLoginData()?.id).toEmptyStringNonNull
                  );
                }
              }(),
            )
          ).map<QuotationPagingDataResponse>(
            onMap: (value) => value.graphQLWrapResponse().mapFromResponseToQuotationPagingDataResponse(quotationCategoryList)
          );
          if (quotationPagingDataParameter.page == 1) {
            memoryLocalDataStorage.shortQuotationListLoadDataResult = NoLoadDataResult<List<ShortQuotation>>();
          }
          if (!memoryLocalDataStorage.shortQuotationListLoadDataResult.isSuccess) {
            memoryLocalDataStorage.shortQuotationListLoadDataResult = SuccessLoadDataResult<List<ShortQuotation>>(
              value: quotationPagingDataResponse.shortQuotationPagingData.data
            );
          } else {
            memoryLocalDataStorage.shortQuotationListLoadDataResult.resultIfSuccess!.addAll(
              quotationPagingDataResponse.shortQuotationPagingData.data
            );
          }
          return quotationPagingDataResponse;
        } else {
          if (memoryLocalDataStorage.shortQuotationListLoadDataResult.isSuccess) {
            var shortQuotationList = memoryLocalDataStorage.shortQuotationListLoadDataResult.resultIfSuccess!;
            var filteredShortQuotationList = () {
              if (quotationPagingDataType is WithCategoryQuotationPagingDataType) {
                return shortQuotationList.where((shortQuotation) {
                  var currentQuotationCategory = quotationPagingDataType.quotationCategory;
                  if (currentQuotationCategory.id == "-1") {
                    return true;
                  }
                  return shortQuotation.status.toLowerCase() == quotationPagingDataType.quotationCategory.value.toLowerCase();
                }).toList();
              } else {
                return shortQuotationList;
              }
            }();
            if (filteredShortQuotationList.isEmpty) {
              throw MessageError(
                title: quotationEmptyTitle,
                message: quotationEmptyMessage
              );
            }
            return QuotationPagingDataResponse(
              shortQuotationPagingData: PagingData(
                page: 1,
                data: filteredShortQuotationList
              )
            );
          }
          throw MessageError(
            title: "All Quotation Not Loaded",
            message: "All Quotation must be loaded"
          );
        }
      }();
      var quotationPagingData = quotationPagingDataResponse.shortQuotationPagingData;
      if (quotationPagingData.page == 1 && quotationPagingData.nextPage == null) {
        quotationPagingData.data = List.of(
          quotationPagingData.data.where(
            (value) => value.name.toLowerCase().contains(
              quotationPagingDataParameter.search.toLowerCase()
            )
          )
        );
        if (quotationPagingData.data.isEmpty) {
          throw MessageError(
            title: quotationEmptyTitle,
            message: quotationEmptyMessage
          );
        }
      }
      return quotationPagingDataResponse;
    });
  }

  @override
  FutureProcessing<QuotationDetailResponse> quotationDetail(QuotationDetailParameter quotationDetailParameter) {
    return GraphQLFutureProcessing((_) {
      return graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().mutationQuotationDetail(
            quotationDetailParameter.quotationId
          )
        )
      ).map<QuotationDetailResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToQuotationDetailResponse()
      );
    });
  }

  @override
  FutureProcessing<EditQuotationSaleOrderResponse> editQuotationSaleOrder(EditQuotationSaleOrderParameter editQuotationSaleOrderParameter) {
    return GraphQLFutureProcessing((_) {
      return graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().mutationEditQuotationSaleOrderSeparately(
            id: editQuotationSaleOrderParameter.id,
            shortQuotationProduct: editQuotationSaleOrderParameter.shortQuotationProduct
          )
        )
      ).map<EditQuotationSaleOrderResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToEditQuotationSaleOrderResponse()
      );
    });
  }

  @override
  FutureProcessing<AddQuotationSaleOrderResponse> addQuotationSaleOrder(AddQuotationSaleOrderParameter addQuotationSaleOrderParameter) {
    return GraphQLFutureProcessing((_) {
      return graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().mutationAddQuotationSaleOrderSeparately(
            orderId: addQuotationSaleOrderParameter.quotationId,
            shortQuotationProduct: addQuotationSaleOrderParameter.shortQuotationProduct
          )
        )
      ).map<AddQuotationSaleOrderResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToAddQuotationSaleOrderResponse()
      );
    });
  }

  @override
  FutureProcessing<AddQuotationResponse> addQuotation(AddQuotationParameter addQuotationParameter) {
    return GraphQLFutureProcessing((_) async {
      var addQuotationSeparatelyOrderId = await graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().mutationAddQuotationSeparately(
            partnerId: addQuotationParameter.partnerId,
            opportunityId: addQuotationParameter.pipelineId,
            validityDate: addQuotationParameter.validityDate,
            pricelistId: addQuotationParameter.pricelistId,
            paymentTermId: addQuotationParameter.paymentTermId,
          )
        )
      ).map<String>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToAddQuotationSalesId()
      );

      var shortQuotationProductList = addQuotationParameter.shortQuotationProductList;
      for (var shortQuotationProduct in shortQuotationProductList) {
        await graphQL.mutate(
          GraphQLMutateParameter(
            queryString: GraphQLQueryConstants().mutationAddQuotationSaleOrderSeparately(
              orderId: addQuotationSeparatelyOrderId,
              shortQuotationProduct: shortQuotationProduct
            )
          )
        ).map<bool>(
          onMap: (value) => true
        );
      }

      return AddQuotationResponse();
    });
  }

  @override
  FutureProcessing<EditQuotationResponse> editQuotation(EditQuotationParameter editQuotationParameter) {
    return GraphQLFutureProcessing((parameter) async {
      await graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().mutationEditQuotationSeparately(
            id: editQuotationParameter.id,
            partnerId: editQuotationParameter.partnerId,
            opportunityId: editQuotationParameter.pipelineId,
            validityDate: editQuotationParameter.validityDate,
            pricelistId: editQuotationParameter.pricelistId,
            paymentTermId: editQuotationParameter.paymentTermId,
          )
        )
      ).map<String>(
        onMap: (value) => ""
      );
      return EditQuotationResponse();
    });
  }

  @override
  FutureProcessing<QuotationStageResponse> quotationStage(QuotationStageParameter quotationStageParameter) {
    return DummyFutureProcessing((_) async {
      var quotationCategoryResponse = await quotationCategory(QuotationCategoryParameter()).future();
      return QuotationStageResponse(
        quotationStageList: quotationCategoryResponse.quotationCategoryList.where(
          (quotationCategory) => quotationCategory.value.toLowerCase() != "cancel" && quotationCategory.id != "-1"
        ).map<QuotationStage>(
          (quotationCategory) => QuotationStage(
            id: quotationCategory.id,
            name: quotationCategory.name,
            value: quotationCategory.value
          )
        ).toList()
      );
    });
  }

  @override
  FutureProcessing<QuotationProductResponse> quotationProduct(QuotationProductParameter quotationProductParameter) {
    return GraphQLFutureProcessing((_) async {
      var quotationProductResponse = await graphQL.query(
        GraphQLQueryParameter(
          queryString: GraphQLQueryConstants().queryQuotationDetailProductList(
            quotationProductParameter.quotationId
          )
        )
      ).map<QuotationProductResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToQuotationProductResponse()
      );
      var shortQuotationProductList = quotationProductResponse.shortQuotationProductList;
      if (shortQuotationProductList.isEmpty) {
        throw MessageError(
          title: "Product Empty",
          message: "Product is empty"
        );
      }
      return quotationProductResponse;
    });
  }

  @override
  FutureProcessing<QuotationProductTotalPriceResponse> quotationProductTotalPrice(QuotationProductTotalPriceParameter quotationProductTotalPriceParameter) {
    return GraphQLFutureProcessing((_) {
      return graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().mutationQuotationDetailProductTotalPrice(
            quotationProductTotalPriceParameter.quotationId
          )
        )
      ).map<QuotationProductTotalPriceResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToQuotationProductTotalPriceResponse()
      );
    });
  }

  @override
  FutureProcessing<QuotationConfirmResponse> quotationConfirm(QuotationConfirmParameter quotationConfirmParameter) {
    return GraphQLFutureProcessing((_) {
      return graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().mutationQuotationConfirm(
            quotationConfirmParameter.quotationId
          )
        )
      ).map<QuotationConfirmResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToQuotationConfirmResponse()
      );
    });
  }

  @override
  FutureProcessing<QuotationCancelResponse> quotationCancel(QuotationCancelParameter quotationCategoryParameter) {
    return GraphQLFutureProcessing((_) {
      return graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().mutationQuotationCancel(
            quotationCategoryParameter.quotationId
          )
        )
      ).map<QuotationCancelResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToQuotationCancelResponse()
      );
    });
  }

  @override
  FutureProcessing<QuotationResetResponse> quotationReset(QuotationResetParameter quotationResetParameter) {
    return GraphQLFutureProcessing((_) {
      return graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().mutationQuotationReset(
            quotationResetParameter.quotationId
          )
        )
      ).map<QuotationResetResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToQuotationResetResponse()
      );
    });
  }

  @override
  FutureProcessing<TotalPriceOfQuotationResponse> totalPriceOfQuotation(TotalPriceOfQuotationParameter totalPriceOfQuotationParameter) {
    return GraphQLFutureProcessing((parameter) async {
      DateTime nowDateTime = DateTime.now();
      List<ShortQuotation> salesOrderQuotationList = [];
      try {
        salesOrderQuotationList = await quotationPagingData(
          QuotationPagingDataParameter(
            page: 1,
            quotationPagingDataType: InitialQuotationPagingDataType(),
            quotationPagingDataInputType: totalPriceOfQuotationParameter.quotationPagingDataInputType,
            memoryLocalDataStorage: MemoryLocalDataStorage()
          )
        ).future(
          parameter: parameter
        ).map<List<ShortQuotation>>(
          onMap: (value) => value.shortQuotationPagingData.data.where(
            (shortQuotation) => shortQuotation.status.toLowerCase() != "sale" && shortQuotation.status.toLowerCase() != "cancel"
          ).toList()
        );
      } catch (e) {
        // Nope
      }
      double totalSalesOrder = () {
        double result = 0.0;
        var standardDateFormat21 = DateHelper.standardDateFormat21;
        var nowDateString = standardDateFormat21.format(nowDateTime);
        for (var salesOrderQuotation in salesOrderQuotationList) {
          if (salesOrderQuotation.dateOrderDate != null) {
            var dateOrderString = standardDateFormat21.format(
              salesOrderQuotation.dateOrderDate!
            );
            if (nowDateString == dateOrderString) {
              result += salesOrderQuotation.pricelistValue;
            }
          }
        }
        return result;
      }();
      Map<String, double> shortQuotationMap = () {
        var result = <String, double>{};
        for (var salesOrderQuotation in salesOrderQuotationList) {
          var dateOrderDate = salesOrderQuotation.dateOrderDate;
          if (dateOrderDate != null) {
            var dateOrderString = DateHelper.standardDateFormat21.format(dateOrderDate);
            if (result.containsKey(dateOrderString)) {
              var shortQuotationDouble = result[dateOrderString] ?? 0.0;
              shortQuotationDouble += salesOrderQuotation.pricelistValue;
              result[dateOrderString] = shortQuotationDouble;
            } else {
              result[dateOrderString] = salesOrderQuotation.pricelistValue;
            }
          }
        }
        return result;
      }();
      shortQuotationMap = Map.fromEntries(
        shortQuotationMap.entries.toList()..sort((a, b) => b.key.compareTo(a.key)),
      );
      double? nowValue;
      double? lastValue;
      double differentTotalSale = 0;
      var resultString = shortQuotationMap.keys.where(
        (value) => DateHelper.standardDateFormat21.format(nowDateTime) == value
      ).firstOrNull;
      if (resultString.isNotEmptyString) {
        nowValue = shortQuotationMap[resultString];
        var keysList = shortQuotationMap.keys.toList();
        var indexNow = keysList.indexWhere(
          (value) => resultString == value
        );
        if (indexNow > -1) {
          var newIndex = indexNow + 1;
          if (newIndex <= shortQuotationMap.keys.length - 1) {
            lastValue = shortQuotationMap[keysList[newIndex]];
          }
        }
      }
      double percentage = 0;
      differentTotalSale = 0;
      if (nowValue != null && lastValue != null) {
        differentTotalSale = nowValue - lastValue;
        percentage = lastValue == 0 ? 0 : (100.0 * differentTotalSale / lastValue);
      }
      return TotalPriceOfQuotationResponse(
        currentValue: totalSalesOrder,
        percentage: percentage,
        increasedValue: differentTotalSale,
        status: () {
          if (differentTotalSale > 0) {
            return 1;
          } else if (differentTotalSale < 0) {
            return -1;
          } else {
            return 0;
          }
        }()
      );
    });
  }

  @override
  FutureProcessing<QuotationApplyVoucherCodeResponse> quotationApplyVoucherCode(QuotationApplyVoucherCodeParameter quotationApplyVoucherCodeParameter) {
    return GraphQLFutureProcessing((parameter) async {
      return graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().mutationApplyVoucher(
            quotationId: quotationApplyVoucherCodeParameter.quotationId,
            voucherCode: quotationApplyVoucherCodeParameter.voucherCode
          )
        )
      ).map<QuotationApplyVoucherCodeResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToQuotationApplyVoucherCodeResponse()
      );
    });
  }

  @override
  FutureProcessing<QuotationSelectVoucherRewardResponse> quotationSelectVoucherReward(QuotationSelectVoucherRewardParameter quotationSelectVoucherRewardParameter) {
    return GraphQLFutureProcessing((parameter) async {
      return graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().mutationSelectAvailableRewards(
            quotationId: quotationSelectVoucherRewardParameter.quotationId,
            rewardId: quotationSelectVoucherRewardParameter.rewardId,
            voucherCode: quotationSelectVoucherRewardParameter.voucherCode,
          )
        )
      ).map<QuotationSelectVoucherRewardResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToQuotationSelectVoucherRewardResponse()
      );
    });
  }

  @override
  FutureProcessing<QuotationUpdateDataAfterApplyVoucherResponse> quotationUpdateDataAfterApplyVoucher(QuotationUpdateDataAfterApplyVoucherParameter quotationUpdateDataAfterApplyVoucherParameter) {
    return GraphQLFutureProcessing((parameter) async {
      return graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().mutationUpdateQuotationDataAfterApplyVoucher(
            quotationId: quotationUpdateDataAfterApplyVoucherParameter.quotationId
          )
        )
      ).map<QuotationUpdateDataAfterApplyVoucherResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToQuotationUpdateDataAfterApplyVoucherResponse()
      );
    });
  }
}