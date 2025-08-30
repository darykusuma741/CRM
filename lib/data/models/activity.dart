// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Activity {
  int id;
  String activityType;
  String activityName;
  String activityDesc;
  String date;
  String imgPath;
  String imgPathCheckInPhoto;
  String status;
  bool? isCheckedIn;

  Activity({
    required this.id,
    required this.activityType,
    required this.activityName,
    this.activityDesc = "",
    required this.date,
    required this.imgPath,
    this.imgPathCheckInPhoto = "",
    required this.status,
    this.isCheckedIn = false,
  });

  Activity copyWith({
    int? id,
    String? activityType,
    String? activityName,
    String? date,
    String? imgPath,
    String? imgPathCheckInPhoto,
    String? status,
    bool? isCheckedIn,
  }) {
    return Activity(
      id: id ?? this.id,
      activityType: activityType ?? this.activityType,
      activityName: activityName ?? this.activityName,
      date: date ?? this.date,
      imgPath: imgPath ?? this.imgPath,
      imgPathCheckInPhoto: imgPathCheckInPhoto ?? this.imgPathCheckInPhoto,
      status: status ?? this.status,
      isCheckedIn: isCheckedIn ?? this.isCheckedIn,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'activityType': activityType,
      'activityName': activityName,
      'date': date,
      'imgPath': imgPath,
      'imgPathCheckInPhoto': imgPathCheckInPhoto,
      'status': status,
      'isCheckedIn': isCheckedIn,
    };
  }

  factory Activity.fromMap(Map<String, dynamic> map) {
    return Activity(
      id: map['id'] as int,
      activityType: map['activityType'] as String,
      activityName: map['activityName'] as String,
      date: map['date'] as String,
      imgPathCheckInPhoto: map['imgPathCheckInPhoto'] as dynamic,
      imgPath: map['imgPath'] as String,
      status: map['status'] as String,
      isCheckedIn:
          map['isCheckedIn'] != null ? map['isCheckedIn'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Activity.fromJson(String source) =>
      Activity.fromMap(json.decode(source) as Map<String, dynamic>);
}

List<Activity> activities = [
  Activity(
      id: 0,
      status: "Done",
      activityType: "To Do",
      activityName: "Call to get system requirements",
      imgPath: "",
      date: "7 July 23, 14:00"),
  Activity(
      id: 1,
      status: "Check-in",
      isCheckedIn: false,
      activityType: "Visit",
      activityName: "Design Quotation",
      imgPath: "",
      date: "10 July 23, 07:00"),
  Activity(
      id: 1,
      status: "Check-in",
      isCheckedIn: false,
      activityType: "Visit",
      activityName: "Document Meeting 2.0 PT Abadi Jaya",
      imgPath: "",
      date: "7 July 2023, 12:00"),
  Activity(
      id: 2,
      status: "Check-in",
      isCheckedIn: false,
      activityType: "Visit",
      activityName: "Discuss Proposal",
      imgPath: "",
      date: "11 July 23, 22:10"),
  Activity(
      status: "Done",
      id: 3,
      activityType: "Document",
      activityName: "Document Meeting 2.0 PT Abadi Jaya",
      imgPath: "",
      date: "11 July 23, 22:10"),
  Activity(
      id: 0,
      status: "Done",
      activityType: "To Do",
      activityName: "Call to get system requirements",
      imgPath: "",
      date: "7 July 23, 14:00"),
  Activity(
      id: 1,
      status: "Check-in",
      isCheckedIn: false,
      activityType: "Visit",
      activityName: "Design Quotation",
      imgPath: "",
      date: "10 July 23, 07:00"),
  Activity(
      id: 1,
      status: "Check-in",
      isCheckedIn: false,
      activityType: "Visit",
      activityName: "Document Meeting 2.0 PT Abadi Jaya",
      imgPath: "",
      date: "7 July 2023, 12:00"),
  Activity(
      id: 2,
      status: "Check-in",
      isCheckedIn: false,
      activityType: "Visit",
      activityName: "Discuss Proposal",
      imgPath: "",
      date: "11 July 23, 22:10"),
  Activity(
      status: "Done",
      id: 3,
      activityType: "Document",
      activityName: "Document Meeting 2.0 PT Abadi Jaya",
      imgPath: "",
      date: "11 July 23, 22:10"),
  Activity(
      id: 0,
      status: "Done",
      activityType: "To Do",
      activityName: "Call to get system requirements",
      imgPath: "",
      date: "7 July 23, 14:00"),
  Activity(
      id: 1,
      status: "Check-in",
      isCheckedIn: false,
      activityType: "Visit",
      activityName: "Design Quotation",
      imgPath: "",
      date: "10 July 23, 07:00"),
  Activity(
      id: 1,
      status: "Check-in",
      isCheckedIn: false,
      activityType: "Visit",
      activityName: "Document Meeting 2.0 PT Abadi Jaya",
      imgPath: "",
      date: "7 July 2023, 12:00"),
  Activity(
      id: 2,
      status: "Check-in",
      isCheckedIn: false,
      activityType: "Visit",
      activityName: "Discuss Proposal",
      imgPath: "",
      date: "11 July 23, 22:10"),
  Activity(
      status: "Done",
      id: 3,
      activityType: "Document",
      activityName: "Document Meeting 2.0 PT Abadi Jaya",
      imgPath: "",
      date: "11 July 23, 22:10"),
];

List<Activity> activityPipelines = [
  Activity(
    id: 0,
    status: "Start",
    activityType: "Email",
    activityName: "Email Follow-Up",
    imgPath: "",
    date: "12 Dec, 8:00"
  ),
  Activity(
    id: 1,
    status: "Done",
    activityType: "Call",
    activityName: "Pipeline Progress Call",
    imgPath: "",
    date: "12 Dec, 8:20"
  ),
  Activity(
    id: 1,
    status: "Check-in",
    isCheckedIn: false,
    activityType: "Meeting",
    activityName: "Pipeline Planning Session",
    imgPath: "",
    date: "12 Dec, 10:20"
  ),
  Activity(
    id: 2,
    status: "Start",
    activityType: "To Do",
    activityName: "Review Proposal Draft",
    imgPath: "",
    date: "12 Dec, 10:20"
  ),
  Activity(
    id: 3,
    status: "Start",
    activityType: "Upload Document",
    activityName: "Upload Client Requirements",
    imgPath: "",
    date: "12 Dec, 14:20"
  ),
];

List<Activity> historyActivityPipelines = [
  Activity(
    id: 1,
    status: "Done",
    activityType: "Call",
    activityName: "Pipeline Progress Call",
    imgPath: "",
    date: "12 Dec, 8:20"
  ),
  Activity(
    id: 2,
    status: "Done",
    activityType: "Call",
    activityName: "Pipeline Progress Call",
    activityDesc: "Great job! the discussions were productive and everyone contributed effectively.",
    imgPath: "",
    date: "12 Dec, 8:20"
  ),
];