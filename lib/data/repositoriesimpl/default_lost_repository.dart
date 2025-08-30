import '../../common/load_data_result/load_data_result.dart';
import '../../common/processing/future_processing.dart';
import '../models/lostpagingdata/lost_paging_data_parameter.dart';
import '../models/lostpagingdata/lost_paging_data_response.dart';
import '../remotedatasources/lostremotedatasource/lost_remote_data_source.dart';
import '../repositories/lost_repository.dart';

class DefaultLostRepository implements LostRepository {
  final LostRemoteDataSource lostRemoteDataSource;

  DefaultLostRepository({
    required this.lostRemoteDataSource
  });

  @override
  FutureProcessing<LoadDataResult<LostPagingDataResponse>> lostPagingData(LostPagingDataParameter lostPagingDataParameter) {
    return lostRemoteDataSource.lostPagingData(lostPagingDataParameter).mapToLoadDataResult();
  }
}