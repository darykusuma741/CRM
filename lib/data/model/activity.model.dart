import 'package:crm/common/abstract/base_model.dart';

class ActivityModel extends BaseModel<ActivityModel> {
  int id;
  String summary;
  String? notes;
  String? feedback;
  DateTime dueDate;
  ActivityType activityType;

  ActivityModel({
    required this.id,
    required this.summary,
    this.notes,
    this.feedback,
    required this.dueDate,
    required this.activityType,
  });

  @override
  ActivityModel copyWith({
    int? id,
    String? summary,
    String? notes,
    String? feedback,
    DateTime? dueDate,
    ActivityType? activityType,
  }) {
    return ActivityModel(
      id: id ?? this.id,
      summary: summary ?? this.summary,
      notes: notes ?? this.notes,
      feedback: feedback ?? this.feedback,
      dueDate: dueDate ?? this.dueDate,
      activityType: activityType ?? this.activityType,
    );
  }
}

enum ActivityType {
  call,
  document,
  meeting,
  toDo,
}
