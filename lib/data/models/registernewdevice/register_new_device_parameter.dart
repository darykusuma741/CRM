class RegisterNewDeviceParameter {
  String imeiCode;
  String userId;
  String deviceName;
  String deviceModel;
  String deviceId;

  RegisterNewDeviceParameter({
    required this.imeiCode,
    required this.userId,
    required this.deviceName,
    required this.deviceId,
    required this.deviceModel
  });
}