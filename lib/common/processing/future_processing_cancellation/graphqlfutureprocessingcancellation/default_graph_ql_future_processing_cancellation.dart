import '../../../error/cancellation_error.dart';
import 'graph_ql_future_processing_cancellation.dart';

class DefaultGraphQLFutureProcessingCancellation extends GraphQLFutureProcessingCancellation<CancellationError> {
  DefaultGraphQLFutureProcessingCancellation();

  @override
  CancellationError generateCancelError([dynamic reason]) {
    return CancellationError(message: reason);
  }
}