import 'package:crm/common/ext/response_wrapper_ext.dart';
import 'package:crm/common/ext/string_ext.dart';
import 'package:flutter/services.dart';

import '../error/graph_ql_result_error.dart';
import '../error/http_client_error.dart';
import '../error/message_error.dart';
import 'error_provider.dart';

class DefaultErrorProvider extends ErrorProvider {
  @override
  ErrorProviderResult? onGetErrorProviderResult(e) {
    if (e is HttpClientError) {
      return _handlingHttpClientError(e);
    } else if (e is MessageError) {
      return ErrorProviderResult(
        title: e.title,
        message: e.message
      );
    } else if (e is PlatformException) {
      return ErrorProviderResult(
        title: "Something Failed (${e.code})",
        message: "${e.message}"
      );
    } else if (e is GraphQLResultError) {
      return ErrorProviderResult(
        title: "Error Processing",
        message: "Error while processing the data"
      );
    } else {
      return ErrorProviderResult(
        title: "Something Failed",
        message: e.toString()
      );
    }
  }

  ErrorProviderResult _handlingHttpClientError(HttpClientError e) {
    HttpClientErrorType httpClientErrorType = e.httpClientErrorType;
    if (httpClientErrorType == HttpClientErrorType.connectionError) {
      return ErrorProviderResult(
        title: "Internet Connection Problem",
        message: "There is a problem in internet connection"
      );
    } else if (httpClientErrorType == HttpClientErrorType.connectionTimeout) {
      return ErrorProviderResult(
        title: "Internet Connection Timeout",
        message: "The connection of internet has been timeout"
      );
    } else if (httpClientErrorType == HttpClientErrorType.sendTimeout) {
      return ErrorProviderResult(
        title: "Internet Connection Timeout In Sending",
        message: "The connection of internet has been timeout while sending"
      );
    } else if (httpClientErrorType == HttpClientErrorType.receiveTimeout) {
      return ErrorProviderResult(
        title: "Internet Connection Timeout In Receiving",
        message: "The connection of internet has been timeout while receiving"
      );
    } else if (httpClientErrorType == HttpClientErrorType.cancel) {
      return ErrorProviderResult(
        title: "Request Cancelled",
        message: "Request has cancelled"
      );
    } else if (httpClientErrorType == HttpClientErrorType.badResponse) {
      var mainStructureResponseWrapper = e.httpClientResponse?.wrapResponse();
      String? effectiveTitle;
      String? effectiveMessage;
      if (mainStructureResponseWrapper != null) {
        effectiveTitle = mainStructureResponseWrapper.title;
        effectiveMessage = mainStructureResponseWrapper.description;
      }
      return ErrorProviderResult(
        title: effectiveTitle.isNotEmptyString ? effectiveTitle! : "Request Error",
        message: effectiveMessage.isNotEmptyString ? effectiveMessage! : "Request error has occurred"
      );
    } else if (httpClientErrorType == HttpClientErrorType.badCertificate) {
      return ErrorProviderResult(
        title: "Bad Certificate",
        message: "There is bad certificate"
      );
    } else {
      return ErrorProviderResult(
        title: "Something Failed",
        message: "Something wrong related with connection request"
      );
    }
  }
}