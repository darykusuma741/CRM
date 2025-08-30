import '../../processing/future_processing_cancellation/graphqlfutureprocessingcancellation/graph_ql_future_processing_cancellation.dart';
import '../../processing/future_processing_cancellation_creator/future_processing_cancellation_creator.dart';

abstract class GraphQLFutureProcessingCancellationCreator extends FutureProcessingCancellationCreator<GraphQLFutureProcessingCancellation> {
  GraphQLFutureProcessingCancellation createGraphQLFutureProcessingCancellation();

  @override
  GraphQLFutureProcessingCancellation createFutureProcessingCancellation() {
    return createGraphQLFutureProcessingCancellation();
  }
}