import 'environment_config.dart';

class ProdEnvironmentConfig extends EnvironmentConfig {
  @override
  String get environment => "prod";

  @override
  String get httpBaseUrl => "http://crm.dev.arc.at-so.com/crmapp/api";

  @override
  String get graphQLBaseUrl => "https://crm.dev.arc.at-so.com/crmapp";

  @override
  String get sentryBaseUrl => "https://97aeb05efac2cfea2d1eab1c9a9a545a@o4509044464484352.ingest.us.sentry.io/4509044468023296";
}