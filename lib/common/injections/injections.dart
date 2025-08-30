import 'package:get_it/get_it.dart';

import 'dependency/common_dependency.dart';
import 'dependency/data_source_dependency.dart';
import 'dependency/repository_dependency.dart';

final sl = GetIt.instance;

class Injections {
  static Future<void> initialize() async {
    await _registerCommonDependency();
  }

  static Future<void> _registerCommonDependency() async {
    CommonDependency();
    DataSourceDependency();
    RepositoryDependency();
  }
}
