import 'package:crm/common/ext/string_ext.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

import '../../environmentconfig/environment_config.dart';
import '../../helper/login_helper.dart';
import '../../httpclient/httpclient/modified_http_client_with_middleware.dart';
import 'default_http_link.dart';

class DefaultGraphQLClientCreator {
  GraphQLClient createGraphQLClient() {
    final HttpLink httpLink = DefaultHttpLink(
      EnvironmentConfig.instance.graphQLBaseUrl,
      httpClient: ModifiedHttpClientWithMiddleware.build(
        middlewares: [
          HttpLogger(logLevel: LogLevel.BODY),
        ]
      )
    );
    final AuthLink authLink = AuthLink(
      getToken: () async {
        return 'Bearer ${(LoginHelper.getLoginData()?.token).toEmptyStringNonNull}';
      },
    );
    final Link link = authLink.concat(httpLink);
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