import 'package:crm/common/ext/future_ext.dart';
import 'package:crm/common/ext/load_data_result_ext.dart';
import 'package:crm/common/ext/response_wrapper_ext.dart';
import 'package:crm/common/ext/string_ext.dart';
import 'package:crm/data/mapping/leads_entity_mapping_ext.dart';

import '../../../../common/constants/graph_ql_query_constants.dart';
import '../../../../common/error/message_error.dart';
import '../../../../common/graphql/graph_ql.dart';
import '../../../../common/graphql/graph_ql_mutate_parameter.dart';
import '../../../../common/graphql/graph_ql_query_parameter.dart';
import '../../../../common/helper/login_helper.dart';
import '../../../../common/httpclient/httpclient/http_client.dart';
import '../../../../common/processing/dummy_future_processing.dart';
import '../../../../common/processing/future_processing.dart';
import '../../../../common/processing/graph_ql_client_future_processing.dart';
import '../../../common/load_data_result/load_data_result.dart';
import '../../models/addleads/add_leads_parameter.dart';
import '../../models/addleads/add_leads_response.dart';
import '../../models/converttolostleads/convert_to_lost_leads_parameter.dart';
import '../../models/converttolostleads/convert_to_lost_leads_response.dart';
import '../../models/converttopipeline/convert_to_pipeline_parameter.dart';
import '../../models/converttopipeline/convert_to_pipeline_response.dart';
import '../../models/converttopipeline/convert_to_pipeline_step_1_parameter.dart';
import '../../models/converttopipeline/convert_to_pipeline_step_1_response.dart';
import '../../models/converttopipeline/convert_to_pipeline_step_2_parameter.dart';
import '../../models/converttopipeline/convert_to_pipeline_step_2_response.dart';
import '../../models/editleads/edit_leads_parameter.dart';
import '../../models/editleads/edit_leads_response.dart';
import '../../models/lead.dart';
import '../../models/lead_category.dart';
import '../../models/leadscategory/leads_category_parameter.dart';
import '../../models/leadscategory/leads_category_response.dart';
import '../../models/leadsdetail/leads_detail_parameter.dart';
import '../../models/leadsdetail/leads_detail_response.dart';
import '../../models/leadspagingdata/leads_paging_data_parameter.dart';
import '../../models/leadspagingdata/leads_paging_data_response.dart';
import '../../models/paging/paging_data.dart';
import '../../models/restoreleads/restore_leads_parameter.dart';
import '../../models/restoreleads/restore_leads_response.dart';
import 'leads_remote_data_source.dart';

class DefaultLeadsRemoteDataSource implements LeadsRemoteDataSource {
  final HttpClient httpClient;
  final GraphQL graphQL;

  DefaultLeadsRemoteDataSource({
    required this.httpClient,
    required this.graphQL,
  });

