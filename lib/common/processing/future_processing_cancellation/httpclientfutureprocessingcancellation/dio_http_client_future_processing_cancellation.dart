import 'package:dio/dio.dart';

import '../../../error/cancellation_error.dart';
import 'http_client_future_processing_cancellation.dart';

class DioHttpClientFutureProcessingCancellation extends HttpClientFutureProcessingCancellation<CancellationError> {
  final CancelToken cancelToken;

  DioHttpClientFutureProcessingCancellation({
    required this.cancelToken
  });

  @override
  void cancel([dynamic reason]) {
    cancelToken.cancel(reason);
  }

  @override
  CancellationError generateCancelError([dynamic reason]) {
    return CancellationError(message: reason);
  }
}