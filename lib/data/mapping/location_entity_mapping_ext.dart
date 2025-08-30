import 'package:crm/common/ext/response_wrapper_ext.dart';

import '../../common/responsewrapper/response_wrapper.dart';
import '../models/country_value.dart';
import '../models/countrylist/country_list_response.dart';
import '../models/state_value.dart';
import '../models/statelist/state_list_response.dart';

extension LocationEntityMappingExt on ResponseWrapper {
  CountryListResponse mapFromResponseToCountryListResponse() {
    return CountryListResponse(
      countryValueList: () {
        var resultList = ResponseWrapper(response).mapFromResponseToList(
          (dataResponse) => ResponseWrapper(dataResponse).mapFromResponseToCountryValue()
        );
        return resultList;
      }()
    );
  }

  CountryValue mapFromResponseToCountryValue() {
    return CountryValue(
      id: ResponseWrapper(response["id"]).mapFromResponseToNonNullableString(),
      name: ResponseWrapper(response["name"]).mapFromResponseToNonNullableString(),
    );
  }

  StateListResponse mapFromResponseToStateListResponse() {
    return StateListResponse(
      stateValueList: () {
        var resultList = ResponseWrapper(response).mapFromResponseToList(
          (dataResponse) => ResponseWrapper(dataResponse).mapFromResponseToStateValue()
        );
        return resultList;
      }()
    );
  }

  StateValue mapFromResponseToStateValue() {
    return StateValue(
      id: ResponseWrapper(response["id"]).mapFromResponseToNonNullableString(),
      name: ResponseWrapper(response["name"]).mapFromResponseToNonNullableString(),
    );
  }
}