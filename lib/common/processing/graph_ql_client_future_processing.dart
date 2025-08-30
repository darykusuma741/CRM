import 'future_processing.dart';
import 'future_processing_cancellation/graphqlfutureprocessingcancellation/graph_ql_future_processing_cancellation.dart';

class GraphQLFutureProcessing<T> extends FutureProcessing<T> {
  GraphQLFutureProcessing(
    Future<T> Function(GraphQLFutureProcessingCancellation) loadDataResultFuture
  ): super(({parameter}) => loadDataResultFuture(parameter));
}