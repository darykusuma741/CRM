import 'package:crm/common/ext/response_wrapper_ext.dart';
import 'package:crm/data/mapping/paging_mapping_ext.dart';

import '../../common/error/message_error.dart';
import '../../common/helper/date_helper.dart';
import '../../common/helper/string_helper.dart';
import '../../common/responsewrapper/response_wrapper.dart';
import '../models/addquotation/add_quotation_response.dart';
import '../models/addquotationsaleorder/add_quotation_sale_order_response.dart';
import '../models/address_data.dart';
import '../models/detailamountquotationproduct/detail_amount_quotation_product_content.dart';
import '../models/detailamountquotationproduct/detail_amount_quotation_product_response.dart';
import '../models/editquotation/edit_quotation_response.dart';
import '../models/editquotationsaleorder/edit_quotation_sale_order_response.dart';
import '../models/quotation_category.dart';
import '../models/quotation_detail.dart';
import '../models/quotationapplyvouchercode/quotation_apply_voucher_code_response.dart';
import '../models/quotationcancel/quotation_cancel_response.dart';
import '../models/quotationcategory/quotation_category_response.dart';
import '../models/quotationconfirm/quotation_confirm_response.dart';
import '../models/quotationcountbasedcustomer/quotation_count_based_customer_response.dart';
import '../models/quotationdetail/quotation_detail_response.dart';
import '../models/quotationpagingdata/quotation_paging_data_response.dart';
import '../models/quotationproduct/quotation_product_response.dart';
import '../models/quotationproducttotalprice/quotation_product_total_price_response.dart';
import '../models/quotationreset/quotation_reset_response.dart';
import '../models/quotationselectvoucherreward/quotation_select_voucher_reward_response.dart';
import '../models/quotationupdatedataafterapplyvoucher/quotation_update_data_after_apply_voucher_response.dart';
import '../models/short_quotation.dart';
import '../models/short_quotation_product.dart';
import '../models/voucher_reward.dart';

extension QuotationEntityMappingExt on ResponseWrapper {
  QuotationCategory mapFromResponseToQuotationCategory() {
    return QuotationCategory(
      id: ResponseWrapper(response["id"]).mapFromResponseToNonNullableString(),
      value: ResponseWrapper(response["value"]).mapFromResponseToNonNullableString(),
      name: ResponseWrapper(response["name"]).mapFromResponseToNonNullableString(),
      count: ResponseWrapper(response["count"]).mapFromResponseToNonNullableInt()
    );
  }

  QuotationPagingDataResponse mapFromResponseToQuotationPagingDataResponse(List<QuotationCategory> quotationCategoryList) {
    ResponseWrapper resultResponseWrapper = ResponseWrapper(response).mapFromResponseToDataResponseWrapper(dataFieldName: "SaleOrder");
    var shortQuotationPagingData = resultResponseWrapper.mapFromResponseToPagingData<ShortQuotation>(
      (dataResponse) => ResponseWrapper(dataResponse).mapFromResponseToList(
        (value) => ResponseWrapper(value).mapFromResponseToShortQuotation(quotationCategoryList)
      ),
    );
    return QuotationPagingDataResponse(
      shortQuotationPagingData: shortQuotationPagingData
    );
  }

  ShortQuotation mapFromResponseToShortQuotation(List<QuotationCategory> quotationCategoryList) {
    String status = ResponseWrapper(response["state"]).mapFromResponseToNonNullableString();
    String statusName = () {
      var quotationCategory = quotationCategoryList.where(
        (quotationCategory) => quotationCategory.value.toLowerCase() == status.toLowerCase()
      ).firstOrNull;
      if (quotationCategory == null) {
        return "";
      }
      return quotationCategory.name;
    }();
    ResponseWrapper customerResponseWrapper = ResponseWrapper(response["partner_id"]);
    double pricelistValue = ResponseWrapper(response["amount_total"]).mapFromResponseToNonNullableDouble();
    return ShortQuotation(
      id: ResponseWrapper(response["id"]).mapFromResponseToNonNullableString(),
      code: ResponseWrapper(response["name"]).mapFromResponseToNonNullableString(),
      name: customerResponseWrapper.mapFromResponseToDataResponseWrapper(dataFieldName: "name").mapFromResponseToNonNullableString(),
      dateOrderDate: ResponseWrapper(response["date_order"]).mapFromResponseToDateTime(dateFormat: DateHelper.standardDateFormat3, convertIntoLocalTime: false),
      pricelist: StringHelper().convertToCurrencyString2(pricelistValue),
      pricelistValue: pricelistValue,
      status: status,
      statusName: statusName
    );
  }

  QuotationDetailResponse mapFromResponseToQuotationDetailResponse() {
    return QuotationDetailResponse(
      quotationDetail: ResponseWrapper(response).mapFromResponseToQuotationDetail()
    );
  }

