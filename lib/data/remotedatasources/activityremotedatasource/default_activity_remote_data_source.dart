import 'package:crm/common/ext/future_ext.dart';
import 'package:crm/common/ext/load_data_result_ext.dart';
import 'package:crm/common/ext/response_wrapper_ext.dart';
import 'package:crm/common/ext/string_ext.dart';
import 'package:crm/data/mapping/activity_entity_mapping_ext.dart';

import '../../../../common/constants/graph_ql_query_constants.dart';
import '../../../../common/error/message_error.dart';
import '../../../../common/graphql/graph_ql.dart';
import '../../../../common/graphql/graph_ql_mutate_parameter.dart';
import '../../../../common/graphql/graph_ql_query_parameter.dart';
import '../../../../common/helper/date_helper.dart';
import '../../../../common/helper/login_helper.dart';
import '../../../../common/processing/future_processing.dart';
import '../../../../common/processing/graph_ql_client_future_processing.dart';
import '../../../common/helper/activity_helper.dart';
import '../../../common/load_data_result/load_data_result.dart';
import '../../../common/memory_local_data_storage.dart';
import '../../models/activity_pipeline_category.dart';
import '../../models/activitycalendar/activity_calendar_check_in_out_parameter.dart';
import '../../models/activitycalendar/activity_calendar_check_in_out_response.dart';
import '../../models/activitycalendar/activity_calendar_data.dart';
import '../../models/activitycalendar/activity_calendar_data_parameter.dart';
import '../../models/activitycalendar/activity_calendar_data_response.dart';
import '../../models/activitycalendar/activity_calendar_paging_data_parameter.dart';
import '../../models/activitycalendar/activity_calendar_paging_data_response.dart';
import '../../models/activitydetail/activity_detail_parameter.dart';
import '../../models/activitydetail/activity_detail_response.dart';
import '../../models/activitypipelinecategory/activity_pipeline_category_parameter.dart';
import '../../models/activitypipelinecategory/activity_pipeline_category_response.dart';
import '../../models/activitypipelinepagingdata/activity_pipeline_paging_data_parameter.dart';
import '../../models/activitypipelinepagingdata/activity_pipeline_paging_data_response.dart';
import '../../models/activitypipelineschedule/activity_pipeline_schedule_parameter.dart';
import '../../models/activitypipelineschedule/activity_pipeline_schedule_response.dart';
import '../../models/addactivity/add_activity_parameter.dart';
import '../../models/addactivity/add_activity_response.dart';
import '../../models/addactivitypipeline/add_activity_pipeline_parameter.dart';
import '../../models/addactivitypipeline/add_activity_pipeline_response.dart';
import '../../models/checkinactivitycalendar/check_in_activity_calendar_parameter.dart';
import '../../models/checkinactivitycalendar/check_in_activity_calendar_response.dart';
import '../../models/checkinactivitypipeline/check_in_activity_pipeline_parameter.dart';
import '../../models/checkinactivitypipeline/check_in_activity_pipeline_response.dart';
import '../../models/checkoutactivitycalendar/check_out_activity_calendar_parameter.dart';
import '../../models/checkoutactivitycalendar/check_out_activity_calendar_response.dart';
import '../../models/checkoutactivitypipeline/check_out_activity_pipeline_parameter.dart';
import '../../models/checkoutactivitypipeline/check_out_activity_pipeline_response.dart';
import '../../models/deleteactivity/delete_activity_parameter.dart';
import '../../models/deleteactivity/delete_activity_response.dart';
import '../../models/doneactivitypipeline/done_activity_pipeline_parameter.dart';
import '../../models/doneactivitypipeline/done_activity_pipeline_response.dart';
import '../../models/editactivity/edit_activity_parameter.dart';
import '../../models/editactivity/edit_activity_response.dart';
import '../../models/employeebaseduser/employee_based_user_parameter.dart';
import '../../models/historyactivity/history_activity_parameter.dart';
import '../../models/historyactivity/history_activity_response.dart';
import '../../models/historypipelineactivity/history_pipeline_activity_parameter.dart';
import '../../models/historypipelineactivity/history_pipeline_activity_response.dart';
import '../../models/paging/paging_data.dart';
import '../../models/recommendationactivitypipelinetype/recommendation_activity_pipeline_type_parameter.dart';
import '../../models/recommendationactivitypipelinetype/recommendation_activity_pipeline_type_response.dart';
import '../../models/short_activity.dart';
import '../../models/undoneactivitypipeline/undone_activity_pipeline_parameter.dart';
import '../../models/undoneactivitypipeline/undone_activity_pipeline_response.dart';
import '../userremotedatasource/user_remote_data_source.dart';
import 'activity_remote_data_source.dart';

class DefaultActivityRemoteDataSource implements ActivityRemoteDataSource {
  final GraphQL graphQL;
  final UserRemoteDataSource userRemoteDataSource;

