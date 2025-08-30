import 'no_environment_config.dart';

abstract class EnvironmentConfig {
  static EnvironmentConfig instance = NoEnvironmentConfig();

  String get environment;
  String get httpBaseUrl;
  String get graphQLBaseUrl;
  String get sentryBaseUrl;
}