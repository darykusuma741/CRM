import 'package:crm/common/ext/response_wrapper_ext.dart';
import 'package:crm/common/ext/string_ext.dart';
import 'package:crm/data/mapping/paging_mapping_ext.dart';

import '../../common/error/message_error.dart';
import '../../common/helper/date_helper.dart';
import '../../common/helper/string_helper.dart';
import '../../common/responsewrapper/response_wrapper.dart';
import '../models/activity.dart';
import '../models/activity_attendance.dart';
import '../models/activity_pipeline_category.dart';
import '../models/activitycalendar/activity_calendar_paging_data_response.dart';
import '../models/activitydetail/activity_detail_response.dart';
import '../models/activitypipelinecategory/activity_pipeline_category_response.dart';
import '../models/activitypipelinepagingdata/activity_pipeline_paging_data_response.dart';
import '../models/addactivity/add_activity_response.dart';
import '../models/addactivitypipeline/add_activity_pipeline_response.dart';
import '../models/checkinactivitycalendar/check_in_activity_calendar_response.dart';
import '../models/checkinactivitypipeline/check_in_activity_pipeline_response.dart';
import '../models/checkoutactivitycalendar/check_out_activity_calendar_response.dart';
import '../models/checkoutactivitypipeline/check_out_activity_pipeline_response.dart';
import '../models/deleteactivity/delete_activity_response.dart';
import '../models/doneactivitypipeline/done_activity_pipeline_response.dart';
import '../models/editactivity/edit_activity_response.dart';
import '../models/historyactivity/history_activity_parameter.dart';
import '../models/historyactivity/history_activity_response.dart';
import '../models/historyactivity/short_history_activity.dart';
import '../models/historypipelineactivity/history_pipeline_activity_response.dart';
import '../models/historypipelineactivity/short_history_pipeline_activity.dart';
import '../models/lead_category.dart';
import '../models/leadscategory/leads_category_response.dart';
import '../models/recommendationactivitypipelinetype/recommendation_activity_pipeline_type_response.dart';
import '../models/short_activity.dart';
import '../models/undoneactivitypipeline/undone_activity_pipeline_response.dart';

extension ActivityEntityMappingExt on ResponseWrapper {
  HistoryActivityResponse mapFromResponseToHistoryActivityResponse({
    required HistoryActivityParameterType type,
    required List<ActivityPipelineCategory> activityPipelineCategoryList,
    required List<ShortActivity> shortActivityList
  }) {
    ResponseWrapper resultResponseWrapper = ResponseWrapper(response).mapFromResponseToDataResponseWrapper(
      dataFieldName: () {
        if (type == HistoryActivityParameterType.pipeline) {
          return "result";
        } else if (type == HistoryActivityParameterType.calendar) {
          return "CalendarEvent";
        }
        return null;
      }()
    );
    var shortHistoryActivityList = resultResponseWrapper.mapFromResponseToList<ShortHistoryActivity>(
      (responseData) {
        if (type == HistoryActivityParameterType.pipeline) {
          return ResponseWrapper(responseData).mapFromResponseToShortHistoryActivityForPipeline(
            activityPipelineCategoryList,
            shortActivityList
          );
        } else if (type == HistoryActivityParameterType.calendar) {
          return ResponseWrapper(responseData).mapFromResponseToShortHistoryActivityForCalendar();
        }
        throw MessageError(
          title: "History Activity Parameter Not Found",
          message: "History Activity Parameter is not found",
        );
      }
    ).toList();
    if (type == HistoryActivityParameterType.calendar) {
      shortHistoryActivityList = shortHistoryActivityList.where(
        (shortHistoryActivity) {
          return shortHistoryActivity.resId == "0";
        }
      ).toList();
    }
    if (shortHistoryActivityList.isEmpty) {
      throw MessageError(
        title: "History Activity Not Found",
        message: "History pipeline activity is not found"
      );
    }
    return HistoryActivityResponse(
      shortHistoryActivityList: shortHistoryActivityList
    );
  }

