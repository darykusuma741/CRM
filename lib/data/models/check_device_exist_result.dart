abstract class CheckDeviceExistResult {}

abstract class ExistCheckDeviceExistResult extends CheckDeviceExistResult {
  String id;
  String deviceId;
  String deviceName;

  ExistCheckDeviceExistResult({
    required this.id,
    required this.deviceId,
    required this.deviceName
  });
}

class WaitingExistCheckDeviceExistResult extends ExistCheckDeviceExistResult {
  String createdDate;

  WaitingExistCheckDeviceExistResult({
    required super.id,
    required super.deviceId,
    required super.deviceName,
    required this.createdDate
  });
}

class ApprovedExistCheckDeviceExistResult extends ExistCheckDeviceExistResult {
  ApprovedExistCheckDeviceExistResult({
    required super.id,
    required super.deviceId,
    required super.deviceName
  });
}

class RejectedExistCheckDeviceExistResult extends ExistCheckDeviceExistResult {
  RejectedExistCheckDeviceExistResult({
    required super.id,
    required super.deviceId,
    required super.deviceName
  });
}

class NotExistCheckDeviceExistResult extends CheckDeviceExistResult {}