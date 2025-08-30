abstract class ActivityPipelineScheduleParameter {}

class DynamicActivityPipelineScheduleParameter extends ActivityPipelineScheduleParameter {
  String activityPipelineId;
  String activityCategoryId;
  String feedback;
  String name;
  String description;
  DateTime dateDeadline;

  DynamicActivityPipelineScheduleParameter({
    required this.activityPipelineId,
    required this.activityCategoryId,
    required this.feedback,
    required this.name,
    required this.description,
    required this.dateDeadline,
  });
}

class MeetingActivityPipelineScheduleParameter extends ActivityPipelineScheduleParameter {
  String activityPipelineId;
  String activityCategoryId;
  String feedback;
  String name;
  String description;
  DateTime dateStart;
  DateTime dateEnd;
  String location;
  String meetingUrl;

  MeetingActivityPipelineScheduleParameter({
    required this.activityPipelineId,
    required this.activityCategoryId,
    required this.feedback,
    required this.name,
    required this.description,
    required this.dateStart,
    required this.dateEnd,
    required this.location,
    required this.meetingUrl,
  });
}