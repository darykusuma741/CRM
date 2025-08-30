class CheckOutActivityPipelineParameter {
  String attendanceId;
  String activityId;
  double checkOutLatitude;
  double checkOutLongitude;
  String checkOutIpAddress;
  String imageUrl;
  DateTime checkOutTime;

  CheckOutActivityPipelineParameter({
    required this.attendanceId,
    required this.activityId,
    required this.checkOutLatitude,
    required this.checkOutLongitude,
    required this.checkOutIpAddress,
    required this.imageUrl,
    required this.checkOutTime,
  });
}