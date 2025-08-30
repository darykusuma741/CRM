import '../../common/load_data_result/load_data_result.dart';
import '../../common/processing/future_processing.dart';
import '../models/addquotation/add_quotation_parameter.dart';
import '../models/addquotation/add_quotation_response.dart';
import '../models/addquotationsaleorder/add_quotation_sale_order_parameter.dart';
import '../models/addquotationsaleorder/add_quotation_sale_order_response.dart';
import '../models/detailamountquotationproduct/detail_amount_quotation_product_parameter.dart';
import '../models/detailamountquotationproduct/detail_amount_quotation_product_response.dart';
import '../models/editquotation/edit_quotation_parameter.dart';
import '../models/editquotation/edit_quotation_response.dart';
import '../models/editquotationsaleorder/edit_quotation_sale_order_parameter.dart';
import '../models/editquotationsaleorder/edit_quotation_sale_order_response.dart';
import '../models/quotationapplyvouchercode/quotation_apply_voucher_code_parameter.dart';
import '../models/quotationapplyvouchercode/quotation_apply_voucher_code_response.dart';
import '../models/quotationcancel/quotation_cancel_parameter.dart';
import '../models/quotationcancel/quotation_cancel_response.dart';
import '../models/quotationcategory/quotation_category_parameter.dart';
import '../models/quotationcategory/quotation_category_response.dart';
import '../models/quotationconfirm/quotation_confirm_parameter.dart';
import '../models/quotationconfirm/quotation_confirm_response.dart';
import '../models/quotationcountbasedcustomer/quotation_count_based_customer_parameter.dart';
import '../models/quotationcountbasedcustomer/quotation_count_based_customer_response.dart';
import '../models/quotationdetail/quotation_detail_parameter.dart';
import '../models/quotationdetail/quotation_detail_response.dart';
import '../models/quotationpagingdata/quotation_paging_data_parameter.dart';
import '../models/quotationpagingdata/quotation_paging_data_response.dart';
import '../models/quotationproduct/quotation_product_parameter.dart';
import '../models/quotationproduct/quotation_product_response.dart';
import '../models/quotationproducttotalprice/quotation_product_total_price_parameter.dart';
import '../models/quotationproducttotalprice/quotation_product_total_price_response.dart';
import '../models/quotationreset/quotation_reset_parameter.dart';
import '../models/quotationreset/quotation_reset_response.dart';
import '../models/quotationselectvoucherreward/quotation_select_voucher_reward_parameter.dart';
import '../models/quotationselectvoucherreward/quotation_select_voucher_reward_response.dart';
import '../models/quotationstage/quotation_stage_parameter.dart';
import '../models/quotationstage/quotation_stage_response.dart';
import '../models/quotationupdatedataafterapplyvoucher/quotation_update_data_after_apply_voucher_parameter.dart';
import '../models/quotationupdatedataafterapplyvoucher/quotation_update_data_after_apply_voucher_response.dart';
import '../models/totalpriceofquotation/total_price_of_quotation_parameter.dart';
import '../models/totalpriceofquotation/total_price_of_quotation_response.dart';
import '../remotedatasources/quotationremotedatasource/quotation_remote_data_source.dart';
import '../repositories/quotation_repository.dart';

class DefaultQuotationRepository implements QuotationRepository {
  final QuotationRemoteDataSource quotationRemoteDataSource;

  DefaultQuotationRepository({
    required this.quotationRemoteDataSource
  });

