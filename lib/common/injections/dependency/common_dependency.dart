import '../../../common/graphql/defaultgraphql/default_graph_ql.dart';
import '../../../common/graphql/defaultgraphql/default_graph_ql_client_creator.dart';
import '../../../common/graphql/defaultgraphql/dio_graph_ql_client_creator.dart';
import '../../../common/graphql/graph_ql.dart';
import '../../../common/graphql/graphqlfutureprocessingcancellationcreator/default_graph_ql_future_processing_cancellation_creator.dart';
import '../../../common/graphql/graphqlfutureprocessingcancellationcreator/graph_ql_future_processing_cancellation_creator.dart';
import '../../error_provider/default_error_provider.dart';
import '../../error_provider/error_provider.dart';
import '../../httpclient/httpclient/diohttpclient/dio_http_client.dart';
import '../../httpclient/httpclient/diohttpclient/dio_http_client_part.dart';
import '../../httpclient/httpclient/http_client.dart';
import '../../httpclient/httpclient/http_client_configurator.dart';
import '../../httpclient/httpclientfutureprocessingcancellationcreator/dio_http_client_future_processing_cancellation_creator.dart';
import '../../httpclient/httpclientfutureprocessingcancellationcreator/http_client_future_processing_cancellation_creator.dart';
import '../../load_data_result/default_load_data_result_widget/default_load_data_result_widget.dart';
import '../../load_data_result/default_load_data_result_widget/main_default_load_data_result_widget.dart';
import '../../manager/api_request_manager.dart';
import '../injections.dart';

class CommonDependency {
  CommonDependency() {
    _common();
  }

  void _common() {
    sl.registerLazySingleton<ErrorProvider>(() => DefaultErrorProvider());
    sl.registerLazySingleton<DefaultLoadDataResultWidget>(() => MainDefaultLoadDataResultWidget());

    // Http Client Configurator
    sl.registerLazySingleton<HttpClientConfigurator>(() => DioHttpClientConfigurator());

    // Http Client
    sl.registerLazySingleton<HttpClient>(() => DioHttpClient(dio: sl<DioHttpClientCreator>().createDio(sl<HttpClientConfigurator>() as DioHttpClientConfigurator)));

    // Http Client Future Processing Cancellation Creator
    sl.registerLazySingleton<HttpClientFutureProcessingCancellationCreator>(() => DioHttpClientFutureProcessingCancellationCreator());

    // Dio Http Client Creator
    sl.registerLazySingleton<DioHttpClientCreator>(() => DioHttpClientCreator());

    // GraphQL
    sl.registerLazySingleton<GraphQL>(() => DefaultGraphQL(graphQLClient: sl<DioGraphQLClientCreator>().createGraphQLClient()));

    // Default Graph QL Client Creator
    sl.registerFactory<DefaultGraphQLClientCreator>(() => DefaultGraphQLClientCreator());

    // Dio Graph QL Client Creator
    sl.registerFactory<DioGraphQLClientCreator>(() => DioGraphQLClientCreator());

    // GraphQL Client Future Processing Cancellation Creator
    sl.registerLazySingleton<GraphQLFutureProcessingCancellationCreator>(() => DefaultGraphQLFutureProcessingCancellationCreator());

    // Api Request Manager
    sl.registerFactory<ApiRequestManager>(() => ApiRequestManager());
  }
}