  QuotationDetail mapFromResponseToQuotationDetail() {
    ResponseWrapper saleOrderResponseWrapper = ResponseWrapper(response).mapFromResponseToDataResponseWrapper(dataFieldName: "SaleOrder");
    List<QuotationDetail> quotationDetailList = saleOrderResponseWrapper.mapFromResponseToList(
      (quotationDetailResponse) {
        ResponseWrapper customerResponseWrapper = ResponseWrapper(quotationDetailResponse["partner_id"]);
        ResponseWrapper pipelineResponseWrapper = ResponseWrapper(quotationDetailResponse["opportunity_id"]);
        ResponseWrapper pricelistResponseWrapper = ResponseWrapper(quotationDetailResponse["pricelist_id"]);
        ResponseWrapper paymentTermResponseWrapper = ResponseWrapper(quotationDetailResponse["payment_term_id"]);
        ResponseWrapper partnerInvoiceResponseWrapper = ResponseWrapper(quotationDetailResponse["partner_invoice_id"]);
        ResponseWrapper partnerShippingResponseWrapper = ResponseWrapper(quotationDetailResponse["partner_shipping_id"]);
        return QuotationDetail(
          id: ResponseWrapper(quotationDetailResponse["id"]).mapFromResponseToNonNullableString(),
          code: ResponseWrapper(quotationDetailResponse["name"]).mapFromResponseToNonNullableString(),
          status: ResponseWrapper(quotationDetailResponse["state"]).mapFromResponseToNonNullableString(),
          customerId: customerResponseWrapper.mapFromResponseToDataResponseWrapper(dataFieldName: "id").mapFromResponseToNonNullableString(),
          customerName: customerResponseWrapper.mapFromResponseToDataResponseWrapper(dataFieldName: "name").mapFromResponseToNonNullableString(),
          pipelineId: pipelineResponseWrapper.mapFromResponseToDataResponseWrapper(dataFieldName: "id").mapFromResponseToNonNullableString(),
          invoiceAddress: partnerInvoiceResponseWrapper.mapFromResponseToQuotationAddressComponent().address,
          deliveryAddress: partnerShippingResponseWrapper.mapFromResponseToQuotationAddressComponent().address,
          pricelistId: pricelistResponseWrapper.mapFromResponseToDataResponseWrapper(dataFieldName: "id").mapFromResponseToNonNullableString(),
          pricelist: pricelistResponseWrapper.mapFromResponseToDataResponseWrapper(dataFieldName: "name").mapFromResponseToNonNullableString(),
          expirationDate: ResponseWrapper(quotationDetailResponse["date_order"]).mapFromResponseToDateTime(dateFormat: DateHelper.standardDateFormat, convertIntoLocalTime: false),
          paymentTermsId: pricelistResponseWrapper.mapFromResponseToDataResponseWrapper(dataFieldName: "id").mapFromResponseToNonNullableString(),
          paymentTerms: paymentTermResponseWrapper.mapFromResponseToDataResponseWrapper(dataFieldName: "name").mapFromResponseToNonNullableString(),
        );
      }
    );
    if (quotationDetailList.isEmpty) {
      throw MessageError(
        title: "Quotation Not Found",
        message: "Quotation is not found"
      );
    }
    return quotationDetailList.first;
  }

  // ignore: library_private_types_in_public_api
  _QuotationAddressComponent mapFromResponseToQuotationAddressComponent() {
    var stateResponseWrapper = ResponseWrapper(response).mapFromResponseToDataResponseWrapper(dataFieldName: "state_id");
    var countryResponseWrapper = ResponseWrapper(response).mapFromResponseToDataResponseWrapper(dataFieldName: "country_id");
    return _QuotationAddressComponent(
      street: ResponseWrapper(response["street"]).mapFromResponseToNonNullableString(),
      street2: ResponseWrapper(response["street2"]).mapFromResponseToNonNullableString(),
      city: ResponseWrapper(response["city"]).mapFromResponseToNonNullableString(),
      state: stateResponseWrapper.mapFromResponseToDataResponseWrapper(dataFieldName: "name").mapFromResponseToNonNullableString(),
      country: countryResponseWrapper.mapFromResponseToDataResponseWrapper(dataFieldName: "name").mapFromResponseToNonNullableString(),
      zip: ResponseWrapper(response["zip"]).mapFromResponseToNonNullableString(),
    );
  }

