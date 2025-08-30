abstract class CheckDeviceApprovalResult {}

class ApprovedCheckDeviceApprovalResult extends CheckDeviceApprovalResult {
  String id;
  String deviceId;
  String deviceName;
  String createdDate;

  ApprovedCheckDeviceApprovalResult({
    required this.id,
    required this.deviceId,
    required this.deviceName,
    required this.createdDate
  });
}

class RejectedCheckDeviceApprovalResult extends CheckDeviceApprovalResult {
  String createdDate;

  RejectedCheckDeviceApprovalResult({
    required this.createdDate
  });
}

class NotApprovedCheckDeviceApprovalResult extends CheckDeviceApprovalResult {}