  ShortHistoryActivity mapFromResponseToShortHistoryActivityForCalendar() {
    var attendanceIdResponseWrapper = ResponseWrapper(response).mapFromResponseToDataResponseWrapper(dataFieldName: "attendance_id");
    return ShortHistoryActivity(
      id: ResponseWrapper(response["id"]).mapFromResponseToNonNullableString(),
      resId: ResponseWrapper(response["res_id"]).mapFromResponseToNonNullableString(),
      name: ResponseWrapper(response["name"]).mapFromResponseToNonNullableString(),
      type: "Meeting General",
      typeId: "",
      category: "meeting",
      startDateTime: ResponseWrapper(response["start"]).mapFromResponseToDateTime(
        dateFormat: DateHelper.standardDateFormat,
        convertIntoLocalTime: false
      ),
      stopDateTime: ResponseWrapper(response["stop"]).mapFromResponseToDateTime(
        dateFormat: DateHelper.standardDateFormat,
        convertIntoLocalTime: false
      ),
      description: StringHelper().sanitizeHtml(
        ResponseWrapper(response["summary"]).mapFromResponseToNonNullableString()
      ),
      checkInDateTime: attendanceIdResponseWrapper.mapFromResponseToDataResponseWrapper(dataFieldName: "check_in").mapFromResponseToDateTime(
        dateFormat: DateHelper.standardDateFormat,
        convertIntoLocalTime: false
      ),
      checkInLatitude: attendanceIdResponseWrapper.mapFromResponseToDataResponseWrapper(dataFieldName: "check_in_latitude").mapFromResponseToDouble(),
      checkInLongitude: attendanceIdResponseWrapper.mapFromResponseToDataResponseWrapper(dataFieldName: "check_in_longitude").mapFromResponseToDouble(),
      checkInPhotoUrl: attendanceIdResponseWrapper.mapFromResponseToDataResponseWrapper(dataFieldName: "check_in_photo_url").mapFromResponseToNonNullableString(),
      checkOutDateTime: attendanceIdResponseWrapper.mapFromResponseToDataResponseWrapper(dataFieldName: "check_out").mapFromResponseToDateTime(
        dateFormat: DateHelper.standardDateFormat,
        convertIntoLocalTime: false
      ),
      checkOutLatitude: attendanceIdResponseWrapper.mapFromResponseToDataResponseWrapper(dataFieldName: "check_out_latitude").mapFromResponseToDouble(),
      checkOutLongitude: attendanceIdResponseWrapper.mapFromResponseToDataResponseWrapper(dataFieldName: "check_out_longitude").mapFromResponseToDouble(),
      checkOutPhotoUrl: attendanceIdResponseWrapper.mapFromResponseToDataResponseWrapper(dataFieldName: "check_out_photo_url").mapFromResponseToNonNullableString(),
      createDate: ResponseWrapper(response["create_date"]).mapFromResponseToDateTime(
        dateFormat: DateHelper.standardDateFormat,
        convertIntoLocalTime: false
      )
    );
  }

  ShortHistoryActivity mapFromResponseToShortHistoryActivityForPipeline(
    List<ActivityPipelineCategory> activityPipelineCategoryList,
    List<ShortActivity> shortActivityList
  ) {
    var activityTypeId = ResponseWrapper(response["activity_type_id"]);
    var type = activityTypeId.getArrayData(1).mapFromResponseToNonNullableString();
    var typeId = activityTypeId.getArrayData(0).mapFromResponseToNonNullableString();
    var category = () {
      return activityPipelineCategoryList.where(
        (activityCategory) => activityCategory.id == typeId
      ).firstOrNull?.category;
    }().toEmptyStringNonNull;
    var calendarEventId = ResponseWrapper(response["calendar_event_id"]).getArrayData(0).mapFromResponseToNonNullableString();
    var activityAttendance = () {
      var activityAttendance = ResponseWrapper(response["attendance_id"]).mapFromResponseToActivityAttendance();
      if (activityAttendance != null) {
        return activityAttendance;
      }
      if (shortActivityList.isNotEmpty) {
        var effectiveActivityAttendance = shortActivityList.where(
          (value) => value.id == calendarEventId
        ).firstOrNull?.activityAttendance;
        return effectiveActivityAttendance;
      };
      return null;
    }();
    return ShortHistoryActivity(
      id: ResponseWrapper(response["id"]).mapFromResponseToNonNullableString(),
      resId: ResponseWrapper(response["res_id"]).mapFromResponseToNonNullableString(),
      name: () {
        var activityTypeName = ResponseWrapper(response)
          .mapFromResponseToDataResponseWrapper(dataFieldName: "summary")
          .mapFromResponseToNonNullableString();
        if (activityTypeName.isNotEmptyString) {
          return activityTypeName;
        }
        return ResponseWrapper(response["name"]).mapFromResponseToNonNullableString();
      }(),
      type: type,
      typeId: typeId,
      category: category,
      startDateTime: ResponseWrapper(response["start"]).mapFromResponseToDateTime(
        dateFormat: DateHelper.standardDateFormat,
        convertIntoLocalTime: false
      ) ?? ResponseWrapper(response["date_deadline"]).mapFromResponseToDateTime(
        dateFormat: DateHelper.standardDateFormat3,
        convertIntoLocalTime: false
      ),
      stopDateTime: ResponseWrapper(response["stop"]).mapFromResponseToDateTime(
        dateFormat: DateHelper.standardDateFormat,
        convertIntoLocalTime: false
      ),
      description: StringHelper().sanitizeHtml(
        ResponseWrapper(response["description"]).mapFromResponseToNonNullableString()
      ),
      checkInDateTime: activityAttendance?.checkInDateTime,
      checkInLatitude: activityAttendance?.checkInLatitude,
      checkInLongitude: activityAttendance?.checkInLongitude,
      checkInPhotoUrl: (activityAttendance?.checkInPhotoUrl).toEmptyStringNonNull,
      checkOutDateTime: activityAttendance?.checkOutDateTime,
      checkOutLatitude: activityAttendance?.checkOutLatitude,
      checkOutLongitude: activityAttendance?.checkOutLongitude,
      checkOutPhotoUrl: (activityAttendance?.checkOutPhotoUrl).toEmptyStringNonNull,
      createDate: ResponseWrapper(response["create_date"]).mapFromResponseToDateTime(
        dateFormat: DateHelper.standardDateFormat,
        convertIntoLocalTime: false
      )
    );
  }

