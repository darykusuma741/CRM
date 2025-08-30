import 'dart:convert';

import 'package:crm/common/ext/string_ext.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../helper/login_helper.dart';

class GraphQLResultError extends Error {
  String lastQuery;
  OperationException exception;
  String title;
  String message;

  GraphQLResultError({
    required this.lastQuery,
    required this.exception,
    required this.title,
    required this.message
  });

  @override
  String toString() {
    return json.encode(
      <String, dynamic>{
        "token": "Bearer ${(LoginHelper.getLoginData()?.token).toEmptyStringNonNull}",
        "exception": exception.toString(),
        "query": lastQuery
      }
    );
  }
}