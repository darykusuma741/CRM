import '../../common/load_data_result/load_data_result.dart';
import '../../common/processing/future_processing.dart';
import '../../data/models/lostpagingdata/lost_paging_data_parameter.dart';
import '../../data/models/lostpagingdata/lost_paging_data_response.dart';

abstract class LostRepository {
  FutureProcessing<LoadDataResult<LostPagingDataResponse>> lostPagingData(LostPagingDataParameter lostPagingDataParameter);
}