  String mapFromResponseToAddQuotationSalesId() {
    ResponseWrapper saleOrderResponseWrapper = ResponseWrapper(response).mapFromResponseToDataResponseWrapper(dataFieldName: "createSaleOrder");
    List<Map<String, dynamic>> dataResponseResult = saleOrderResponseWrapper.mapFromResponseToList(
      (dataResponse) => dataResponse
    );
    if (dataResponseResult.isEmpty) {
      throw MessageError(
        title: "No Detail Amount",
        message: "There is no detail amount"
      );
    }
    Map<String, dynamic> currentDataResponseResult = dataResponseResult.first;
    return ResponseWrapper(currentDataResponseResult["id"]).mapFromResponseToNonNullableString();
  }

  AddQuotationResponse mapFromResponseToAddQuotationResponse() {
    return AddQuotationResponse();
  }

  EditQuotationResponse mapFromResponseToEditQuotationResponse() {
    return EditQuotationResponse();
  }

  DetailAmountQuotationProductResponse mapFromResponseToDetailAmountQuotationProductResponse() {
    ResponseWrapper saleOrderResponseWrapper = ResponseWrapper(response).mapFromResponseToDataResponseWrapper(dataFieldName: "SaleOrder");
    List<Map<String, dynamic>> dataResponseResult = saleOrderResponseWrapper.mapFromResponseToList(
      (dataResponse) => dataResponse
    );
    if (dataResponseResult.isEmpty) {
      throw MessageError(
        title: "No Detail Amount",
        message: "There is no detail amount"
      );
    }
    Map<String, dynamic> currentDataResponseResult = dataResponseResult.first;
    double promoApplied = ResponseWrapper(currentDataResponseResult["reward_amount"]).mapFromResponseToNonNullableDouble();
    return DetailAmountQuotationProductResponse(
      descriptionDetailAmountQuotationProductContentList: [
        DetailAmountQuotationProductContent(
          title: "Untaxed Amount",
          value: StringHelper().convertToCurrencyString2(
            ResponseWrapper(currentDataResponseResult["amount_untaxed"]).mapFromResponseToNonNullableDouble(),
          ),
        ),
        DetailAmountQuotationProductContent(
          title: "Taxes",
          value: StringHelper().convertToCurrencyString2(
            ResponseWrapper(currentDataResponseResult["amount_tax"]).mapFromResponseToNonNullableDouble()
          )
        ),
        if (promoApplied < 0.0) ...[
          DetailAmountQuotationProductContent(
            title: "Promo Applied",
            value: StringHelper().convertToCurrencyString2(
              ResponseWrapper(currentDataResponseResult["reward_amount"]).mapFromResponseToNonNullableDouble()
            )
          )
        ]
      ],
      summaryDetailAmountQuotationProductContentList: [
        DetailAmountQuotationProductContent(
          title: "Total",
          value: StringHelper().convertToCurrencyString2(
            ResponseWrapper(currentDataResponseResult["amount_total"]).mapFromResponseToNonNullableDouble()
          )
        )
      ]
    );
  }

  QuotationCountBasedCustomerResponse mapFromResponseToQuotationCountBasedCustomerResponse() {
    ResponseWrapper resultDataResponseWrapper = ResponseWrapper(response).mapFromResponseToDataResponseWrapper(dataFieldName: "result");
    return QuotationCountBasedCustomerResponse(
      count: resultDataResponseWrapper.mapFromResponseToNonNullableInt()
    );
  }

  QuotationProductResponse mapFromResponseToQuotationProductResponse() {
    var saleOrderList = ResponseWrapper(response)
      .mapFromResponseToDataResponseWrapper(dataFieldName: "SaleOrder")
      .mapFromResponseToList((responseData) => responseData);
    if (saleOrderList.isEmpty) {
      throw MessageError(
        title: "Product Empty",
        message: "Product is empty"
      );
    }
    var orderListResponseWrapper = ResponseWrapper(saleOrderList.first).mapFromResponseToDataResponseWrapper(dataFieldName: "order_line");
    return QuotationProductResponse(
      shortQuotationProductList: orderListResponseWrapper.mapFromResponseToList(
        (responseData) => ResponseWrapper(responseData).mapFromResponseToShortQuotationProduct()
      )
    );
  }