  @override
  FutureProcessing<LoadDataResult<QuotationCountBasedCustomerResponse>> quotationCountBasedCustomer(QuotationCountBasedCustomerParameter quotationCountBasedCustomerParameter) {
    return quotationRemoteDataSource.quotationCountBasedCustomer(quotationCountBasedCustomerParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<DetailAmountQuotationProductResponse>> detailAmountQuotationProduct(DetailAmountQuotationProductParameter detailAmountQuotationProductParameter) {
    return quotationRemoteDataSource.detailAmountQuotationProduct(detailAmountQuotationProductParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<QuotationCategoryResponse>> quotationCategory(QuotationCategoryParameter quotationCategoryParameter) {
    return quotationRemoteDataSource.quotationCategory(quotationCategoryParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<QuotationPagingDataResponse>> quotationPagingData(QuotationPagingDataParameter quotationPagingDataParameter) {
    return quotationRemoteDataSource.quotationPagingData(quotationPagingDataParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<QuotationDetailResponse>> quotationDetail(QuotationDetailParameter quotationDetailParameter) {
    return quotationRemoteDataSource.quotationDetail(quotationDetailParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<EditQuotationSaleOrderResponse>> editQuotationSaleOrder(EditQuotationSaleOrderParameter editQuotationSaleOrderParameter) {
    return quotationRemoteDataSource.editQuotationSaleOrder(editQuotationSaleOrderParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<AddQuotationSaleOrderResponse>> addQuotationSaleOrder(AddQuotationSaleOrderParameter addQuotationSaleOrderParameter) {
    return quotationRemoteDataSource.addQuotationSaleOrder(addQuotationSaleOrderParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<AddQuotationResponse>> addQuotation(AddQuotationParameter addQuotationParameter) {
    return quotationRemoteDataSource.addQuotation(addQuotationParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<EditQuotationResponse>> editQuotation(EditQuotationParameter editQuotationParameter) {
    return quotationRemoteDataSource.editQuotation(editQuotationParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<QuotationStageResponse>> quotationStage(QuotationStageParameter quotationStageParameter) {
    return quotationRemoteDataSource.quotationStage(quotationStageParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<QuotationProductResponse>> quotationProduct(QuotationProductParameter quotationProductParameter) {
    return quotationRemoteDataSource.quotationProduct(quotationProductParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<QuotationProductTotalPriceResponse>> quotationProductTotalPrice(QuotationProductTotalPriceParameter quotationProductTotalPriceParameter) {
    return quotationRemoteDataSource.quotationProductTotalPrice(quotationProductTotalPriceParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<QuotationConfirmResponse>> quotationConfirm(QuotationConfirmParameter quotationConfirmParameter) {
    return quotationRemoteDataSource.quotationConfirm(quotationConfirmParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<QuotationCancelResponse>> quotationCancel(QuotationCancelParameter quotationCancelParameter) {
    return quotationRemoteDataSource.quotationCancel(quotationCancelParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<QuotationResetResponse>> quotationReset(QuotationResetParameter quotationResetParameter) {
    return quotationRemoteDataSource.quotationReset(quotationResetParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<TotalPriceOfQuotationResponse>> totalPriceOfQuotation(TotalPriceOfQuotationParameter totalPriceOfQuotationParameter) {
    return quotationRemoteDataSource.totalPriceOfQuotation(totalPriceOfQuotationParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<QuotationApplyVoucherCodeResponse>> quotationApplyVoucherCode(QuotationApplyVoucherCodeParameter quotationApplyVoucherCodeParameter) {
    return quotationRemoteDataSource.quotationApplyVoucherCode(quotationApplyVoucherCodeParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<QuotationSelectVoucherRewardResponse>> quotationSelectVoucherReward(QuotationSelectVoucherRewardParameter quotationSelectVoucherRewardParameter) {
    return quotationRemoteDataSource.quotationSelectVoucherReward(quotationSelectVoucherRewardParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<QuotationUpdateDataAfterApplyVoucherResponse>> quotationUpdateDataAfterApplyVoucher(QuotationUpdateDataAfterApplyVoucherParameter quotationUpdateDataAfterApplyVoucherParameter) {
    return quotationRemoteDataSource.quotationUpdateDataAfterApplyVoucher(quotationUpdateDataAfterApplyVoucherParameter).mapToLoadDataResult();
  }
}