  @override
  FutureProcessing<LeadsDetailResponse> leadsDetail(LeadsDetailParameter leadsDetailParameter) {
    return GraphQLFutureProcessing((_) {
      return graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().mutationLeadsDetail(
            userId: (LoginHelper.getLoginData()?.id).toEmptyStringNonNull,
            leadsId: leadsDetailParameter.leadsId
          ),
        )
      ).map<LeadsDetailResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToLeadsDetailResponse()
      );
    });
  }

  @override
  FutureProcessing<LeadsPagingDataResponse> leadsPagingData(LeadsPagingDataParameter leadsPagingDataParameter) {
    return GraphQLFutureProcessing((_) async {
      String leadsEmptyTitle = "Leads Empty";
      String leadsEmptyMessage = "Leads is empty";
      var memoryLocalDataStorage = leadsPagingDataParameter.memoryLocalDataStorage;
      var leadPagingDataResponse = await () async {
        var leadsPagingDataType = leadsPagingDataParameter.leadsPagingDataType;
        if (leadsPagingDataType is InitialLeadsPagingDataType) {
          var leadsPagingDataResponse = await graphQL.query(
            GraphQLQueryParameter(
              queryString: GraphQLQueryConstants().mutationLeadPaging(
                (LoginHelper.getLoginData()?.id).toEmptyStringNonNull
              ),
            )
          ).map<LeadsPagingDataResponse>(
            onMap: (value) => value.graphQLWrapResponse().mapFromResponseToLeadsPagingDataResponse()
          );
          if (leadsPagingDataParameter.page == 1) {
            memoryLocalDataStorage.shortLeadsListLoadDataResult = NoLoadDataResult<List<ShortLeads>>();
          }
          if (!memoryLocalDataStorage.shortLeadsListLoadDataResult.isSuccess) {
            memoryLocalDataStorage.shortLeadsListLoadDataResult = SuccessLoadDataResult<List<ShortLeads>>(
              value: leadsPagingDataResponse.leadsPagingData.data
            );
          } else {
            memoryLocalDataStorage.shortLeadsListLoadDataResult.resultIfSuccess!.addAll(
              leadsPagingDataResponse.leadsPagingData.data
            );
          }
          return leadsPagingDataResponse;
        } else {
          if (memoryLocalDataStorage.shortLeadsListLoadDataResult.isSuccess) {
            var shortLeadsList = memoryLocalDataStorage.shortLeadsListLoadDataResult.resultIfSuccess!;
            var filteredShortLeadsList = () {
              if (leadsPagingDataType is WithCategoryLeadsPagingDataType) {
                return shortLeadsList.where((shortLeads) {
                  var currentLeadCategory = leadsPagingDataType.leadsCategory;
                  if (currentLeadCategory.id == "-1") {
                    return true;
                  }
                  String lowerCaseLeadStatus = shortLeads.leadStatus.name.toLowerCase();
                  if (currentLeadCategory.id == "1" && lowerCaseLeadStatus.toLowerCase() != "lost") {
                    return true;
                  } else if (currentLeadCategory.id == "-2" && lowerCaseLeadStatus.toLowerCase() == "lost") {
                    return true;
                  }
                  return false;
                }).toList();
              } else {
                return shortLeadsList;
              }
            }();
            if (filteredShortLeadsList.isEmpty) {
              throw MessageError(
                title: leadsEmptyTitle,
                message: leadsEmptyMessage
              );
            }
            return LeadsPagingDataResponse(
              leadsPagingData: PagingData(
                page: 1,
                data: filteredShortLeadsList
              )
            );
          }
          throw MessageError(
            title: "All Leads Not Loaded",
            message: "All leads must be loaded"
          );
        }
      }();
      var leadsPagingData = leadPagingDataResponse.leadsPagingData;
      if (leadsPagingData.page == 1 && leadsPagingData.nextPage == null) {
        leadsPagingData.data = List.of(
          leadsPagingData.data.where(
            (value) => value.name.toLowerCase().contains(
              leadsPagingDataParameter.search.toLowerCase()
            )
          )
        );
        if (leadsPagingData.data.isEmpty) {
          throw MessageError(
            title: leadsEmptyTitle,
            message: leadsEmptyMessage
          );
        }
      }
      return leadPagingDataResponse;
    });
  }

  @override
  FutureProcessing<LeadsCategoryResponse> leadsCategory(LeadsCategoryParameter leadsCategoryParameter) {
    return DummyFutureProcessing((_) async {
      return LeadsCategoryResponse(
        leadCategoryList: <LeadsCategory>[
          LeadsCategory(
            id: "-1",
            name: "All",
            count: 0
          ),
          LeadsCategory(
            id: "1",
            name: "Prospects",
            count: 0
          ),
          LeadsCategory(
            id: "-2",
            name: "Lost",
            count: 0
          ),
        ]
      );
    });
  }

  @override
  FutureProcessing<AddLeadsResponse> addLeads(AddLeadsParameter addLeadsParameter) {
    return GraphQLFutureProcessing((_) {
      return graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().mutationAddLeads(
            name: addLeadsParameter.leadName,
            titleId: addLeadsParameter.titleId,
            titleName: addLeadsParameter.titleName,
            priority: addLeadsParameter.priority.toString(),
            partnerName: addLeadsParameter.companyName,
            website: addLeadsParameter.website,
            email: addLeadsParameter.email,
            contactName: addLeadsParameter.contactName,
            function: addLeadsParameter.jobPosition,
            mobile: addLeadsParameter.phoneNumber,
            street: addLeadsParameter.street,
            street2: addLeadsParameter.street2,
            city: addLeadsParameter.city,
            stateId: addLeadsParameter.stateId,
            zip: addLeadsParameter.zip,
            countryId: addLeadsParameter.countryId
          ),
        )
      ).map<AddLeadsResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToAddLeadsResponse()
      );
    });
  }

  @override
  FutureProcessing<EditLeadsResponse> editLeads(EditLeadsParameter editLeadsParameter) {
    return GraphQLFutureProcessing((_) {
      return graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().mutationEditLeads(
            id: editLeadsParameter.leadId,
            titleId: editLeadsParameter.titleId,
            titleName: editLeadsParameter.titleName,
            name: editLeadsParameter.leadName,
            priority: editLeadsParameter.priority.toString(),
            partnerName: editLeadsParameter.companyName,
            website: editLeadsParameter.website,
            email: editLeadsParameter.email,
            contactName: editLeadsParameter.contactName,
            function: editLeadsParameter.jobPosition,
            mobile: editLeadsParameter.phoneNumber,
            street: editLeadsParameter.street,
            street2: editLeadsParameter.street2,
            city: editLeadsParameter.city,
            stateId: editLeadsParameter.stateId,
            zip: editLeadsParameter.zip,
            countryId: editLeadsParameter.countryId
          ),
        )
      ).map<EditLeadsResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToEditLeadsResponse()
      );
    });
  }

  @override
  FutureProcessing<ConvertToLostLeadsResponse> convertToLostLeads(ConvertToLostLeadsParameter convertToLostLeadsParameter) {
    return GraphQLFutureProcessing((_) {
      return graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().mutationConvertToLostLeads(
            id: convertToLostLeadsParameter.leadsId
          ),
        )
      ).map<ConvertToLostLeadsResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToConvertToLostLeadsResponse()
      );
    });
  }

  FutureProcessing<ConvertToPipelineStep1Response> _convertToPipelineStep1(ConvertToPipelineStep1Parameter convertToPipelineStep1Parameter) {
    return GraphQLFutureProcessing((_) {
      return graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().mutationConvertLeadsToPipelineStep1(
            leadsId: convertToPipelineStep1Parameter.leadsId,
            customerId: convertToPipelineStep1Parameter.customerId
          ),
        )
      ).map<ConvertToPipelineStep1Response>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToConvertToPipelineStep1Response()
      );
    });
  }

  FutureProcessing<ConvertToPipelineStep2Response> _convertToPipelineStep2(ConvertToPipelineStep2Parameter convertToPipelineStep2Parameter) {
    return GraphQLFutureProcessing((_) {
      return graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().mutationConvertLeadsToPipelineStep2(
            lastStep1Id: convertToPipelineStep2Parameter.createCrmLead2OpportunityPartnerId,
            leadsId: convertToPipelineStep2Parameter.leadsId,
            userId: convertToPipelineStep2Parameter.userId
          ),
        )
      ).map<ConvertToPipelineStep2Response>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToConvertToPipelineStep2Response()
      );
    });
  }

  @override
  FutureProcessing<ConvertToPipelineResponse> convertToPipeline(ConvertToPipelineParameter convertToPipelineParameter) {
    return GraphQLFutureProcessing((parameter) async {
      var convertToPipelineStep1Response = await _convertToPipelineStep1(
        ConvertToPipelineStep1Parameter(
          leadsId: convertToPipelineParameter.leadsId,
          customerId: convertToPipelineParameter.customerId,
        )
      ).future(
        parameter: parameter
      );
      await _convertToPipelineStep2(
        ConvertToPipelineStep2Parameter(
          createCrmLead2OpportunityPartnerId: convertToPipelineStep1Response.createCrmLead2OpportunityPartnerId,
          leadsId: convertToPipelineParameter.leadsId,
          userId: (LoginHelper.getLoginData()?.id).toEmptyStringNonNull
        )
      ).future(
        parameter: parameter
      );
      return ConvertToPipelineResponse();
    });
  }

  @override
  FutureProcessing<RestoreLeadsResponse> restoreLeads(RestoreLeadsParameter restoreLeadsParameter) {
    return GraphQLFutureProcessing((_) {
      return graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().mutationRestoreLeads(
            restoreLeadsParameter.leadsId
          ),
        )
      ).map<RestoreLeadsResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToRestoreLeadsResponse()
      );
    });
  }
}