  ShortQuotationProduct mapFromResponseToShortQuotationProduct() {
    var productResponseWrapper = ResponseWrapper(response).mapFromResponseToDataResponseWrapper(dataFieldName: "product_id");
    var productPackagingIdResponseWrapper = productResponseWrapper.mapFromResponseToDataResponseWrapper(dataFieldName: "product_packaging_id");
    var taxIdResponseWrapper = productResponseWrapper.mapFromResponseToDataResponseWrapper(dataFieldName: "tax_id");
    return ShortQuotationProduct(
      id: ResponseWrapper(response["id"]).mapFromResponseToNonNullableString(),
      productId: productResponseWrapper.mapFromResponseToDataResponseWrapper(dataFieldName: "id").mapFromResponseToNonNullableString(),
      productName: productResponseWrapper.mapFromResponseToDataResponseWrapper(dataFieldName: "name").mapFromResponseToNonNullableString(),
      qty: ResponseWrapper(response["product_uom_qty"]).mapFromResponseToNonNullableInt(),
      qtyUnit: productResponseWrapper.mapFromResponseToDataResponseWrapper(dataFieldName: "uom_id")
        .mapFromResponseToDataResponseWrapper(dataFieldName: "name")
        .mapFromResponseToNonNullableString(),
      unitPrice: ResponseWrapper(response["price_unit"]).mapFromResponseToNonNullableDouble(),
      totalPrice: ResponseWrapper(response["price_subtotal"]).mapFromResponseToNonNullableDouble(),
      description: ResponseWrapper(response["description"]).mapFromResponseToNonNullableString(),
      discount: ResponseWrapper(response["discount"]).mapFromResponseToNonNullableDouble(),
      productPackagingId: productPackagingIdResponseWrapper
        .mapFromResponseToDataResponseWrapper(dataFieldName: "id")
        .mapFromResponseToNonNullableString(),
      productPackagingName: productPackagingIdResponseWrapper
        .mapFromResponseToDataResponseWrapper(dataFieldName: "name")
        .mapFromResponseToNonNullableString(),
      taxId: taxIdResponseWrapper
        .mapFromResponseToDataResponseWrapper(dataFieldName: "id")
        .mapFromResponseToNonNullableString(),
      taxName: taxIdResponseWrapper
        .mapFromResponseToDataResponseWrapper(dataFieldName: "name")
        .mapFromResponseToNonNullableString(),
    );
  }

  QuotationProductTotalPriceResponse mapFromResponseToQuotationProductTotalPriceResponse() {
    var resultResponseWrapper = ResponseWrapper(response).mapFromResponseToDataResponseWrapper(dataFieldName: "result");
    var resultResponseList = resultResponseWrapper.mapFromResponseToList(
      (dataResponse) => dataResponse
    );
    if (resultResponseList.isEmpty) {
      throw MessageError(
        title: "Quotation Product Total Price Empty",
        message: "Quotation product total price is empty"
      );
    }
    var resultResponse = resultResponseList.first;
    return QuotationProductTotalPriceResponse(
      totalPrice: ResponseWrapper(resultResponse["amount_total"]).mapFromResponseToNonNullableDouble()
    );
  }

  QuotationConfirmResponse mapFromResponseToQuotationConfirmResponse() {
    return QuotationConfirmResponse();
  }

  QuotationCancelResponse mapFromResponseToQuotationCancelResponse() {
    return QuotationCancelResponse();
  }

  QuotationResetResponse mapFromResponseToQuotationResetResponse() {
    return QuotationResetResponse();
  }

  AddQuotationSaleOrderResponse mapFromResponseToAddQuotationSaleOrderResponse() {
    return AddQuotationSaleOrderResponse();
  }

  EditQuotationSaleOrderResponse mapFromResponseToEditQuotationSaleOrderResponse() {
    return EditQuotationSaleOrderResponse();
  }

  QuotationApplyVoucherCodeResponse mapFromResponseToQuotationApplyVoucherCodeResponse() {
    var resultResponseWrapper = ResponseWrapper(response).mapFromResponseToDataResponseWrapper(dataFieldName: "result");
    if (resultResponseWrapper.response is String) {
      throw MessageError(
        title: "Failed Apply Voucher",
        message: resultResponseWrapper.response
      );
    }
    return QuotationApplyVoucherCodeResponse(
      voucherRewardList: resultResponseWrapper.mapFromResponseToList(
        (responseData) => ResponseWrapper(responseData).mapFromResponseToVoucherReward()
      )
    );
  }

  VoucherReward mapFromResponseToVoucherReward() {
    return VoucherReward(
      id: ResponseWrapper(response["id"]).mapFromResponseToNonNullableString(),
      name: ResponseWrapper(response["name"]).mapFromResponseToNonNullableString(),
    );
  }

  QuotationSelectVoucherRewardResponse mapFromResponseToQuotationSelectVoucherRewardResponse() {
    return QuotationSelectVoucherRewardResponse();
  }

  QuotationUpdateDataAfterApplyVoucherResponse mapFromResponseToQuotationUpdateDataAfterApplyVoucherResponse() {
    return QuotationUpdateDataAfterApplyVoucherResponse();
  }
}

class _QuotationAddressComponent with AddressData {
  @override
  final String street;
  @override
  final String street2;
  @override
  final String city;
  @override
  final String zip;
  @override
  final String state;
  @override
  final String country;

  _QuotationAddressComponent({
    required this.street,
    required this.street2,
    required this.city,
    required this.zip,
    required this.state,
    required this.country
  });
}