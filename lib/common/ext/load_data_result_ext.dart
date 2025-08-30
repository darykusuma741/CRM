import 'package:crm/common/ext/response_wrapper_ext.dart';
import 'package:dio/dio.dart';

import '../error/cancellation_error.dart';
import '../error/http_client_error.dart';
import '../error/load_data_result_error.dart';
import '../load_data_result/load_data_result.dart';
import '../responsewrapper/response_wrapper.dart';

typedef MapLoadDataResultType<O, T> = O Function(T);

extension LoadDataResultExt<T> on LoadDataResult<T> {
  bool get isSuccess => this is SuccessLoadDataResult<T>;
  bool get isFailed => this is FailedLoadDataResult<T>;
  bool get isFailedBecauseCancellation {
    if (isFailed) {
      dynamic e = resultIfFailed!;
      if (e is HttpClientError) {
        if (e.httpClientErrorType == HttpClientErrorType.cancel) {
          return true;
        }
      } else if (e is CancellationError) {
        return true;
      }
    }
    return false;
  }
  bool get isFailedBecauseUnauthenticatedOrRequiredLogin {
    if (isFailed) {
      dynamic e = resultIfFailed!;
      dynamic data;
      if (e is HttpClientError) {
        data = e.httpClientResponse?.data;
      } else if (e is DioException) {
        data = e.response?.data;
      }
      if (data is Map<String, dynamic>) {
        if (data.containsKey("title")) {
          String response = ResponseWrapper(data["title"]).mapFromResponseToNonNullableString();
          if (response.toLowerCase() == "unauthorized") {
            return true;
          }
        }
      }
    }
    return false;
  }
  bool get isLoading => this is IsLoadingLoadDataResult<T>;
  bool get isNotLoading => this is NoLoadDataResult<T>;
  T? get resultIfSuccess => isSuccess ? (this as SuccessLoadDataResult<T>).value : null;
  dynamic get resultIfFailed => isFailed ? (this as FailedLoadDataResult<T>).e : null;
  void reportToErrorReporterIfError() {
    if (isFailed) {
      (this as FailedLoadDataResult<T>).reportFailedToErrorReporter();
    }
  }

  LoadDataResult<O> map<O>(MapLoadDataResultType<O, T> onMap) {
    if (this is SuccessLoadDataResult<T>) {
      T value = (this as SuccessLoadDataResult<T>).value;
      return SuccessLoadDataResult<O>(value: onMap(value));
    } else if (this is FailedLoadDataResult<T>) {
      FailedLoadDataResult<T> failedLoadDataResult = this as FailedLoadDataResult<T>;
      return FailedLoadDataResult<O>(
        e: failedLoadDataResult.e,
        stackTrace: failedLoadDataResult.stackTrace
      );
    } else if (this is IsLoadingLoadDataResult<T>) {
      return IsLoadingLoadDataResult<O>();
    } else if (this is NoLoadDataResult<T>) {
      return NoLoadDataResult<O>();
    } else {
      try {
        throw LoadDataResultError(message: "Load data result is not suitable.");
      } catch (e, stackTrace) {
        return FailedLoadDataResult<O>(e: e, stackTrace: stackTrace);
      }
    }
  }
}

extension FailedLoadDataResultExt on FailedLoadDataResult {
  void reportFailedToErrorReporter() {
    // ErrorReporterHelper.reportError(
    //   exception: e,
    //   stackTrace: stackTrace
    // );
  }
}