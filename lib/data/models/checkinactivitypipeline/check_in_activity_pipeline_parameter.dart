class CheckInActivityPipelineParameter {
  String activityId;
  double checkInLatitude;
  double checkInLongitude;
  String checkInIpAddress;
  String imageUrl;
  DateTime checkInTime;

  CheckInActivityPipelineParameter({
    required this.activityId,
    required this.checkInLatitude,
    required this.checkInLongitude,
    required this.checkInIpAddress,
    required this.imageUrl,
    required this.checkInTime,
  });
}