import '../../common/load_data_result/load_data_result.dart';
import '../../common/processing/future_processing.dart';
import '../models/lostreasonlist/lost_reason_list_parameter.dart';
import '../models/lostreasonlist/lost_reason_list_response.dart';
import '../remotedatasources/reasonremotedatasource/reason_remote_data_source.dart';
import '../repositories/reason_repository.dart';

class DefaultReasonRepository implements ReasonRepository {
  final ReasonRemoteDataSource reasonRemoteDataSource;

  DefaultReasonRepository({
    required this.reasonRemoteDataSource
  });

  @override
  FutureProcessing<LoadDataResult<LostReasonListResponse>> lostReasonList(LostReasonListParameter reasonListParameter) {
    return reasonRemoteDataSource.lostReasonList(reasonListParameter).mapToLoadDataResult();
  }
}