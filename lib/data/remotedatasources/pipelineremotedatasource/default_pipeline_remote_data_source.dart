import 'package:crm/common/ext/future_ext.dart';
import 'package:crm/common/ext/load_data_result_ext.dart';
import 'package:crm/common/ext/response_wrapper_ext.dart';
import 'package:crm/common/ext/string_ext.dart';
import 'package:crm/data/mapping/pipeline_entity_mapping_ext.dart';

import '../../../../common/constants/graph_ql_query_constants.dart';
import '../../../../common/error/message_error.dart';
import '../../../../common/graphql/graph_ql.dart';
import '../../../../common/graphql/graph_ql_mutate_parameter.dart';
import '../../../../common/graphql/graph_ql_query_parameter.dart';
import '../../../../common/helper/login_helper.dart';
import '../../../../common/httpclient/httpclient/http_client.dart';
import '../../../../common/processing/future_processing.dart';
import '../../../../common/processing/graph_ql_client_future_processing.dart';
import '../../../common/load_data_result/load_data_result.dart';
import '../../models/activitycountbasedpipeline/activity_count_based_pipeline_parameter.dart';
import '../../models/activitycountbasedpipeline/activity_count_based_pipeline_response.dart';
import '../../models/addpipeline/add_pipeline_parameter.dart';
import '../../models/addpipeline/add_pipeline_response.dart';
import '../../models/converttolostpipeline/convert_to_lost_pipeline_parameter.dart';
import '../../models/converttolostpipeline/convert_to_lost_pipeline_response.dart';
import '../../models/editpipeline/edit_pipeline_parameter.dart';
import '../../models/editpipeline/edit_pipeline_response.dart';
import '../../models/paging/paging_data.dart';
import '../../models/pipeline.dart';
import '../../models/pipelinecategory/pipeline_category_parameter.dart';
import '../../models/pipelinecategory/pipeline_category_response.dart';
import '../../models/pipelinedetail/pipeline_detail_parameter.dart';
import '../../models/pipelinedetail/pipeline_detail_response.dart';
import '../../models/pipelinenextstage/pipeline_next_stage_parameter.dart';
import '../../models/pipelinenextstage/pipeline_next_stage_response.dart';
import '../../models/pipelinepagingdata/pipeline_paging_data_parameter.dart';
import '../../models/pipelinepagingdata/pipeline_paging_data_response.dart';
import '../../models/pipelinestages/pipeline_stages_parameter.dart';
import '../../models/pipelinestages/pipeline_stages_response.dart';
import '../../models/quotationcountbasedpipeline/quotation_count_based_pipeline_parameter.dart';
import '../../models/quotationcountbasedpipeline/quotation_count_based_pipeline_response.dart';
import '../../models/restorepipeline/restore_pipeline_parameter.dart';
import '../../models/restorepipeline/restore_pipeline_response.dart';
import 'pipeline_remote_data_source.dart';

class DefaultPipelineRemoteDataSource implements PipelineRemoteDataSource {
  final HttpClient httpClient;
  final GraphQL graphQL;

  DefaultPipelineRemoteDataSource({
    required this.httpClient,
    required this.graphQL
  });

