class ActivityAttendance {
  String id;
  String activityState;
  DateTime? checkInDateTime;
  double? checkInLatitude;
  double? checkInLongitude;
  String checkInPhotoUrl;
  DateTime? checkOutDateTime;
  double? checkOutLatitude;
  double? checkOutLongitude;
  String checkOutPhotoUrl;

  ActivityAttendance({
    required this.id,
    required this.activityState,
    required this.checkInDateTime,
    required this.checkInLatitude,
    required this.checkInLongitude,
    required this.checkInPhotoUrl,
    required this.checkOutDateTime,
    required this.checkOutLatitude,
    required this.checkOutLongitude,
    required this.checkOutPhotoUrl
  });
}