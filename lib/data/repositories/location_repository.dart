import '../../common/load_data_result/load_data_result.dart';
import '../../common/processing/future_processing.dart';
import '../../data/models/countrylist/country_list_parameter.dart';
import '../../data/models/countrylist/country_list_response.dart';
import '../../data/models/statelist/state_list_parameter.dart';
import '../../data/models/statelist/state_list_response.dart';

abstract class LocationRepository {
  FutureProcessing<LoadDataResult<CountryListResponse>> countryList(CountryListParameter countryListParameter);
  FutureProcessing<LoadDataResult<StateListResponse>> stateList(StateListParameter stateListParameter);
}