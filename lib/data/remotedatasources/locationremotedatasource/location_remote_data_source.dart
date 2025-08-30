import '../../../../common/processing/future_processing.dart';
import '../../models/countrylist/country_list_parameter.dart';
import '../../models/countrylist/country_list_response.dart';
import '../../models/statelist/state_list_parameter.dart';
import '../../models/statelist/state_list_response.dart';

abstract class LocationRemoteDataSource {
  FutureProcessing<CountryListResponse> countryList(CountryListParameter countryListParameter);
  FutureProcessing<StateListResponse> stateList(StateListParameter stateListParameter);
}