  HistoryPipelineActivityResponse mapFromResponseToHistoryPipelineActivityResponse({
    required List<ActivityPipelineCategory> activityCategoryList,
    required List<ShortActivity> shortActivityList
  }) {
    ResponseWrapper resultResponseWrapper = ResponseWrapper(response).mapFromResponseToDataResponseWrapper(dataFieldName: "result");
    var shortHistoryPipelineActivityList = resultResponseWrapper.mapFromResponseToList(
      (value) => ResponseWrapper(value).mapFromResponseToShortHistoryPipelineActivity(
        activityCategoryList: activityCategoryList,
        shortActivityList: shortActivityList
      )
    ).toList();
    if (shortHistoryPipelineActivityList.isEmpty) {
      throw MessageError(
        title: "History Pipeline Activity Not Found",
        message: "History pipeline activity is not found"
      );
    }
    return HistoryPipelineActivityResponse(
      shortHistoryPipelineActivityList: shortHistoryPipelineActivityList
    );
  }

  ShortHistoryPipelineActivity mapFromResponseToShortHistoryPipelineActivity({
    required List<ActivityPipelineCategory> activityCategoryList,
    required List<ShortActivity> shortActivityList
  }) {
    var activityTypeId = ResponseWrapper(response["activity_type_id"]);
    var typeId = activityTypeId.getArrayData(0).mapFromResponseToNonNullableString();
    var category = () {
      return activityCategoryList.where(
        (activityCategory) => activityCategory.id == typeId
      ).firstOrNull?.category;
    }().toEmptyStringNonNull;
    var calendarEventId = ResponseWrapper(response["calendar_event_id"]).getArrayData(0).mapFromResponseToNonNullableString();
    var activityAttendance = () {
      var activityAttendance = ResponseWrapper(response["attendance_id"]).mapFromResponseToActivityAttendance();
      if (activityAttendance != null) {
        return activityAttendance;
      }
      if (shortActivityList.isNotEmpty) {
        var effectiveActivityAttendance = shortActivityList.where(
          (value) => value.id == calendarEventId
        ).firstOrNull?.activityAttendance;
        return effectiveActivityAttendance;
      };
      return null;
    }();
    return ShortHistoryPipelineActivity(
      id: ResponseWrapper(response["id"]).mapFromResponseToNonNullableString(),
      resId: ResponseWrapper(response["res_id"]).mapFromResponseToNonNullableString(),
      name: () {
        var activityTypeName = ResponseWrapper(response)
          .mapFromResponseToDataResponseWrapper(dataFieldName: "summary")
          .mapFromResponseToNonNullableString();
        if (activityTypeName.isNotEmptyString) {
          return activityTypeName;
        }
        return ResponseWrapper(response["name"]).mapFromResponseToNonNullableString();
      }(),
      category: category,
      typeId: typeId,
      type: activityTypeId.getArrayData(1).mapFromResponseToNonNullableString(),
      description: StringHelper().sanitizeHtml(
        ResponseWrapper(response["summary"]).mapFromResponseToNonNullableString()
      ),
      date: ResponseWrapper(response["date_deadline"]).mapFromResponseToDateTime(dateFormat: DateHelper.standardDateFormat3, convertIntoLocalTime: false),
      imageUrl: ResponseWrapper(response["image_url"]).mapFromResponseToNonNullableString(),
      timeFrom: ResponseWrapper(response["time_from"]).mapFromResponseToDateTime(dateFormat: DateHelper.standardDateFormat3, convertIntoLocalTime: false),
      timeTo: ResponseWrapper(response["time_to"]).mapFromResponseToDateTime(dateFormat: DateHelper.standardDateFormat3, convertIntoLocalTime: false),
      checkInDateTime: activityAttendance?.checkInDateTime,
      checkInLatitude: activityAttendance?.checkInLatitude,
      checkInLongitude: activityAttendance?.checkInLongitude,
      checkInPhotoUrl: (activityAttendance?.checkInPhotoUrl).toEmptyStringNonNull,
      checkOutDateTime: activityAttendance?.checkOutDateTime,
      checkOutLatitude: activityAttendance?.checkOutLatitude,
      checkOutLongitude: activityAttendance?.checkOutLongitude,
      checkOutPhotoUrl: (activityAttendance?.checkOutPhotoUrl).toEmptyStringNonNull,
      createDate: ResponseWrapper(response["create_date"]).mapFromResponseToDateTime(
        dateFormat: DateHelper.standardDateFormat,
        convertIntoLocalTime: false
      )
    );
  }

