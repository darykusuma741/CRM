import '../../processing/future_processing_cancellation/graphqlfutureprocessingcancellation/default_graph_ql_future_processing_cancellation.dart';
import '../../processing/future_processing_cancellation/graphqlfutureprocessingcancellation/graph_ql_future_processing_cancellation.dart';
import 'graph_ql_future_processing_cancellation_creator.dart';

class DefaultGraphQLFutureProcessingCancellationCreator extends GraphQLFutureProcessingCancellationCreator {
  @override
  GraphQLFutureProcessingCancellation createGraphQLFutureProcessingCancellation() {
    return DefaultGraphQLFutureProcessingCancellation();
  }
}