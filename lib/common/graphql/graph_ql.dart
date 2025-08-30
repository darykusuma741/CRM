import 'graph_ql_mutate_parameter.dart';
import 'graph_ql_mutate_response.dart';
import 'graph_ql_query_parameter.dart';
import 'graph_ql_query_response.dart';

abstract class GraphQL {
  Future<GraphQLQueryResponse> query(GraphQLQueryParameter parameter);
  Future<GraphQLMutateResponse> mutate(GraphQLMutateParameter parameter);
}