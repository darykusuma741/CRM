import 'activity_attendance.dart';

class ShortActivity {
  String id;
  String resId;
  String name;
  String type;
  String typeId;
  String description;
  String status;
  String action;
  String category;
  DateTime? startDate;
  DateTime? stopDate;
  String location;
  String meetingUrl;
  ActivityAttendance? activityAttendance;
  String calendarEventId;
  DateTime? createDate;

  ShortActivity({
    required this.id,
    required this.resId,
    required this.name,
    required this.type,
    required this.typeId,
    required this.description,
    required this.status,
    required this.action,
    required this.category,
    required this.startDate,
    required this.stopDate,
    required this.location,
    required this.meetingUrl,
    required this.activityAttendance,
    required this.calendarEventId,
    required this.createDate
  });
}

class FailedShortActivity extends ShortActivity {
  dynamic e;

  FailedShortActivity({
    required this.e,
    required super.id,
    required super.resId,
    required super.name,
    required super.type,
    required super.typeId,
    required super.description,
    required super.status,
    required super.action,
    required super.category,
    required super.startDate,
    required super.stopDate,
    required super.location,
    required super.meetingUrl,
    required super.activityAttendance,
    required super.calendarEventId,
    required super.createDate
  });
}