abstract class AddActivityPipelineParameter {}

class DynamicAddActivityPipelineParameter extends AddActivityPipelineParameter {
  String pipelineId;
  String activityCategoryId;
  String name;
  String description;
  DateTime dateDeadline;

  DynamicAddActivityPipelineParameter({
    required this.pipelineId,
    required this.activityCategoryId,
    required this.name,
    required this.description,
    required this.dateDeadline,
  });
}

class MeetingAddActivityPipelineParameter extends AddActivityPipelineParameter {
  String pipelineId;
  String activityCategoryId;
  String name;
  String description;
  DateTime dateStart;
  DateTime dateEnd;
  String location;
  String meetingUrl;

  MeetingAddActivityPipelineParameter({
    required this.pipelineId,
    required this.activityCategoryId,
    required this.name,
    required this.description,
    required this.dateStart,
    required this.dateEnd,
    required this.location,
    required this.meetingUrl,
  });
}