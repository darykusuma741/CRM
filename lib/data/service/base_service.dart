import 'package:dio/dio.dart';
import 'package:crm/common/helper/dio_client.dart';

import '../../common/graphql/graphqlfutureprocessingcancellationcreator/graph_ql_future_processing_cancellation_creator.dart';
import '../../common/httpclient/httpclientfutureprocessingcancellationcreator/http_client_future_processing_cancellation_creator.dart';
import '../../common/injections/injections.dart';
import '../../common/manager/api_request_manager.dart';

abstract class BaseService {
  late final HttpClientFutureProcessingCancellationCreator httpClientCancellationCreator;
  late final GraphQLFutureProcessingCancellationCreator graphQLFutureProcessingCancellationCreator;
  late final ApiRequestManager apiRequestManager;

  BaseService() {
    httpClientCancellationCreator = sl<HttpClientFutureProcessingCancellationCreator>();
    graphQLFutureProcessingCancellationCreator = sl<GraphQLFutureProcessingCancellationCreator>();
    apiRequestManager = sl<ApiRequestManager>();
  }

  void dispose() {
    apiRequestManager.cancelAllRequest();
  }
}
