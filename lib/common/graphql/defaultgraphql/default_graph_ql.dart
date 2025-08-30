import 'package:graphql_flutter/graphql_flutter.dart';

import '../../error/graph_ql_result_error.dart';
import '../../helper/logger_helper.dart';
import '../graph_ql.dart';
import '../graph_ql_mutate_parameter.dart';
import '../graph_ql_mutate_response.dart';
import '../graph_ql_query_parameter.dart';
import '../graph_ql_query_response.dart';
// ignore: depend_on_referenced_packages
import 'package:gql/ast.dart';
// ignore: depend_on_referenced_packages
import 'package:gql/language.dart';

class DefaultGraphQL implements GraphQL {
  final GraphQLClient graphQLClient;

  const DefaultGraphQL({
    required this.graphQLClient
  });

  @override
  Future<GraphQLMutateResponse> mutate(GraphQLMutateParameter parameter) async {
    var queryResult = await graphQLClient.mutate(
      MutationOptions(
        document: _modifiedGql(parameter.queryString),
        variables: parameter.variables
      )
    );
    if (queryResult.hasException) {
      LoggerHelper.appLogger.e(queryResult.exception);
      var result = _titleAndMessage(queryResult);
      throw GraphQLResultError(
        lastQuery: parameter.queryString,
        exception: queryResult.exception!,
        title: result["title"],
        message: result["message"]
      );
    }
    LoggerHelper.appLogger.i(queryResult.data);
    return GraphQLMutateResponse(
      data: queryResult.data ?? {}
    );
  }

  Map<String, dynamic> _titleAndMessage(QueryResult queryResult) {
    var title = "";
    var message = "";
    var exception = queryResult.exception!;
    var linkException = exception.linkException;
    if (linkException is ServerException) {
      var response = linkException.parsedResponse;
      if (response != null) {
        var responseMap = response.response;
        if (responseMap.containsKey("title")) {
          title = responseMap["title"];
        }
        if (responseMap.containsKey("message")) {
          message = responseMap["message"];
        }
      }
    }
    return <String, dynamic>{
      "title": title,
      "message": message
    };
  }

  @override
  Future<GraphQLQueryResponse> query(GraphQLQueryParameter parameter) async {
    var queryResult = await graphQLClient.query(
      QueryOptions(
        document: _modifiedGql(parameter.queryString),
        variables: parameter.variables
      )
    );
    if (queryResult.hasException) {
      LoggerHelper.appLogger.e(queryResult.exception!);
      var result = _titleAndMessage(queryResult);
      throw GraphQLResultError(
        lastQuery: parameter.queryString,
        exception: queryResult.exception!,
        title: result["title"],
        message: result["message"]
      );
    }
    LoggerHelper.appLogger.i(queryResult.data);
    return GraphQLQueryResponse(
      data: queryResult.data ?? {}
    );
  }
}

DocumentNode _modifiedGql(String document) => transform(
  parseString(document),
  []
);