import 'package:crm/common/ext/response_wrapper_ext.dart';
import 'package:flutter/foundation.dart';

class ResponseWrapper {
  final dynamic response;

  ResponseWrapper(this.response);
}

class DefaultResponseWrapper extends ResponseWrapper {
  @override
  dynamic get response => _dataResponse;

  late final dynamic _dataResponse;

  DefaultResponseWrapper(dynamic fullResponse) : super(fullResponse) {
    _dataResponse = fullResponse["response"];
  }
}

class MainStructureResponseWrapper extends ResponseWrapper {
  @override
  dynamic get response => _dataResponse;

  late final dynamic fullDataResponse;
  late final dynamic _dataResponse;

  late final String title;
  late final String description;

  factory MainStructureResponseWrapper.factory(dynamic fullResponse) {
    return MainStructureResponseWrapper(fullResponse);
  }

  MainStructureResponseWrapper(dynamic fullResponse) : super(fullResponse) {
    try {
      fullDataResponse = fullResponse;
      title = ResponseWrapper(fullResponse["title"]).mapFromResponseToNonNullableString();
      description = ResponseWrapper(fullResponse["description"]).mapFromResponseToNonNullableString();
      _dataResponse = fullResponse;
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print("Error parsing in response wrapper: $e\r\n$stackTrace");
      }
      title = "Request Error";
      description = "Request error has occurred";
    }
  }
}