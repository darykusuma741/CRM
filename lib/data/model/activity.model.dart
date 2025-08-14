import 'package:crm/common/abstract/base_model.dart';

class ActivityModel extends BaseModel<ActivityModel> {
  int id;
  String name;
  String? notes;
  String? feedback;
  String? wa;
  String? description;
  DateTime dueDate;
  bool done;
  ActivityType activityType;

  ActivityModel({
    required this.id,
    required this.name,
    this.notes,
    this.feedback,
    this.wa,
    this.description,
    required this.dueDate,
    this.done = false,
    required this.activityType,
  });

  @override
  ActivityModel copyWith({
    int? id,
    String? name,
    String? notes,
    String? feedback,
    String? wa,
    String? description,
    DateTime? dueDate,
    bool? done,
    ActivityType? activityType,
  }) {
    return ActivityModel(
      id: id ?? this.id,
      name: name ?? this.name,
      notes: notes ?? this.notes,
      feedback: feedback ?? this.feedback,
      wa: wa ?? this.wa,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      done: done ?? this.done,
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

extension ActivityTypeExtension on ActivityType {
  String toShortString() {
    switch (this) {
      case ActivityType.call:
        return 'Call';
      case ActivityType.document:
        return 'Document';
      case ActivityType.meeting:
        return 'Meeting';
      case ActivityType.toDo:
        return 'To Do';
    }
  }
}
