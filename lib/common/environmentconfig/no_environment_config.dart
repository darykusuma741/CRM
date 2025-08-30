import 'environment_config.dart';

class NoEnvironmentConfig extends EnvironmentConfig {
  @override
  String get environment => "";

  @override
  String get httpBaseUrl => "";

  @override
  String get graphQLBaseUrl => "";

  @override
  String get sentryBaseUrl => "";
}