  @override
  FutureProcessing<PipelinePagingDataResponse> pipelinePagingData(PipelinePagingDataParameter pipelinePagingDataParameter) {
    return GraphQLFutureProcessing((_) async {
      String pipelineEmptyTitle = "Pipeline Empty";
      String pipelineEmptyMessage = "Pipeline is empty";
      var memoryLocalDataStorage = pipelinePagingDataParameter.memoryLocalDataStorage;
      var pipelinePagingDataResponse = await () async {
        var pipelinePagingDataType = pipelinePagingDataParameter.pipelinePagingDataType;
        if (pipelinePagingDataType is InitialPipelinePagingDataType) {
          var pipelinePagingDataResponse = await graphQL.query(
            GraphQLQueryParameter(
              queryString: GraphQLQueryConstants().mutationPipelinePaging(
                (LoginHelper.getLoginData()?.id).toEmptyStringNonNull
              ),
            )
          ).map<PipelinePagingDataResponse>(
            onMap: (value) => value.graphQLWrapResponse().mapFromResponseToPipelinePagingDataResponse()
          );
          if (pipelinePagingDataParameter.page == 1) {
            memoryLocalDataStorage.shortPipelineListLoadDataResult = NoLoadDataResult<List<ShortPipeline>>();
          }
          if (!memoryLocalDataStorage.shortPipelineListLoadDataResult.isSuccess) {
            memoryLocalDataStorage.shortPipelineListLoadDataResult = SuccessLoadDataResult<List<ShortPipeline>>(
              value: pipelinePagingDataResponse.pipelinePagingData.data
            );
          } else {
            memoryLocalDataStorage.shortPipelineListLoadDataResult.resultIfSuccess!.addAll(
              pipelinePagingDataResponse.pipelinePagingData.data
            );
          }
          return pipelinePagingDataResponse;
        } else {
          if (memoryLocalDataStorage.shortPipelineListLoadDataResult.isSuccess) {
            var shortPipelineList = memoryLocalDataStorage.shortPipelineListLoadDataResult.resultIfSuccess!;
            var filteredShortPipelineList = () {
              if (pipelinePagingDataType is WithCategoryPipelinePagingDataType) {
                return shortPipelineList.where((shortPipeline) {
                  var currentPipelineCategory = pipelinePagingDataType.pipelineCategory;
                  if (currentPipelineCategory.id == "-1") {
                    return true;
                  }
                  if (pipelinePagingDataType.pipelineCategory.id == "-2" && shortPipeline.isLost) {
                    return true;
                  } else if (shortPipeline.isLost) {
                    return false;
                  }
                  return shortPipeline.pipelineStatus.name.toLowerCase() == pipelinePagingDataType.pipelineCategory.name.toLowerCase();
                }).toList();
              } else {
                return shortPipelineList;
              }
            }();
            if (filteredShortPipelineList.isEmpty) {
              throw MessageError(
                title: pipelineEmptyTitle,
                message: pipelineEmptyMessage
              );
            }
            return PipelinePagingDataResponse(
              pipelinePagingData: PagingData(
                page: 1,
                data: filteredShortPipelineList
              )
            );
          }
          throw MessageError(
            title: "All Pipeline Not Loaded",
            message: "All pipeline must be loaded"
          );
        }
      }();
      var pipelinePagingData = pipelinePagingDataResponse.pipelinePagingData;
      if (pipelinePagingData.page == 1 && pipelinePagingData.nextPage == null) {
        pipelinePagingData.data = List.of(
          pipelinePagingData.data.where(
            (value) => value.name.toLowerCase().contains(
              pipelinePagingDataParameter.search.toLowerCase()
            )
          )
        );
        if (pipelinePagingData.data.isEmpty) {
          throw MessageError(
            title: pipelineEmptyTitle,
            message: pipelineEmptyMessage
          );
        }
      }
      return pipelinePagingDataResponse;
    });
  }

