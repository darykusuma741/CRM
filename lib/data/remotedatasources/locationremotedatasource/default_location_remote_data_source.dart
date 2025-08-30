import 'dart:convert';

import 'package:crm/data/mapping/location_entity_mapping_ext.dart';
import 'package:flutter/services.dart';

import '../../../../common/graphql/graph_ql.dart';
import '../../../../common/processing/dummy_future_processing.dart';
import '../../../../common/processing/future_processing.dart';
import '../../../../common/responsewrapper/response_wrapper.dart';
import '../../../common/constants/local_locations.dart';
import '../../models/countrylist/country_list_parameter.dart';
import '../../models/countrylist/country_list_response.dart';
import '../../models/statelist/state_list_parameter.dart';
import '../../models/statelist/state_list_response.dart';
import 'location_remote_data_source.dart';

class DefaultLocationRemoteDataSource implements LocationRemoteDataSource {
  final GraphQL graphQL;

  DefaultLocationRemoteDataSource({
    required this.graphQL,
  });

  @override
  FutureProcessing<CountryListResponse> countryList(CountryListParameter countryListParameter) {
    return DummyFutureProcessing((_) async {
      var countryLocationJsonString = await rootBundle.loadString(
        LocalLocations.countryLocation
      );
      return ResponseWrapper(
        json.decode(countryLocationJsonString)
      ).mapFromResponseToCountryListResponse();
    });
  }

  @override
  FutureProcessing<StateListResponse> stateList(StateListParameter stateListParameter) {
    return DummyFutureProcessing((_) async {
      var stateLocationJsonString = await rootBundle.loadString(
        LocalLocations.stateLocation
      );
      return ResponseWrapper(
        json.decode(stateLocationJsonString)
      ).mapFromResponseToStateListResponse();
    });
  }
}