import '../future_processing_cancellation/future_processing_cancellation.dart';

abstract class FutureProcessingCancellationCreator<T extends FutureProcessingCancellation> {
  T createFutureProcessingCancellation();
}