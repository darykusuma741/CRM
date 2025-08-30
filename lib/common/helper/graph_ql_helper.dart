import 'package:crm/common/ext/string_ext.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLHelper {
  static String graphQLErrorToString(OperationException? operationException) {
    List<GraphQLError> graphQLErrorList = operationException?.graphqlErrors ?? [];
    String result = "";
    void concatResult(String value) {
      result += "${result.isNotEmptyString ? "\r\n" : ""}- $value";
    }
    for (var graphQLError in graphQLErrorList) {
      concatResult(graphQLError.message);
    }
    if (operationException?.linkException != null) {
      concatResult(operationException!.linkException.toString());
    }
    return result;
  }
}