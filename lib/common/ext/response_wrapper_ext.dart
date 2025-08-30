import 'package:crm/common/ext/string_ext.dart';
import 'package:intl/intl.dart';

import '../error/message_error.dart';
import '../graphql/graph_ql_mutate_response.dart';
import '../graphql/graph_ql_query_response.dart';
import '../helper/date_helper.dart';
import '../httpclient/http_client_response.dart';
import '../responsewrapper/response_wrapper.dart';

extension GraphQLQueryStructureResponseWrapperExt on GraphQLQueryResponse {
  MainStructureResponseWrapper graphQLWrapResponse() {
    return MainStructureResponseWrapper.factory(data);
  }
}

extension GraphQLMutateStructureResponseWrapperExt on GraphQLMutateResponse {
  MainStructureResponseWrapper graphQLWrapResponse() {
    return MainStructureResponseWrapper.factory(data);
  }
}

extension MainStructureResponseWrapperExt on HttpClientResponse<dynamic> {
  MainStructureResponseWrapper wrapResponse() {
    return MainStructureResponseWrapper.factory(data);
  }
}

extension DateTimeResponseWrapperExt on ResponseWrapper {
  DateTime? mapFromResponseToDateTime({DateFormat? dateFormat, bool convertIntoLocalTime = true}) {
    if (response is bool) {
      if (response == false) {
        return null;
      }
    }
    DateTime? fetchedDateTime = () {
      List<DateFormat> dateFormatList = [
        DateHelper.anthonyInputDateFormat,
        DateHelper.standardDateFormat,
        DateHelper.standardDateFormat3
      ];
      int i = 0;
      while (i < dateFormatList.length) {
        try {
          return response != null ? (dateFormat ?? dateFormatList[i]).parse(response) : null;
        } catch (e) {
          i++;
        }
      }
      throw MessageError(
        title: "Date Format Is Not Suitable"
      );
    }();
    if (!convertIntoLocalTime) {
      return fetchedDateTime;
    }
    Duration? timezoneOffset = fetchedDateTime?.timeZoneOffset;
    return fetchedDateTime?.add(timezoneOffset!);
  }
}

extension ResponseWrapperExt on ResponseWrapper {
  DefaultResponseWrapper wrapDefaultResponse() {
    return DefaultResponseWrapper(response);
  }
}

extension DoubleResponseWrapperExt on ResponseWrapper {
  double? mapFromResponseToDouble() {
    if (response is int) {
      return (response as int).toDouble();
    } else if (response is double) {
      return response;
    } else if (response is String) {
      return double.tryParse(response);
    } else {
      return response;
    }
  }

  double mapFromResponseToNonNullableDouble({double? desiredValueIfNull}) {
    return mapFromResponseToDouble() ?? desiredValueIfNull ?? 0;
  }
}

extension IntResponseWrapperExt on ResponseWrapper {
  int? mapFromResponseToInt() {
    if (response is int) {
      return response;
    } else if (response is double) {
      return (response as double).toInt();
    } else if (response is String) {
      return int.tryParse(response);
    } else {
      return response;
    }
  }

  int mapFromResponseToNonNullableInt({int? desiredValueIfNull}) {
    return mapFromResponseToInt() ?? desiredValueIfNull ?? 0;
  }
}

extension StringResponseWrapperExt on ResponseWrapper {
  String? mapFromResponseToString() {
    if (response is String? || response is String) {
      return response;
    } else if (response is num) {
      return response.toString();
    } else if (response is bool) {
      bool result = response as bool;
      if (!result) {
        return "";
      } else {
        return response.toString();
      }
    } else {
      return response.toString();
    }
  }

  String mapFromResponseToNonNullableString() {
    return mapFromResponseToString().toEmptyStringNonNull;
  }
}

extension BoolResponseWrapperExt on ResponseWrapper {
  bool? mapFromResponseToBool() {
    if (response is String) {
      if (response == "true") {
        return true;
      } else if (response == "false") {
        return false;
      } else if (response == "1") {
        return true;
      } else if (response == "0") {
        return false;
      }
      return null;
    } else if (response is num) {
      if (response == 1 || response == 1.0) {
        return true;
      } else if (response == 0 || response == 0.0) {
        return false;
      }
    } else if (response is bool) {
      return response;
    } else {
      return null;
    }
    return null;
  }

  bool mapFromResponseToNonNullableBool() {
    return mapFromResponseToBool() ?? false;
  }
}

extension ListResponseWrapperExt on ResponseWrapper {
  List<T> mapFromResponseToList<T>(T Function(dynamic dataResponse) onMap) {
    return ((response as List<dynamic>?) ?? []).map<T>(
      (dataResponse) => onMap(dataResponse)
    ).toList();
  }
}

extension DataResponseWrapperExt on ResponseWrapper {
  ResponseWrapper mapFromResponseToDataResponseWrapper({String? dataFieldName}) {
    return ResponseWrapper(response != null ? response[dataFieldName.isNotEmptyString ? dataFieldName : "data"] : null);
  }
}

extension ArrayResponseWrapperExt on ResponseWrapper {
  ResponseWrapper getArrayData(int index) {
    dynamic result;
    try {
      if (response is List) {
        result = response[index];
      }
    } catch (e) {
      // Nothing to catch for array getting operation
    }
    return ResponseWrapper(result);
  }
}