  ActivityCalendarPagingDataResponse mapFromResponseToActivityCalendarPagingDataResponse({
    required List<ActivityPipelineCategory> activityCategoryList,
    required bool isMeetingGeneral
  }) {
    return ActivityCalendarPagingDataResponse(
      activityPagingData: ResponseWrapper(response).mapFromResponseToPagingData(
        (dataResponse) => ResponseWrapper(dataResponse).mapFromResponseToList(
          (value) => ResponseWrapper(value).mapFromResponseToShortActivity(
            activityCategoryList: activityCategoryList,
            isMeetingGeneral: isMeetingGeneral
          )
        ),
        dataFieldName: "CalendarEvent"
      )
    );
  }

  ActivityPipelineCategoryResponse mapFromResponseToActivityPipelineCategoryResponse() {
    return ActivityPipelineCategoryResponse(
      activityPipelineCategoryList: () {
        var activityPipelineCategoryList = ResponseWrapper(response["result"]).mapFromResponseToList(
          (activityPipelineCategoryResponse) {
            return ResponseWrapper(activityPipelineCategoryResponse).mapFromResponseToActivityPipelineCategory();
          }
        );
        return <ActivityPipelineCategory>[
          ActivityPipelineCategory(
            id: "-1",
            category: "",
            action: "",
            name: "All",
            count: 0
          ),
          ...activityPipelineCategoryList,
        ];
      }()
    );
  }

  ActivityPipelinePagingDataResponse mapFromResponseToActivityPipelinePagingDataResponse({
    required List<ActivityPipelineCategory> activityCategoryList,
    required List<ShortActivity> shortActivityList,
    required bool isMeetingGeneral
  }) {
    return ActivityPipelinePagingDataResponse(
      activityPagingData: ResponseWrapper(response).mapFromResponseToPagingData(
        (dataResponse) => ResponseWrapper(dataResponse).mapFromResponseToList(
          (value) => ResponseWrapper(value).mapFromResponseToShortActivity(
            activityCategoryList: activityCategoryList,
            isMeetingGeneral: isMeetingGeneral,
            shortActivityList: shortActivityList
          )
        ).toList(),
        dataFieldName: "result"
      )
    );
  }

  ActivityPipelineCategory mapFromResponseToActivityPipelineCategory() {
    return ActivityPipelineCategory(
      id: ResponseWrapper(response["id"]).mapFromResponseToNonNullableString(),
      action: "",
      name: ResponseWrapper(response["name"]).mapFromResponseToNonNullableString(),
      category: ResponseWrapper(response["category"]).mapFromResponseToNonNullableString(),
      count: 0
    );
  }

