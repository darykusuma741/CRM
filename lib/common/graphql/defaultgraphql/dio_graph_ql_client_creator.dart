import 'package:crm/common/ext/string_ext.dart';
import 'package:gql_dio_link/gql_dio_link.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../environmentconfig/environment_config.dart';
import '../../helper/login_helper.dart';
import '../../httpclient/httpclient/diohttpclient/dio_http_client_part.dart';
import '../../httpclient/httpclient/http_client_configurator.dart';
import '../../injections/injections.dart';

class DioGraphQLClientCreator {
  GraphQLClient createGraphQLClient() {
    final DioLink dioLink = DioLink(
      EnvironmentConfig.instance.graphQLBaseUrl,
      client: sl<DioHttpClientCreator>().createDio(sl<HttpClientConfigurator>() as DioHttpClientConfigurator)
    );
    final AuthLink authLink = AuthLink(
      getToken: () async {
        return 'Bearer ${(LoginHelper.getLoginData()?.token).toEmptyStringNonNull}';
      },
    );
    final Link link = authLink.concat(dioLink);
    return GraphQLClient(
      link: link,
      cache: GraphQLCache(
        partialDataPolicy: PartialDataCachePolicy.accept
      ),
      defaultPolicies: DefaultPolicies(
        query: Policies(
          cacheReread: CacheRereadPolicy.ignoreAll,
          fetch: FetchPolicy.noCache,
        ),
        mutate: Policies(
          cacheReread: CacheRereadPolicy.ignoreAll,
          fetch: FetchPolicy.noCache,
        ),
        watchQuery: Policies(
          cacheReread: CacheRereadPolicy.ignoreAll,
          fetch: FetchPolicy.noCache,
        ),
        watchMutation: Policies(
          cacheReread: CacheRereadPolicy.ignoreAll,
          fetch: FetchPolicy.noCache,
        ),
        subscribe: Policies(
          cacheReread: CacheRereadPolicy.ignoreAll,
          fetch: FetchPolicy.noCache,
        )
      ),
      queryRequestTimeout: const Duration(seconds: 60)
    );
  }
}