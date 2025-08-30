import 'package:crm/common/ext/future_ext.dart';
import 'package:crm/common/ext/response_wrapper_ext.dart';
import 'package:crm/data/mapping/reason_entity_mapping_ext.dart';

import '../../../../common/constants/graph_ql_query_constants.dart';
import '../../../../common/graphql/graph_ql.dart';
import '../../../../common/graphql/graph_ql_mutate_parameter.dart';
import '../../../../common/processing/future_processing.dart';
import '../../../../common/processing/graph_ql_client_future_processing.dart';
import '../../models/lostreasonlist/lost_reason_list_parameter.dart';
import '../../models/lostreasonlist/lost_reason_list_response.dart';
import 'reason_remote_data_source.dart';

class DefaultReasonRemoteDataSource implements ReasonRemoteDataSource {
  final GraphQL graphQL;

  DefaultReasonRemoteDataSource({
    required this.graphQL
  });

  @override
  FutureProcessing<LostReasonListResponse> lostReasonList(LostReasonListParameter lostReasonListParameter) {
    return GraphQLFutureProcessing((_) async {
      return graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().queryLostReason
        )
      ).map<LostReasonListResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToReasonListResponse()
      );
    });
  }
}