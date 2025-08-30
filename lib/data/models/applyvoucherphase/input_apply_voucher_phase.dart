import '../../../common/load_data_result/load_data_result.dart';
import '../quotationapplyvouchercode/quotation_apply_voucher_code_response.dart';
import 'apply_voucher_phase.dart';

class InputApplyVoucherPhase extends ApplyVoucherPhase {
  LoadDataResult<QuotationApplyVoucherCodeResponse> quotationApplyVoucherCodeResponseLoadDataResult;

  InputApplyVoucherPhase({
    required this.quotationApplyVoucherCodeResponseLoadDataResult
  });
}