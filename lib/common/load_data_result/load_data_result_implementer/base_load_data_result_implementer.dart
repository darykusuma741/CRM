import 'package:flutter/material.dart';

import '../../error_provider/error_provider.dart';
import '../default_load_data_result_widget/default_load_data_result_widget.dart';
import '../load_data_result.dart';

abstract class BaseLoadDataResultImplementer<T> extends StatelessWidget {
  final LoadDataResult<T> loadDataResult;
  final ErrorProvider errorProvider;

  @protected
  DefaultLoadDataResultWidget get defaultLoadDataResultWidget;

  const BaseLoadDataResultImplementer({
    super.key,
    required this.loadDataResult,
    required this.errorProvider,
  });
}