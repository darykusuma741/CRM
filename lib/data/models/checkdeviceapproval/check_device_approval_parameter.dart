class CheckDeviceApprovalParameter {
  String imeiCode;
  String userId;
  String deviceName;
  String deviceModel;
  String deviceId;
  bool filterOnlyApproved;

  CheckDeviceApprovalParameter({
    required this.imeiCode,
    required this.userId,
    required this.deviceName,
    required this.deviceId,
    required this.deviceModel,
    required this.filterOnlyApproved
  });
}