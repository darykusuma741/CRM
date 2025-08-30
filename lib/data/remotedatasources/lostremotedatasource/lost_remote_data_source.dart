import '../../../../common/processing/future_processing.dart';
import '../../models/lostpagingdata/lost_paging_data_parameter.dart';
import '../../models/lostpagingdata/lost_paging_data_response.dart';

abstract class LostRemoteDataSource {
  FutureProcessing<LostPagingDataResponse> lostPagingData(LostPagingDataParameter lostPagingDataParameter);
}