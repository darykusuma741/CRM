import '../../common/load_data_result/load_data_result.dart';
import '../../common/processing/future_processing.dart';
import '../../data/models/lostreasonlist/lost_reason_list_parameter.dart';
import '../../data/models/lostreasonlist/lost_reason_list_response.dart';

abstract class ReasonRepository {
  FutureProcessing<LoadDataResult<LostReasonListResponse>> lostReasonList(LostReasonListParameter reasonListParameter);
}