import 'package:crm/common/ext/future_ext.dart';
import 'package:crm/common/ext/load_data_result_ext.dart';
import 'package:crm/common/ext/response_wrapper_ext.dart';
import 'package:crm/common/ext/string_ext.dart';
import 'package:crm/data/mapping/lost_entity_mapping_ext.dart';

import '../../../../common/constants/graph_ql_query_constants.dart';
import '../../../../common/error/message_error.dart';
import '../../../../common/graphql/graph_ql.dart';
import '../../../../common/graphql/graph_ql_query_parameter.dart';
import '../../../../common/helper/login_helper.dart';
import '../../../../common/processing/future_processing.dart';
import '../../../../common/processing/graph_ql_client_future_processing.dart';
import '../../../common/load_data_result/load_data_result.dart';
import '../../models/lostpagingdata/lost_paging_data_parameter.dart';
import '../../models/lostpagingdata/lost_paging_data_response.dart';
import '../../models/paging/paging_data.dart';
import '../../models/short_lost.dart';
import 'lost_remote_data_source.dart';

class DefaultLostRemoteDataSource implements LostRemoteDataSource {
  final GraphQL graphQL;

  DefaultLostRemoteDataSource({
    required this.graphQL,
  });

  @override
  FutureProcessing<LostPagingDataResponse> lostPagingData(LostPagingDataParameter lostPagingDataParameter) {
    return GraphQLFutureProcessing((_) async {
      String typeString = () {
        var shortLostType = lostPagingDataParameter.shortLostType;
        if (shortLostType == ShortLostType.pipeline) {
          return "Pipeline";
        } else if (shortLostType == ShortLostType.leads) {
          return "Leads";
        }
        return "";
      }();
      String finalTypeStringTitle = typeString.isNotEmptyString ? "$typeString " : "";
      String finalTypeStringMessage = typeString.isNotEmptyString ? "$typeString lost " : "Lost ";
      String lostEmptyTitle = "${finalTypeStringTitle}Lost Empty";
      String lostEmptyMessage = "${finalTypeStringMessage}is empty";
      var memoryLocalDataStorage = lostPagingDataParameter.memoryLocalDataStorage;
      var lostPagingDataResponse = await () async {
        var lostPagingDataType = lostPagingDataParameter.lostPagingDataType;
        if (lostPagingDataType is InitialLostPagingDataType) {
          var lostPagingDataResponse = await graphQL.query(
            GraphQLQueryParameter(
              queryString: GraphQLQueryConstants().mutationLostPaging(
                userId: (LoginHelper.getLoginData()?.id).toEmptyStringNonNull,
                shortLostType: lostPagingDataParameter.shortLostType
              ),
            )
          ).map<LostPagingDataResponse>(
            onMap: (value) => value.graphQLWrapResponse().mapFromResponseToLostPagingDataResponse(
              lostPagingDataParameter.shortLostType
            )
          );
          if (lostPagingDataParameter.page == 1) {
            memoryLocalDataStorage.shortLostListLoadDataResult = NoLoadDataResult<List<ShortLost>>();
          }
          if (!memoryLocalDataStorage.shortLostListLoadDataResult.isSuccess) {
            memoryLocalDataStorage.shortLostListLoadDataResult = SuccessLoadDataResult<List<ShortLost>>(
              value: lostPagingDataResponse.lostPagingData.data
            );
          } else {
            memoryLocalDataStorage.shortLostListLoadDataResult.resultIfSuccess!.addAll(
              lostPagingDataResponse.lostPagingData.data
            );
          }
          return lostPagingDataResponse;
        } else {
          if (memoryLocalDataStorage.shortLostListLoadDataResult.isSuccess) {
            var shortLostList = memoryLocalDataStorage.shortLostListLoadDataResult.resultIfSuccess!;
            if (shortLostList.isEmpty) {
              throw MessageError(
                title: lostEmptyTitle,
                message: lostEmptyMessage
              );
            }
            return LostPagingDataResponse(
              lostPagingData: PagingData(
                page: 1,
                data: shortLostList
              )
            );
          }
          throw MessageError(
            title: "All Leads Not Loaded",
            message: "All leads must be loaded"
          );
        }
      }();
      var lostPagingData = lostPagingDataResponse.lostPagingData;
      if (lostPagingData.page == 1 && lostPagingData.nextPage == null) {
        lostPagingData.data = List.of(
          lostPagingData.data.where(
            (value) => value.name.toLowerCase().contains(
              lostPagingDataParameter.search.toLowerCase()
            )
          )
        );
        if (lostPagingData.data.isEmpty) {
          throw MessageError(
            title: lostEmptyTitle,
            message: lostEmptyMessage
          );
        }
      }
      return lostPagingDataResponse;
    });
  }
}