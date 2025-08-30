enum ShortLostType {
  leads, pipeline
}

class ShortLost {
  String ownerId;
  String name;
  int priority;
  String companyName;
  String contactName;
  String lostReasonId;
  String lostReasonName;
  DateTime? createDate;
  ShortLostType shortLostType;

  ShortLost({
    required this.ownerId,
    required this.name,
    required this.priority,
    required this.companyName,
    required this.contactName,
    required this.lostReasonId,
    required this.lostReasonName,
    required this.createDate,
    required this.shortLostType
  });
}