  ShortActivity mapFromResponseToShortActivity({
    required List<ActivityPipelineCategory> activityCategoryList,
    List<ShortActivity> shortActivityList = const <ShortActivity>[],
    required bool isMeetingGeneral
  }) {
    var activityTypeId = "";
    var activityTypeName = "";
    if (isMeetingGeneral) {
      activityTypeId = "";
      activityTypeName = "Meeting General";
    } else {
      var activityType = ResponseWrapper(response).mapFromResponseToDataResponseWrapper(dataFieldName: "activity_type_id");
      activityTypeId = activityType.getArrayData(0).mapFromResponseToNonNullableString();
      activityTypeName = activityType.getArrayData(1).mapFromResponseToNonNullableString();
    }
    var category = () {
      if (isMeetingGeneral) {
        return "meeting";
      }
      return activityCategoryList.where(
        (activityCategory) => activityCategory.id == activityTypeId
      ).firstOrNull?.category;
    }().toEmptyStringNonNull;
    var calendarEventId = ResponseWrapper(response["calendar_event_id"]).getArrayData(0).mapFromResponseToNonNullableString();
    var activityAttendance = () {
      var activityAttendance = ResponseWrapper(response["attendance_id"]).mapFromResponseToActivityAttendance();
      if (activityAttendance != null) {
        return activityAttendance;
      }
      if (shortActivityList.isNotEmpty) {
        var effectiveActivityAttendance = shortActivityList.where(
          (value) => value.id == calendarEventId
        ).firstOrNull?.activityAttendance;
        return effectiveActivityAttendance;
      };
      return null;
    }();
    return ShortActivity(
      id: ResponseWrapper(response["id"]).mapFromResponseToNonNullableString(),
      name: () {
        var activityTypeName = ResponseWrapper(response)
          .mapFromResponseToDataResponseWrapper(dataFieldName: "summary")
          .mapFromResponseToNonNullableString();
        if (activityTypeName.isNotEmptyString) {
          return activityTypeName;
        }
        return ResponseWrapper(response["name"]).mapFromResponseToNonNullableString();
      }(),
      resId: ResponseWrapper(response["res_id"]).mapFromResponseToNonNullableString(),
      type: activityTypeName,
      typeId: activityTypeId,
      category: category,
      description: StringHelper().sanitizeHtml(
        ResponseWrapper(response["description"]).mapFromResponseToNonNullableString()
      ),
      status: () {
        if (category == "meeting") {
          ActivityAttendance? effectiveActivityAttendance;
          if (shortActivityList.isNotEmpty) {
            effectiveActivityAttendance = shortActivityList.where(
              (value) => value.id == calendarEventId
            ).firstOrNull?.activityAttendance;
          } else {
            effectiveActivityAttendance = activityAttendance;
          }
          var activityState = (effectiveActivityAttendance?.activityState).toEmptyStringNonNull;
          if (activityState.isEmptyString) {
            return "Check-in";
          } else {
            var lowercaseActivityState = activityState.toEmptyStringNonNull.toLowerCase();
            if (lowercaseActivityState == "check_in") {
              return "Check-out";
            } else if (lowercaseActivityState == "check_out") {
              return "Check-in";
            }
          }
        }
        return "";
      }(),
      action: ResponseWrapper(response["action"]).mapFromResponseToNonNullableString(),
      startDate: () {
        if (category == "meeting") {
          if (shortActivityList.isNotEmpty) {
            var activityMeeting = shortActivityList.where(
              (value) => value.id == calendarEventId
            ).firstOrNull;
            if (activityMeeting != null) {
              return activityMeeting.startDate;
            }
          }
        }
        if (response["start"] != null) {
          return ResponseWrapper(response["start"]).mapFromResponseToDateTime(
            dateFormat: DateHelper.standardDateFormat,
            convertIntoLocalTime: false
          );
        } else if (response["date_deadline"] != null) {
          return ResponseWrapper(response["date_deadline"]).mapFromResponseToDateTime(
            dateFormat: DateHelper.standardDateFormat3,
            convertIntoLocalTime: false
          );
        }
        return null;
      }(),
      stopDate: () {
        if (category == "meeting") {
          if (shortActivityList.isNotEmpty) {
            var activityMeeting = shortActivityList.where(
              (value) => value.id == calendarEventId
            ).firstOrNull;
            if (activityMeeting != null) {
              return activityMeeting.stopDate;
            }
          }
        }
        return ResponseWrapper(response["stop"]).mapFromResponseToDateTime(
          dateFormat: DateHelper.standardDateFormat,
          convertIntoLocalTime: false
        );
      }(),
      createDate: ResponseWrapper(response["create_date"]).mapFromResponseToDateTime(
        dateFormat: DateHelper.standardDateFormat,
        convertIntoLocalTime: false
      ),
      location: ResponseWrapper(response["location"]).mapFromResponseToNonNullableString(),
      meetingUrl: ResponseWrapper(response["videocall_location"]).mapFromResponseToNonNullableString(),
      activityAttendance: activityAttendance,
      calendarEventId: calendarEventId
    );
  }

