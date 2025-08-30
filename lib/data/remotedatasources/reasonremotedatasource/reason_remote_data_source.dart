import '../../../../common/processing/future_processing.dart';
import '../../models/lostreasonlist/lost_reason_list_parameter.dart';
import '../../models/lostreasonlist/lost_reason_list_response.dart';

abstract class ReasonRemoteDataSource {
  FutureProcessing<LostReasonListResponse> lostReasonList(LostReasonListParameter lostReasonListParameter);
}