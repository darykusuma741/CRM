import '../../common/load_data_result/load_data_result.dart';
import '../../common/processing/future_processing.dart';
import '../models/countrylist/country_list_parameter.dart';
import '../models/countrylist/country_list_response.dart';
import '../models/statelist/state_list_parameter.dart';
import '../models/statelist/state_list_response.dart';
import '../remotedatasources/locationremotedatasource/location_remote_data_source.dart';
import '../repositories/location_repository.dart';

class DefaultLocationRepository implements LocationRepository {
  final LocationRemoteDataSource locationRemoteDataSource;

  DefaultLocationRepository({
    required this.locationRemoteDataSource
  });

  @override
  FutureProcessing<LoadDataResult<CountryListResponse>> countryList(CountryListParameter countryListParameter) {
    return locationRemoteDataSource.countryList(countryListParameter).mapToLoadDataResult();
  }

  @override
  FutureProcessing<LoadDataResult<StateListResponse>> stateList(StateListParameter stateListParameter) {
    return locationRemoteDataSource.stateList(stateListParameter).mapToLoadDataResult();
  }
}