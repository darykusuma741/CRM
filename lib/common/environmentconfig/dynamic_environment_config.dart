import 'environment_config.dart';

class DynamicEnvironmentConfig extends EnvironmentConfig {
  String _dynamicHttpBaseUrl = "";
  set dynamicHttpBaseUrl(String value) {
    _dynamicHttpBaseUrl = value;
  }

  String _dynamicGraphQLBaseUrl = "";
  set dynamicGraphQLBaseUrl(String value) {
    _dynamicGraphQLBaseUrl = value;
  }

  @override
  String get environment => "dynamic";

  @override
  String get httpBaseUrl => _dynamicHttpBaseUrl;

  @override
  String get graphQLBaseUrl => _dynamicGraphQLBaseUrl;

  @override
  String get sentryBaseUrl => "https://97aeb05efac2cfea2d1eab1c9a9a545a@o4509044464484352.ingest.us.sentry.io/4509044468023296";
}