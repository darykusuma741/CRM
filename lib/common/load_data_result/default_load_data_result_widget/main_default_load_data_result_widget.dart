import 'package:flutter/material.dart';

import '../../components/custom_loading_indicator.dart';
import '../../error_provider/error_provider.dart';
import '../../helper/widget_helper.dart';
import '../load_data_result.dart';
import 'default_load_data_result_widget.dart';
import 'prompt_indicator.dart';

class MainDefaultLoadDataResultWidget extends DefaultLoadDataResultWidget {
  @override
  Widget noLoadDataResultWidget(BuildContext context, NoLoadDataResult noLoadDataResult) {
    return Container();
  }

  @override
  Widget isLoadingLoadDataResultWidget(BuildContext context, IsLoadingLoadDataResult isLoadingLoadDataResult) {
    return const Center(child: CustomLoadingIndicator());
  }

  @override
  Widget successLoadDataResultWidget(BuildContext context, SuccessLoadDataResult successLoadDataResult) {
    return Container();
  }

  @override
  Widget failedLoadDataResultWidget(BuildContext context, FailedLoadDataResult failedLoadDataResult, ErrorProvider errorProvider, {FailedLoadDataResultConfig? failedLoadDataResultConfig}) {
    return Center(
      child: WidgetHelper.buildFailedPromptIndicatorFromErrorProvider(
        context: context,
        errorProvider: errorProvider,
        e: failedLoadDataResult.e,
        promptIndicatorType: failedLoadDataResultConfig?.promptIndicatorType ?? PromptIndicatorType.vertical
      ),
    );
  }

  @override
  Widget failedLoadDataResultWithButtonWidget(BuildContext context, FailedLoadDataResult failedLoadDataResult, ErrorProvider errorProvider, {FailedLoadDataResultConfig? failedLoadDataResultConfig}) {
    return WidgetHelper.buildFailedPromptIndicatorFromErrorProvider(
      context: context,
      errorProvider: errorProvider,
      e: failedLoadDataResult.e,
      onPressed: failedLoadDataResultConfig?.onPressed,
      buttonText: failedLoadDataResultConfig?.buttonText,
      promptIndicatorType: failedLoadDataResultConfig?.promptIndicatorType ?? PromptIndicatorType.vertical
    );
  }
}

class FailedLoadDataResultConfig {
  void Function()? onPressed;
  String? buttonText;
  PromptIndicatorType promptIndicatorType;

  FailedLoadDataResultConfig({
    this.onPressed,
    this.buttonText,
    this.promptIndicatorType = PromptIndicatorType.vertical
  });
}