  @override
  FutureProcessing<PipelineCategoryResponse> pipelineCategory(PipelineCategoryParameter pipelineCategoryParameter) {
    return GraphQLFutureProcessing((_) {
      return graphQL.query(
        GraphQLQueryParameter(
          queryString: GraphQLQueryConstants().queryPipelineCategory
        )
      ).map<PipelineCategoryResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToPipelineCategoryResponse()
      );
    });
  }

  @override
  FutureProcessing<AddPipelineResponse> addPipeline(AddPipelineParameter addPipelineParameter) {
    return GraphQLFutureProcessing((_) {
      return graphQL.mutate(
        GraphQLMutateParameter(
          queryString: () {
            if (addPipelineParameter is CreateNewCustomerAddPipelineParameter) {
              var result = GraphQLQueryConstants().mutationAddPipeline(
                name: addPipelineParameter.name,
                priority: addPipelineParameter.priority.toString(),
                partnerName: addPipelineParameter.customerName,
                website: addPipelineParameter.website,
                contactName: addPipelineParameter.contactName,
                function: addPipelineParameter.opportunity,
                mobile: addPipelineParameter.contactPhoneNumber,
                email: addPipelineParameter.contactEmail,
                type: "opportunity",
                userId: (LoginHelper.getLoginData()?.id).toEmptyStringNonNull,
                expectedRevenue: addPipelineParameter.expectedRevenueFirst.toString(),
                dateDeadline: addPipelineParameter.expectedClosing
              );
              return result;
            } else if (addPipelineParameter is LinkWithCustomerAddPipelineParameter) {
              var result = GraphQLQueryConstants().mutationAddPipeline(
                name: addPipelineParameter.name,
                priority: addPipelineParameter.priority.toString(),
                partnerName: addPipelineParameter.name.toString(),
                website: addPipelineParameter.website,
                contactName: addPipelineParameter.contactName,
                function: addPipelineParameter.opportunity,
                mobile: addPipelineParameter.contactPhoneNumber,
                email: addPipelineParameter.contactEmail,
                type: "opportunity",
                userId: (LoginHelper.getLoginData()?.id).toEmptyStringNonNull,
                partnerId: addPipelineParameter.customerId,
                expectedRevenue: addPipelineParameter.expectedRevenueFirst.toString(),
                dateDeadline: addPipelineParameter.expectedClosing
              );
              return result;
            }
            throw MessageError(
              title: "Parameter Pipeline",
              message: "Parameter is not pipeline",
            );
          }()
        )
      ).map<AddPipelineResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToAddPipelineResponse()
      );
    });
  }

  @override
  FutureProcessing<EditPipelineResponse> editPipeline(EditPipelineParameter editPipelineParameter) {
    return GraphQLFutureProcessing((_) {
      return graphQL.mutate(
        GraphQLMutateParameter(
          queryString: () {
            return GraphQLQueryConstants().mutationEditPipeline(
              id: editPipelineParameter.pipelineId,
              customerId: editPipelineParameter.customerId,
              name: editPipelineParameter.name,
              priority: editPipelineParameter.priority.toString(),
              partnerName: editPipelineParameter.customerName,
              website: editPipelineParameter.website,
              contactName: editPipelineParameter.contactName,
              function: editPipelineParameter.opportunity,
              mobile: editPipelineParameter.contactPhoneNumber,
              email: editPipelineParameter.contactEmail,
              expectedRevenue: editPipelineParameter.expectedRevenueFirst.toString(),
              dateDeadline: editPipelineParameter.expectedClosing
            );
          }()
        )
      ).map<EditPipelineResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToEditPipelineResponse()
      );
    });
  }

  @override
  FutureProcessing<PipelineDetailResponse> pipelineDetail(PipelineDetailParameter pipelineDetailParameter) {
    return GraphQLFutureProcessing((_) {
      return graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().mutationPipelineDetail(
            userId: (LoginHelper.getLoginData()?.id).toEmptyStringNonNull,
            pipelineId: pipelineDetailParameter.pipelineId
          )
        )
      ).map<PipelineDetailResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToPipelineDetailResponse()
      );
    });
  }

  @override
  FutureProcessing<PipelineStagesResponse> pipelineStages(PipelineStagesParameter pipelineStagesParameter) {
    return GraphQLFutureProcessing((_) {
      return graphQL.query(
        GraphQLQueryParameter(
          queryString: GraphQLQueryConstants().queryPipelineCategory
        )
      ).map<PipelineStagesResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToPipelineStagesResponse()
      );
    });
  }

  @override
  FutureProcessing<ConvertToLostPipelineResponse> convertToLostPipeline(ConvertToLostPipelineParameter convertToLostPipelineParameter) {
    return GraphQLFutureProcessing((_) {
      return graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().mutationConvertToLostLeads(
            id: convertToLostPipelineParameter.pipelineId,
            lostReasonId: convertToLostPipelineParameter.lostReasonId
          )
        )
      ).map<ConvertToLostPipelineResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToConvertToLostPipelineResponse()
      );
    });
  }

  @override
  FutureProcessing<PipelineNextStageResponse> pipelineNextStage(PipelineNextStageParameter pipelineNextStageParameter) {
    return GraphQLFutureProcessing((parameter) async {
      var pipelineStagesResponse = await pipelineStages(
        PipelineStagesParameter(
          pipelineId: pipelineNextStageParameter.pipelineId
        )
      ).future(
        parameter: parameter
      );
      var pipelineStageList = pipelineStagesResponse.pipelineStageList;
      var pipelineDetailResponse = await pipelineDetail(
        PipelineDetailParameter(
          pipelineId: pipelineNextStageParameter.pipelineId
        )
      ).future(
        parameter: parameter
      );
      var pipelineDetailValue = pipelineDetailResponse.pipelineDetail;
      int i = 0;
      int currentI = -1;
      while (i < pipelineStageList.length) {
        var iteratedPipelineStage = pipelineStageList[i];
        if (iteratedPipelineStage.id == pipelineDetailValue.pipelineStatus.id) {
          currentI = i;
        }
        i++;
      }
      if (currentI == -1) {
        throw MessageError(
          title: "Pipeline Stage Not Found",
          message: "For now pipeline stage is not found"
        );
      }
      int newI = currentI + 1;
      if (newI > pipelineStageList.length - 1) {
        newI = pipelineStageList.length - 1;
      }
      return graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().mutationPipelineChangeStage(
            pipelineId: pipelineNextStageParameter.pipelineId,
            stageId: pipelineStageList[newI].id,
          )
        )
      ).map<PipelineNextStageResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToPipelineNextStageResponse()
      );
    });
  }

  @override
  FutureProcessing<RestorePipelineResponse> restorePipeline(RestorePipelineParameter restorePipelineParameter) {
    return GraphQLFutureProcessing((_) {
      return graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().mutationRestorePipeline(
            restorePipelineParameter.pipelineId
          )
        )
      ).map<RestorePipelineResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToRestorePipelineResponse()
      );
    });
  }

  @override
  FutureProcessing<ActivityCountBasedPipelineResponse> activityCountBasedPipelineResponse(ActivityCountBasedPipelineParameter activityCountBasedPipelineParameter) {
    return GraphQLFutureProcessing((_) {
      return graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().mutationActivityCountBasedPipeline(
            activityCountBasedPipelineParameter.pipelineId
          )
        )
      ).map<ActivityCountBasedPipelineResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToActivityCountBasedPipelineResponse()
      );
    });
  }

  @override
  FutureProcessing<QuotationCountBasedPipelineResponse> quotationCountBasedPipelineResponse(QuotationCountBasedPipelineParameter quotationCountBasedPipelineParameter) {
    return GraphQLFutureProcessing((_) {
      return graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().mutationQuotationCountBasedPipeline(
            quotationCountBasedPipelineParameter.pipelineId
          )
        )
      ).map<QuotationCountBasedPipelineResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToQuotationCountBasedPipelineResponse()
      );
    });
  }
}