  DefaultActivityRemoteDataSource({
    required this.graphQL,
    required this.userRemoteDataSource
  });

  @override
  FutureProcessing<HistoryPipelineActivityResponse> historyPipelineActivity(HistoryPipelineActivityParameter historyPipelineActivityParameter) {
    return GraphQLFutureProcessing((parameter) async {
      var activityPipelineCategoryList = await activityPipelineCategory(
        ActivityPipelineCategoryParameter()
      ).future(
        parameter: parameter
      ).map<List<ActivityPipelineCategory>>(
        onMap: (response) => response.activityPipelineCategoryList
      );
      var activityCalendarPagingDataResponse = await activityCalendarPagingData(
        ActivityCalendarPagingDataParameter(
          page: 1,
          dataCountPerPage: 15,
          activityCalendarPagingDataType: InitialActivityCalendarPagingDataType(),
          search: "",
          memoryLocalDataStorage: MemoryLocalDataStorage(),
          dateTimeFrom: null,
          dateTimeTo: null
        )
      ).future(
        parameter: parameter
      );
      return graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().mutationHistoryPipelineActivity(
            historyPipelineActivityParameter.pipelineId
          ),
        )
      ).map<HistoryPipelineActivityResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToHistoryPipelineActivityResponse(
          activityCategoryList: activityPipelineCategoryList,
          shortActivityList: activityCalendarPagingDataResponse.activityPagingData.data
        )
      );
    });
  }

  @override
  FutureProcessing<HistoryActivityResponse> historyActivity(HistoryActivityParameter historyActivityParameter) {
    return GraphQLFutureProcessing((parameter) async {
      var activityPipelineCategoryList = await activityPipelineCategory(
        ActivityPipelineCategoryParameter()
      ).future(
        parameter: parameter
      ).map<List<ActivityPipelineCategory>>(
        onMap: (response) => response.activityPipelineCategoryList
      );
      var activityCalendarPagingDataResponse = await activityCalendarPagingData(
        ActivityCalendarPagingDataParameter(
          page: 1,
          dataCountPerPage: 15,
          activityCalendarPagingDataType: InitialActivityCalendarPagingDataType(),
          search: "",
          memoryLocalDataStorage: MemoryLocalDataStorage(),
          dateTimeFrom: null,
          dateTimeTo: null
        )
      ).future(
        parameter: parameter
      );
      return graphQL.query(
        GraphQLQueryParameter(
          queryString: () {
            var userId = (LoginHelper.getLoginData()?.id).toEmptyStringNonNull;
            var type = historyActivityParameter.type;
            if (type == HistoryActivityParameterType.pipeline) {
              return GraphQLQueryConstants().queryHistoryActivityForPipeline(userId);
            } else if (type == HistoryActivityParameterType.calendar) {
              return GraphQLQueryConstants().queryHistoryActivityForCalendar(userId);
            }
            return "";
          }(),
        )
      ).map<HistoryActivityResponse>(
        onMap: (value) {
          return value.graphQLWrapResponse().mapFromResponseToHistoryActivityResponse(
            type: historyActivityParameter.type,
            activityPipelineCategoryList: activityPipelineCategoryList,
            shortActivityList: activityCalendarPagingDataResponse.activityPagingData.data
          );
        }
      );
    });
  }

  @override
  FutureProcessing<ActivityCalendarDataResponse> activityCalendarData(ActivityCalendarDataParameter activityCalendarDataParameter) {
    return GraphQLFutureProcessing((parameter) async {
      var activityPipelineCategoryList = await activityPipelineCategory(
        ActivityPipelineCategoryParameter()
      ).future(
        parameter: parameter
      ).map<List<ActivityPipelineCategory>>(
        onMap: (response) => response.activityPipelineCategoryList
      );
      var activityCalendarPagingDataResponse = await graphQL.query(
        GraphQLQueryParameter(
          queryString: GraphQLQueryConstants().queryActivityCalendar(
            (LoginHelper.getLoginData()?.id).toEmptyStringNonNull
          )
        )
      ).map<ActivityCalendarPagingDataResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToActivityCalendarPagingDataResponse(
          activityCategoryList: activityPipelineCategoryList,
          isMeetingGeneral: true
        )
      );
      var data = activityCalendarPagingDataResponse.activityPagingData.data;
      List<ActivityCalendarData> activityCalendarDataList = [];
      int i = 0;
      while (i < data.length) {
        var shortActivity = data[i];
        if (shortActivity.startDate != null) {
          var activityCalendarData = activityCalendarDataList.where((
            (value) => DateHelper.comparingEqualsWithoutCheckingTime(
              shortActivity.startDate!,
              value.dateTime
            )
          )).firstOrNull;
          if (activityCalendarData == null) {
            activityCalendarDataList.add(
              ActivityCalendarData(
                count: 1,
                dateTime: shortActivity.startDate!
              )
            );
          } else {
            activityCalendarData.count += 1;
          }
        }
        i++;
      }
      return ActivityCalendarDataResponse(
        activityCalendarDataList: activityCalendarDataList
      );
    });
  }

  @override
  FutureProcessing<ActivityCalendarCheckInOutResponse> activityCalendarCheckInOut(ActivityCalendarCheckInOutParameter activityCalendarCheckInOutParameter) {
    return GraphQLFutureProcessing((parameter) async {
      var activityCalendarPagingDataResponse = await activityCalendarPagingData(
        ActivityCalendarPagingDataParameter(
          page: 1,
          dataCountPerPage: 15,
          activityCalendarPagingDataType: InitialActivityCalendarPagingDataType(),
          search: "",
          memoryLocalDataStorage: MemoryLocalDataStorage(),
          dateTimeFrom: null,
          dateTimeTo: null
        )
      ).future(
        parameter: parameter
      );
      return ActivityHelper.checkActivityCheckInAndOutStatus(
        activityCalendarPagingDataResponse.activityPagingData.data
      );
    });
  }

  @override
  FutureProcessing<ActivityCalendarPagingDataResponse> activityCalendarPagingData(ActivityCalendarPagingDataParameter activityCalendarPagingDataParameter) {
    return GraphQLFutureProcessing((parameter) async {
      String activityCalendarEmptyTitle = "Activity Empty";
      String activityCalendarEmptyMessage = "Activity is empty";
      var memoryLocalDataStorage = activityCalendarPagingDataParameter.memoryLocalDataStorage;
      var activityCalendarPagingDataResponse = await () async {
        var activityCalendarPagingDataType = activityCalendarPagingDataParameter.activityCalendarPagingDataType;
        if (activityCalendarPagingDataType is InitialActivityCalendarPagingDataType) {
          var activityPipelineCategoryList = await activityPipelineCategory(
            ActivityPipelineCategoryParameter()
          ).future(
            parameter: parameter
          ).map<List<ActivityPipelineCategory>>(
            onMap: (response) => response.activityPipelineCategoryList
          );
          var activityCalendarPagingDataResponse = await graphQL.query(
            GraphQLQueryParameter(
              queryString: GraphQLQueryConstants().queryActivityCalendar(
                (LoginHelper.getLoginData()?.id).toEmptyStringNonNull
              )
            )
          ).map<ActivityCalendarPagingDataResponse>(
            onMap: (value) => value.graphQLWrapResponse().mapFromResponseToActivityCalendarPagingDataResponse(
              activityCategoryList: activityPipelineCategoryList,
              isMeetingGeneral: true
            )
          );
          if (activityCalendarPagingDataParameter.page == 1) {
            memoryLocalDataStorage.shortActivityListLoadDataResult = NoLoadDataResult<List<ShortActivity>>();
          }
          if (!memoryLocalDataStorage.shortActivityListLoadDataResult.isSuccess) {
            memoryLocalDataStorage.shortActivityListLoadDataResult = SuccessLoadDataResult<List<ShortActivity>>(
              value: activityCalendarPagingDataResponse.activityPagingData.data
            );
          } else {
            memoryLocalDataStorage.shortActivityListLoadDataResult.resultIfSuccess!.addAll(
              activityCalendarPagingDataResponse.activityPagingData.data
            );
          }
          return activityCalendarPagingDataResponse;
        } else {
          if (memoryLocalDataStorage.shortActivityListLoadDataResult.isSuccess) {
            var shortActivityList = memoryLocalDataStorage.shortActivityListLoadDataResult.resultIfSuccess!;
            if (shortActivityList.isEmpty) {
              throw MessageError(
                title: activityCalendarEmptyTitle,
                message: activityCalendarEmptyMessage
              );
            }
            return ActivityCalendarPagingDataResponse(
              activityPagingData: PagingData(
                page: 1,
                data: shortActivityList
              )
            );
          }
          throw MessageError(
            title: "All Activity Not Loaded",
            message: "All Activity must be loaded"
          );
        }
      }();
      var activityCalendarPagingData = activityCalendarPagingDataResponse.activityPagingData;
      if (activityCalendarPagingData.page == 1 && activityCalendarPagingData.nextPage == null) {
        // Search
        activityCalendarPagingData.data = List.of(
          activityCalendarPagingData.data.where(
            (value) => value.name.toLowerCase().contains(
              activityCalendarPagingDataParameter.search.toLowerCase()
            )
          )
        );
        // Filter Based Data From and To
        activityCalendarPagingData.data = List.of(
          activityCalendarPagingData.data.where(
            (value) {
              var startDate = value.startDate;
              if (startDate == null) {
                return false;
              }
              var dateTimeFrom = activityCalendarPagingDataParameter.dateTimeFrom;
              var dateTimeTo = activityCalendarPagingDataParameter.dateTimeTo;
              if (dateTimeFrom != null && dateTimeTo == null) {
                return DateHelper.comparingEqualsWithoutCheckingTime(startDate, dateTimeFrom);
              } else if (dateTimeFrom == null && dateTimeTo != null) {
                return DateHelper.comparingEqualsWithoutCheckingTime(startDate, dateTimeTo);
              } else if (dateTimeFrom != null && dateTimeTo != null) {
                return DateHelper.isInRangeInclusiveIgnoringTime(startDate, dateTimeFrom, dateTimeTo);
              } else {
                return true;
              }
            }
          )
        );
        if (activityCalendarPagingData.data.isEmpty) {
          throw MessageError(
            title: activityCalendarEmptyTitle,
            message: activityCalendarEmptyMessage
          );
        }
      }
      return activityCalendarPagingDataResponse;
    });
  }

  @override
  FutureProcessing<ActivityPipelineCategoryResponse> activityPipelineCategory(ActivityPipelineCategoryParameter activityPipelineCategoryParameter) {
    return GraphQLFutureProcessing((_) {
      return graphQL.query(
        GraphQLQueryParameter(
          queryString: GraphQLQueryConstants().mutationActivityCategory
        )
      ).map<ActivityPipelineCategoryResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToActivityPipelineCategoryResponse()
      );
    });
  }

  @override
  FutureProcessing<ActivityDetailResponse> activityDetail(ActivityDetailParameter activityDetailParameter) {
    return GraphQLFutureProcessing((parameter) async {
      var activityPipelineCategoryList = await activityPipelineCategory(
        ActivityPipelineCategoryParameter()
      ).future(
        parameter: parameter
      ).map<List<ActivityPipelineCategory>>(
        onMap: (response) => response.activityPipelineCategoryList
      );
      var response = graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().queryActivityCalendarDetail(
            activityDetailParameter.activityId
          ),
        )
      ).map<ActivityDetailResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToActivityDetailResponse(
          activityCategoryList: activityPipelineCategoryList,
          isMeetingGeneral: activityDetailParameter.isMeetingGeneral
        )
      );
      return response;
    });
  }

  @override
  FutureProcessing<ActivityPipelinePagingDataResponse> activityPipelinePagingData(ActivityPipelinePagingDataParameter activityPipelinePagingDataParameter) {
    return GraphQLFutureProcessing((parameter) async {
      String activityPipelineEmptyTitle = "Activity Pipeline Empty";
      String activityPipelineEmptyMessage = "Activity pipeline is empty";
      var memoryLocalDataStorage = activityPipelinePagingDataParameter.memoryLocalDataStorage;
      var activityPipelinePagingDataResponse = await () async {
        var activityPipelinePagingDataType = activityPipelinePagingDataParameter.activityPipelinePagingDataType;
        if (activityPipelinePagingDataType is InitialActivityPipelinePagingDataType) {
          var activityCalendarPagingDataResponse = await activityCalendarPagingData(
            ActivityCalendarPagingDataParameter(
              page: 1,
              dataCountPerPage: 15,
              activityCalendarPagingDataType: InitialActivityCalendarPagingDataType(),
              search: "",
              memoryLocalDataStorage: MemoryLocalDataStorage(),
              dateTimeFrom: null,
              dateTimeTo: null
            )
          ).future(
            parameter: parameter
          );
          var activityPipelineCategoryList = await activityPipelineCategory(
            ActivityPipelineCategoryParameter()
          ).future(
            parameter: parameter
          ).map<List<ActivityPipelineCategory>>(
            onMap: (response) => response.activityPipelineCategoryList
          );
          var activityPipelinePagingDataResponse = await graphQL.query(
            GraphQLQueryParameter(
              queryString: () {
                var activityPipelinePagingDataInputType = activityPipelinePagingDataParameter.activityPipelinePagingDataInputType;
                if (activityPipelinePagingDataInputType is BasedPipelineActivityPipelinePagingDataInputType) {
                  return GraphQLQueryConstants().mutationActivityPipelineBasedPipeline(activityPipelinePagingDataInputType.pipelineId);
                } else {
                  return GraphQLQueryConstants().mutationActivityPipelinePaging;
                }
              }(),
            )
          ).map<ActivityPipelinePagingDataResponse>(
            onMap: (value) => value.graphQLWrapResponse().mapFromResponseToActivityPipelinePagingDataResponse(
              activityCategoryList: activityPipelineCategoryList,
              isMeetingGeneral: false,
              shortActivityList: activityCalendarPagingDataResponse.activityPagingData.data
            )
          );
          if (activityPipelinePagingDataParameter.page == 1) {
            memoryLocalDataStorage.shortActivityListLoadDataResult = NoLoadDataResult<List<ShortActivity>>();
          }
          if (!memoryLocalDataStorage.shortActivityListLoadDataResult.isSuccess) {
            memoryLocalDataStorage.shortActivityListLoadDataResult = SuccessLoadDataResult<List<ShortActivity>>(
              value: activityPipelinePagingDataResponse.activityPagingData.data
            );
          } else {
            memoryLocalDataStorage.shortActivityListLoadDataResult.resultIfSuccess!.addAll(
              activityPipelinePagingDataResponse.activityPagingData.data
            );
          }
          return activityPipelinePagingDataResponse;
        } else {
          if (memoryLocalDataStorage.shortActivityListLoadDataResult.isSuccess) {
            var shortActivityList = memoryLocalDataStorage.shortActivityListLoadDataResult.resultIfSuccess!;
            var filteredShortActivityList = () {
              if (activityPipelinePagingDataType is WithCategoryActivityPipelinePagingDataType) {
                return shortActivityList.where((shortActivity) {
                  var currentActivityPipelineCategory = activityPipelinePagingDataType.activityPipelineCategory;
                  if (currentActivityPipelineCategory.id == "-1") {
                    return true;
                  }
                  return shortActivity.type.toLowerCase() == currentActivityPipelineCategory.name.toLowerCase();
                }).toList();
              } else {
                return shortActivityList;
              }
            }();
            if (filteredShortActivityList.isEmpty) {
              throw MessageError(
                title: activityPipelineEmptyTitle,
                message: activityPipelineEmptyMessage
              );
            }
            return ActivityPipelinePagingDataResponse(
              activityPagingData: PagingData(
                page: 1,
                data: filteredShortActivityList
              )
            );
          }
          throw MessageError(
            title: "All Activity Pipeline Not Loaded",
            message: "All activity pipeline must be loaded"
          );
        }
      }();
      var activityPipelinePagingData = activityPipelinePagingDataResponse.activityPagingData;
      if (activityPipelinePagingData.page == 1 && activityPipelinePagingData.nextPage == null) {
        activityPipelinePagingData.data = List.of(
          activityPipelinePagingData.data.where(
            (value) => value.name.toLowerCase().contains(
              activityPipelinePagingDataParameter.search.toLowerCase()
            )
          )
        );
        if (activityPipelinePagingData.data.isEmpty) {
          throw MessageError(
            title: activityPipelineEmptyTitle,
            message: activityPipelineEmptyMessage
          );
        }
      }
      return activityPipelinePagingDataResponse;
    });
  }

  @override
  FutureProcessing<AddActivityResponse> addActivity(AddActivityParameter addActivityParameter) {
    return GraphQLFutureProcessing((_) async {
      Future<String> getActivityCreationLeadModelId() async {
        var activityCreationLeadModelId = await graphQL.mutate(
          GraphQLMutateParameter(
            queryString: GraphQLQueryConstants().mutationActivityCreationLeadModel
          )
        ).map<String>(
          onMap: (value) => value.graphQLWrapResponse().mapFromResponseToActivityCreationLeadModelId()
        );
        return activityCreationLeadModelId;
      }
      var activityCreationLeadModelId = await getActivityCreationLeadModelId();
      return graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().mutationAddActivity(
            name: addActivityParameter.name,
            startDate: addActivityParameter.start,
            stopDate: addActivityParameter.stop,
            userId: (LoginHelper.getLoginData()?.id).toEmptyStringNonNull,
            activityCreationLeadModelId: activityCreationLeadModelId,
            location: addActivityParameter.location,
            meetingUrl: addActivityParameter.meetingUrl,
            description: addActivityParameter.description
          ),
        )
      ).map<AddActivityResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToAddActivityResponse()
      );
    });
  }

  @override
  FutureProcessing<DeleteActivityResponse> deleteActivity(DeleteActivityParameter deleteActivityParameter) {
    return GraphQLFutureProcessing((parameter) async {
      var activityCalendarCheckInOutResponse = await activityCalendarCheckInOut(
        ActivityCalendarCheckInOutParameter()
      ).future(
        parameter: parameter
      );
      var checkedInShortActivity = activityCalendarCheckInOutResponse.checkedInShortActivity;
      if (checkedInShortActivity != null) {
        if (checkedInShortActivity.id == deleteActivityParameter.activityId) {
          throw MessageError(
            title: "Cannot Delete Activity",
            message: "This activity is still checked-in${checkedInShortActivity.name.isEmptyString ? " (${checkedInShortActivity.name})." : "."} Please check-out first.",
            data: checkedInShortActivity
          );
        }
      }
      return graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().mutationDeleteActivity(
            activityId: deleteActivityParameter.activityId
          ),
        )
      ).map<DeleteActivityResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToDeleteActivityResponse()
      );
    });
  }

  @override
  FutureProcessing<EditActivityResponse> editActivity(EditActivityParameter editActivityParameter) {
    return GraphQLFutureProcessing((_) async {
      return graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().mutationEditActivity(
            id: editActivityParameter.id,
            name: editActivityParameter.name,
            start: DateHelper.standardDateFormat.format(editActivityParameter.start),
            stop: DateHelper.standardDateFormat.format(editActivityParameter.stop),
            location: editActivityParameter.location,
            meetingUrl: editActivityParameter.meetingUrl,
            description: editActivityParameter.description
          ),
        )
      ).map<EditActivityResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToEditActivityResponse()
      );
    });
  }

  @override
  FutureProcessing<AddActivityPipelineResponse> addActivityPipeline(AddActivityPipelineParameter addActivityPipelineParameter) {
    return GraphQLFutureProcessing((_) async {
      Future<String> getActivityCreationLeadModelId() async {
        var activityCreationLeadModelId = await graphQL.mutate(
          GraphQLMutateParameter(
            queryString: GraphQLQueryConstants().mutationActivityCreationLeadModel
          )
        ).map<String>(
          onMap: (value) => value.graphQLWrapResponse().mapFromResponseToActivityCreationLeadModelId()
        );
        return activityCreationLeadModelId;
      }
      if (addActivityPipelineParameter is DynamicAddActivityPipelineParameter) {
        var activityCreationLeadModelId = await getActivityCreationLeadModelId();
        return graphQL.mutate(
          GraphQLMutateParameter(
            queryString: GraphQLQueryConstants().mutationAddDynamicActivityPipeline(
              pipelineId: addActivityPipelineParameter.pipelineId,
              activityCategoryId: addActivityPipelineParameter.activityCategoryId,
              name: addActivityPipelineParameter.name,
              description: addActivityPipelineParameter.description,
              activityCreationLeadModelId: activityCreationLeadModelId,
              dateDeadline: addActivityPipelineParameter.dateDeadline,
              userId: (LoginHelper.getLoginData()?.id).toEmptyStringNonNull
            ),
          )
        ).map<AddActivityPipelineResponse>(
          onMap: (value) => value.graphQLWrapResponse().mapFromResponseToAddActivityPipelineResponse()
        );
      } else if (addActivityPipelineParameter is MeetingAddActivityPipelineParameter) {
        var activityCreationLeadModelId = await getActivityCreationLeadModelId();
        var calendarEventId = await graphQL.mutate(
          GraphQLMutateParameter(
            queryString: GraphQLQueryConstants().mutationAddCalendarEventBeforeAddActivityPipeline(
              pipelineId: addActivityPipelineParameter.pipelineId,
              activityCategoryId: addActivityPipelineParameter.activityCategoryId,
              name: addActivityPipelineParameter.name,
              description: addActivityPipelineParameter.description,
              startDate: addActivityPipelineParameter.dateStart,
              endDate: addActivityPipelineParameter.dateEnd,
              activityCreationLeadModelId: activityCreationLeadModelId,
              userId: (LoginHelper.getLoginData()?.id).toEmptyStringNonNull,
              location: addActivityPipelineParameter.location,
              locationUrl: addActivityPipelineParameter.meetingUrl
            ),
          )
        ).map<String>(
          onMap: (value) => value.graphQLWrapResponse().mapFromResponseToAddCalendarEventCalendarEventId()
        );
        return graphQL.mutate(
          GraphQLMutateParameter(
            queryString: GraphQLQueryConstants().mutationAddMeetingActivityPipeline(
              pipelineId: addActivityPipelineParameter.pipelineId,
              activityCategoryId: addActivityPipelineParameter.activityCategoryId,
              name: addActivityPipelineParameter.name,
              description: addActivityPipelineParameter.description,
              activityCreationLeadModelId: activityCreationLeadModelId,
              userId: (LoginHelper.getLoginData()?.id).toEmptyStringNonNull,
              calendarEventId: calendarEventId
            ),
          )
        ).map<AddActivityPipelineResponse>(
          onMap: (value) => value.graphQLWrapResponse().mapFromResponseToAddActivityPipelineResponse()
        );
      } else {
        throw MessageError(
          title: "AddActivityPipelineParameter Not Suitable",
          message: "AddActivityPipelineParameter is not suitable"
        );
      }
    });
  }

  @override
  FutureProcessing<CheckInActivityCalendarResponse> checkInActivityCalendar(CheckInActivityCalendarParameter checkInActivityCalendarParameter) {
    return GraphQLFutureProcessing((parameter) async {
      var employeeBasedUserResponse = await userRemoteDataSource.employeeBasedUser(
        EmployeeBasedUserParameter(
          userId: (LoginHelper.getLoginData()?.id).toEmptyStringNonNull
        )
      ).future(
        parameter: parameter
      );
      String attendanceId = await graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().mutationCheckIn(
            checkInLatitude: checkInActivityCalendarParameter.checkInLatitude,
            checkInLongitude: checkInActivityCalendarParameter.checkInLongitude,
            checkInIpAddress: checkInActivityCalendarParameter.checkInIpAddress,
            employeeId: employeeBasedUserResponse.employee.id,
            imageUrl: checkInActivityCalendarParameter.imageUrl,
            checkInTime: checkInActivityCalendarParameter.checkInTime,
          ),
        )
      ).map<String>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToAttendanceId()
      );
      if (attendanceId.isNotEmptyString) {
        return graphQL.mutate(
          GraphQLMutateParameter(
            queryString: GraphQLQueryConstants().mutationStoreCheckInIdInCalendarActivity(
              activityId: checkInActivityCalendarParameter.activityId,
              attendanceId: attendanceId
            ),
          )
        ).map<CheckInActivityCalendarResponse>(
          onMap: (value) => value.graphQLWrapResponse().mapFromResponseToCheckInActivityCalendarResponse()
        );
      } else {
        throw MessageError(
          title: "Attendance Failed",
          message: "Attendance is failed"
        );
      }
    });
  }

  @override
  FutureProcessing<CheckOutActivityCalendarResponse> checkOutActivityCalendar(CheckOutActivityCalendarParameter checkOutActivityCalendarParameter) {
    return GraphQLFutureProcessing((parameter) async {
      var employeeBasedUserResponse = await userRemoteDataSource.employeeBasedUser(
        EmployeeBasedUserParameter(
          userId: (LoginHelper.getLoginData()?.id).toEmptyStringNonNull
        )
      ).future(
        parameter: parameter
      );
      var checkOutActivityCalendarResponse = await graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().mutationCheckOut(
            attendanceId: checkOutActivityCalendarParameter.attendanceId,
            checkOutLatitude: checkOutActivityCalendarParameter.checkOutLatitude,
            checkOutLongitude: checkOutActivityCalendarParameter.checkOutLongitude,
            checkOutIpAddress: checkOutActivityCalendarParameter.checkOutIpAddress,
            employeeId: employeeBasedUserResponse.employee.id,
            imageUrl: checkOutActivityCalendarParameter.imageUrl,
            checkOutTime: checkOutActivityCalendarParameter.checkOutTime,
          ),
        )
      ).map<CheckOutActivityCalendarResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToCheckOutActivityCalendarResponse()
      );
      await graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().mutationUpdateActivityCheckInOutState(
            attendanceId: checkOutActivityCalendarParameter.attendanceId
          ),
        )
      ).map<bool>(
        onMap: (value) => true
      );
      return checkOutActivityCalendarResponse;
    });
  }

  @override
  FutureProcessing<CheckInActivityPipelineResponse> checkInActivityPipeline(CheckInActivityPipelineParameter checkInActivityPipelineParameter) {
    return GraphQLFutureProcessing((parameter) async {
      var employeeBasedUserResponse = await userRemoteDataSource.employeeBasedUser(
        EmployeeBasedUserParameter(
          userId: (LoginHelper.getLoginData()?.id).toEmptyStringNonNull
        )
      ).future(
        parameter: parameter
      );
      return graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().mutationCheckIn(
            checkInLatitude: checkInActivityPipelineParameter.checkInLatitude,
            checkInLongitude: checkInActivityPipelineParameter.checkInLongitude,
            checkInIpAddress: checkInActivityPipelineParameter.checkInIpAddress,
            employeeId: employeeBasedUserResponse.employee.id,
            imageUrl: checkInActivityPipelineParameter.imageUrl,
            checkInTime: checkInActivityPipelineParameter.checkInTime,
          ),
        )
      ).map<CheckInActivityPipelineResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToCheckInActivityPipelineResponse()
      );
    });
  }

  @override
  FutureProcessing<CheckOutActivityPipelineResponse> checkOutActivityPipeline(CheckOutActivityPipelineParameter checkOutActivityPipelineParameter) {
    return GraphQLFutureProcessing((parameter) async {
      var employeeBasedUserResponse = await userRemoteDataSource.employeeBasedUser(
        EmployeeBasedUserParameter(
          userId: (LoginHelper.getLoginData()?.id).toEmptyStringNonNull
        )
      ).future(
        parameter: parameter
      );
      return graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().mutationCheckOut(
            attendanceId: checkOutActivityPipelineParameter.attendanceId,
            checkOutLatitude: checkOutActivityPipelineParameter.checkOutLatitude,
            checkOutLongitude: checkOutActivityPipelineParameter.checkOutLongitude,
            checkOutIpAddress: checkOutActivityPipelineParameter.checkOutIpAddress,
            employeeId: employeeBasedUserResponse.employee.id,
            imageUrl: checkOutActivityPipelineParameter.imageUrl,
            checkOutTime: checkOutActivityPipelineParameter.checkOutTime,
          ),
        )
      ).map<CheckOutActivityPipelineResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToCheckOutActivityPipelineResponse()
      );
    });
  }

  @override
  FutureProcessing<DoneActivityPipelineResponse> doneActivityPipeline(DoneActivityPipelineParameter doneActivityPipelineParameter) {
    return GraphQLFutureProcessing((parameter) async {
      return graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().mutationDoneActivityPipelineWithFeedback(
            activityPipelineId: doneActivityPipelineParameter.activityPipelineId,
            feedback: doneActivityPipelineParameter.feedback
          ),
        )
      ).map<DoneActivityPipelineResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToDoneActivityPipelineResponse()
      );
    });
  }

  @override
  FutureProcessing<UndoneActivityPipelineResponse> undoneActivityPipeline(UndoneActivityPipelineParameter undoneActivityPipelineParameter) {
    return GraphQLFutureProcessing((parameter) async {
      return graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().mutationUndoneActivityPipeline(
            undoneActivityPipelineParameter.activityPipelineId
          ),
        )
      ).map<UndoneActivityPipelineResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToUndoneActivityPipelineResponse()
      );
    });
  }

  @override
  FutureProcessing<ActivityPipelineScheduleResponse> activityPipelineSchedule(ActivityPipelineScheduleParameter activityPipelineScheduleParameter) {
    return GraphQLFutureProcessing((parameter) async {
      String activityPipelineId = "";
      String feedback = "";
      var pipelineId = "";
      Future<void> getPipelineId() async {
        pipelineId = await graphQL.mutate(
          GraphQLMutateParameter(
            queryString: GraphQLQueryConstants().queryGettingPipelineIdBasedActivityPipelineId(
              activityPipelineId: activityPipelineId,
            ),
          )
        ).map<String>(
          onMap: (value) => value.graphQLWrapResponse().mapFromResponseGettingPipelineIdBasedActivityPipelineId()
        );
      }
      late AddActivityPipelineParameter addActivityPipelineParameter;
      if (activityPipelineScheduleParameter is DynamicActivityPipelineScheduleParameter) {
        activityPipelineId = activityPipelineScheduleParameter.activityPipelineId;
        feedback = activityPipelineScheduleParameter.feedback;
        await getPipelineId();
        addActivityPipelineParameter = DynamicAddActivityPipelineParameter(
          pipelineId: pipelineId,
          activityCategoryId: activityPipelineScheduleParameter.activityCategoryId,
          name: activityPipelineScheduleParameter.name,
          description: activityPipelineScheduleParameter.description,
          dateDeadline: activityPipelineScheduleParameter.dateDeadline
        );
      } else if (activityPipelineScheduleParameter is MeetingActivityPipelineScheduleParameter) {
        activityPipelineId = activityPipelineScheduleParameter.activityPipelineId;
        feedback = activityPipelineScheduleParameter.feedback;
        await getPipelineId();
        addActivityPipelineParameter = MeetingAddActivityPipelineParameter(
          pipelineId: pipelineId,
          activityCategoryId: activityPipelineScheduleParameter.activityCategoryId,
          name: activityPipelineScheduleParameter.name,
          description: activityPipelineScheduleParameter.description,
          dateStart: activityPipelineScheduleParameter.dateStart,
          dateEnd: activityPipelineScheduleParameter.dateEnd,
          location: activityPipelineScheduleParameter.location,
          meetingUrl: activityPipelineScheduleParameter.meetingUrl
        );
      }
      await doneActivityPipeline(
        DoneActivityPipelineParameter(
          activityPipelineId: activityPipelineId,
          feedback: feedback
        )
      ).future(
        parameter: parameter
      );
      await addActivityPipeline(
        addActivityPipelineParameter
      ).future(
        parameter: parameter
      );
      return ActivityPipelineScheduleResponse();
    });
  }

  @override
  FutureProcessing<RecommendationActivityPipelineTypeResponse> recommendationActivityPipelineType(RecommendationActivityPipelineTypeParameter recommendationActivityPipelineTypeParameter) {
    return GraphQLFutureProcessing((parameter) async {
      return graphQL.mutate(
        GraphQLMutateParameter(
          queryString: GraphQLQueryConstants().queryRecommendationActivityPipelineTypeList(
            lastActivityPipelineTypeId: recommendationActivityPipelineTypeParameter.lastActivityPipelineTypeId
          ),
        )
      ).map<RecommendationActivityPipelineTypeResponse>(
        onMap: (value) => value.graphQLWrapResponse().mapFromResponseToRecommendationActivityPipelineTypeResponse()
      );
    });
  }
}