  ActivityAttendance? mapFromResponseToActivityAttendance() {
    if (response == null) {
      return null;
    }
    return ActivityAttendance(
      id: ResponseWrapper(response["id"]).mapFromResponseToNonNullableString(),
      activityState: ResponseWrapper(response["activity_state"]).mapFromResponseToNonNullableString(),
      checkInDateTime: ResponseWrapper(response["check_in"]).mapFromResponseToDateTime(
        dateFormat: DateHelper.standardDateFormat,
        convertIntoLocalTime: false
      ),
      checkInLatitude: ResponseWrapper(response["check_in_latitude"]).mapFromResponseToDouble(),
      checkInLongitude: ResponseWrapper(response["check_in_longitude"]).mapFromResponseToDouble(),
      checkInPhotoUrl: ResponseWrapper(response["check_in_photo_url"]).mapFromResponseToNonNullableString(),
      checkOutDateTime: ResponseWrapper(response["check_out"]).mapFromResponseToDateTime(
        dateFormat: DateHelper.standardDateFormat,
        convertIntoLocalTime: false
      ),
      checkOutLatitude: ResponseWrapper(response["check_out_latitude"]).mapFromResponseToDouble(),
      checkOutLongitude: ResponseWrapper(response["check_out_longitude"]).mapFromResponseToDouble(),
      checkOutPhotoUrl: ResponseWrapper(response["check_out_photo_url"]).mapFromResponseToNonNullableString(),
    );
  }

  ActivityDetailResponse mapFromResponseToActivityDetailResponse({
    required List<ActivityPipelineCategory> activityCategoryList,
    required bool isMeetingGeneral
  }) {
    var calendarEventResponseWrapper = ResponseWrapper(response).mapFromResponseToDataResponseWrapper(
      dataFieldName: "CalendarEvent"
    );
    var responseList = calendarEventResponseWrapper.mapFromResponseToList(
      (responseData) => responseData
    );
    if (responseList.isEmpty) {
      throw MessageError(
        title: "Activity Not Found",
        message: "Activity is not found"
      );
    }
    return ActivityDetailResponse(
      activity: ResponseWrapper(responseList.first).mapFromResponseToShortActivity(
        activityCategoryList: activityCategoryList,
        isMeetingGeneral: isMeetingGeneral
      )
    );
  }

  AddActivityResponse mapFromResponseToAddActivityResponse() {
    return AddActivityResponse();
  }

  EditActivityResponse mapFromResponseToEditActivityResponse() {
    return EditActivityResponse();
  }

  DeleteActivityResponse mapFromResponseToDeleteActivityResponse() {
    return DeleteActivityResponse();
  }

  AddActivityPipelineResponse mapFromResponseToAddActivityPipelineResponse() {
    return AddActivityPipelineResponse();
  }

  String mapFromResponseToActivityCreationLeadModelId() {
    var activityPipelineCategoryList = ResponseWrapper(response["result"]).mapFromResponseToList(
      (activityPipelineCategoryResponse) {
        return ResponseWrapper(activityPipelineCategoryResponse["id"]).mapFromResponseToNonNullableString();
      }
    );
    if (activityPipelineCategoryList.isEmpty) {
      throw MessageError(
        title: "Activity Creation Lead Model Not Found",
        message: "Activity creation lead model is not found"
      );
    }
    return activityPipelineCategoryList.first;
  }

  String mapFromResponseToAttendanceId() {
    var activityPipelineCategoryList = ResponseWrapper(response["createHrAttendance"]).mapFromResponseToList(
      (activityPipelineCategoryResponse) {
        return ResponseWrapper(activityPipelineCategoryResponse["id"]).mapFromResponseToNonNullableString();
      }
    );
    if (activityPipelineCategoryList.isEmpty) {
      throw MessageError(
        title: "Activity Attendance Id Not Found",
        message: "Activity attendance id is not found"
      );
    }
    return activityPipelineCategoryList.first;
  }

