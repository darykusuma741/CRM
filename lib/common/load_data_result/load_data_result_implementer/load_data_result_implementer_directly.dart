import 'package:flutter/material.dart';

import '../../error_provider/error_provider.dart';
import '../../injections/injections.dart';
import '../default_load_data_result_widget/default_load_data_result_widget.dart';
import '../load_data_result.dart';
import 'base_load_data_result_implementer.dart';

typedef OnImplementLoadDataResultDirectly<T> = Widget Function(LoadDataResult<T>, ErrorProvider);
typedef OnImplementLoadDataResultDirectlyWithDefault<T> = Widget Function(LoadDataResult<T>, ErrorProvider, DefaultLoadDataResultWidget);

class LoadDataResultImplementerDirectly<T> extends BaseLoadDataResultImplementer<T> {
  final OnImplementLoadDataResultDirectly<T>? onImplementLoadDataResultDirectly;

  final DefaultLoadDataResultWidget? _defaultLoadDataResultWidget;

  @override
  DefaultLoadDataResultWidget get defaultLoadDataResultWidget => _defaultLoadDataResultWidget ?? sl<DefaultLoadDataResultWidget>();

  const LoadDataResultImplementerDirectly({
    Key? key,
    required super.loadDataResult,
    required super.errorProvider,
    this.onImplementLoadDataResultDirectly,
    DefaultLoadDataResultWidget? defaultLoadDataResultWidget
  }) : _defaultLoadDataResultWidget = defaultLoadDataResultWidget;

  @override
  Widget build(BuildContext context) {
    if (onImplementLoadDataResultDirectly != null) {
      return onImplementLoadDataResultDirectly!(loadDataResult, errorProvider);
    } else {
      return Container();
    }
  }
}

class LoadDataResultImplementerDirectlyWithDefault<T> extends LoadDataResultImplementerDirectly<T> {
  final OnImplementLoadDataResultDirectlyWithDefault<T>? onImplementLoadDataResultDirectlyWithDefault;

  @override
  OnImplementLoadDataResultDirectly<T>? get onImplementLoadDataResultDirectly {
    return onImplementLoadDataResultDirectlyWithDefault != null
      ? (loadDataResult, errorProvider) => onImplementLoadDataResultDirectlyWithDefault!(loadDataResult, errorProvider, defaultLoadDataResultWidget)
      : null;
  }

  const LoadDataResultImplementerDirectlyWithDefault({
    super.key,
    required super.loadDataResult,
    required super.errorProvider,
    this.onImplementLoadDataResultDirectlyWithDefault,
    super.defaultLoadDataResultWidget
  });
}