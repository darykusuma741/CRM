import '../../../common/load_data_result/load_data_result.dart';
import '../quotationselectvoucherreward/quotation_select_voucher_reward_response.dart';
import '../voucher_reward.dart';
import 'apply_voucher_phase.dart';

class SelectApplyVoucherPhase extends ApplyVoucherPhase {
  LoadDataResult<List<VoucherReward>> voucherRewardListLoadDataResult;
  LoadDataResult<QuotationSelectVoucherRewardResponse> quotationSelectVoucherRewardResponseLoadDataResult;

  SelectApplyVoucherPhase({
    required this.voucherRewardListLoadDataResult,
    required this.quotationSelectVoucherRewardResponseLoadDataResult
  });
}