  String mapFromResponseToAddCalendarEventCalendarEventId() {
    var activityPipelineCategoryList = ResponseWrapper(response["createCalendarEvent"]).mapFromResponseToList(
      (activityPipelineCategoryResponse) {
        return ResponseWrapper(activityPipelineCategoryResponse["id"]).mapFromResponseToNonNullableString();
      }
    );
    if (activityPipelineCategoryList.isEmpty) {
      throw MessageError(
        title: "Calendar Event Id Not Found",
        message: "Calendar Event id is not found"
      );
    }
    return activityPipelineCategoryList.first;
  }

  CheckInActivityCalendarResponse mapFromResponseToCheckInActivityCalendarResponse() {
    return CheckInActivityCalendarResponse();
  }

  CheckOutActivityCalendarResponse mapFromResponseToCheckOutActivityCalendarResponse() {
    return CheckOutActivityCalendarResponse();
  }

  CheckInActivityPipelineResponse mapFromResponseToCheckInActivityPipelineResponse() {
    return CheckInActivityPipelineResponse();
  }

  CheckOutActivityPipelineResponse mapFromResponseToCheckOutActivityPipelineResponse() {
    return CheckOutActivityPipelineResponse();
  }

  DoneActivityPipelineResponse mapFromResponseToDoneActivityPipelineResponse() {
    return DoneActivityPipelineResponse();
  }

  UndoneActivityPipelineResponse mapFromResponseToUndoneActivityPipelineResponse() {
    return UndoneActivityPipelineResponse();
  }

  String mapFromResponseGettingPipelineIdBasedActivityPipelineId() {
    var activityPipelineIdList = ResponseWrapper(response["MailActivity"]).mapFromResponseToList(
      (activityPipelineCategoryResponse) {
        return ResponseWrapper(activityPipelineCategoryResponse["res_id"]).mapFromResponseToNonNullableString();
      }
    );
    if (activityPipelineIdList.isEmpty) {
      throw MessageError(
        title: "Activity Pipeline Not Found",
        message: "Activity pipeline is not found"
      );
    }
    return activityPipelineIdList.first;
  }

  RecommendationActivityPipelineTypeResponse mapFromResponseToRecommendationActivityPipelineTypeResponse() {
    List<ActivityPipelineCategory> activityTypeList = [];
    var mailActivityTypeCalendarEventResponseWrapper = ResponseWrapper(response).mapFromResponseToDataResponseWrapper(
      dataFieldName: "MailActivityType"
    );
    var mailActivityTypeResponseList = mailActivityTypeCalendarEventResponseWrapper.mapFromResponseToList((value) {
      return value;
    });
    if (mailActivityTypeResponseList.isNotEmpty) {
      var firstMailActivityTypeResponse = mailActivityTypeResponseList.first;
      var suggestedNextTypeResponseWrapper = ResponseWrapper(firstMailActivityTypeResponse).mapFromResponseToDataResponseWrapper(
        dataFieldName: "suggested_next_type_ids"
      );
      activityTypeList = suggestedNextTypeResponseWrapper.mapFromResponseToList<ActivityPipelineCategory>(
        (value) => ResponseWrapper(value).mapFromResponseToActivityPipelineCategory()
      );
    }
    return RecommendationActivityPipelineTypeResponse(
      activityTypeList: activityTypeList
    );
  }
}

extension ShortHistoryPipelineActivityExt on ShortHistoryPipelineActivity {
  ShortHistoryActivity toShortHistoryActivity() {
    return ShortHistoryActivity(
      id: id,
      resId: resId,
      name: name,
      description: description,
      type: type,
      typeId: typeId,
      category: category,
      startDateTime: timeFrom,
      stopDateTime: timeTo,
      checkInDateTime: checkInDateTime,
      checkInLatitude: checkInLatitude,
      checkInLongitude: checkInLongitude,
      checkInPhotoUrl: checkInPhotoUrl,
      checkOutDateTime: checkOutDateTime,
      checkOutLatitude: checkOutLatitude,
      checkOutLongitude: checkOutLongitude,
      checkOutPhotoUrl: checkOutPhotoUrl,
      createDate: createDate
    );
  }
}