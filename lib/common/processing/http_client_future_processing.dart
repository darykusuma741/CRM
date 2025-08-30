import 'future_processing.dart';
import 'future_processing_cancellation/httpclientfutureprocessingcancellation/http_client_future_processing_cancellation.dart';

class HttpClientFutureProcessing<T> extends FutureProcessing<T> {
  HttpClientFutureProcessing(
    Future<T> Function(HttpClientFutureProcessingCancellation) loadDataResultFuture
  ): super(({parameter}) => loadDataResultFuture(parameter));
}