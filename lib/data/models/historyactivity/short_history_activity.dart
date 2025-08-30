class ShortHistoryActivity {
  String id;
  String resId;
  String name;
  String type;
  String typeId;
  String category;
  String description;
  DateTime? startDateTime;
  DateTime? stopDateTime;
  DateTime? checkInDateTime;
  double? checkInLatitude;
  double? checkInLongitude;
  String checkInPhotoUrl;
  DateTime? checkOutDateTime;
  double? checkOutLatitude;
  double? checkOutLongitude;
  String checkOutPhotoUrl;
  DateTime? createDate;

  ShortHistoryActivity({
    required this.id,
    required this.resId,
    required this.name,
    required this.type,
    required this.typeId,
    required this.category,
    required this.description,
    required this.startDateTime,
    required this.stopDateTime,
    required this.checkInDateTime,
    required this.checkInLatitude,
    required this.checkInLongitude,
    required this.checkInPhotoUrl,
    required this.checkOutDateTime,
    required this.checkOutLatitude,
    required this.checkOutLongitude,
    required this.checkOutPhotoUrl,
    required this.createDate
  });
}