import 'future_processing.dart';
import 'future_processing_cancellation/future_processing_cancellation.dart';

class DummyFutureProcessing<T> extends FutureProcessing<T> {
  DummyFutureProcessing(
    Future<T> Function(FutureProcessingCancellation?) loadDataResultFuture
  ): super(({parameter}) {
    return Future.any([
      if (parameter is FutureProcessingCancellation) parameter.whenCancel.then((e) => throw e),
      loadDataResultFuture(parameter)
    ]);
  });
}