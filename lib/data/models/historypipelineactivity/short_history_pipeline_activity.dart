class ShortHistoryPipelineActivity {
  String id;
  String resId;
  String name;
  String type;
  String typeId;
  String category;
  String description;
  DateTime? date;
  String imageUrl;
  DateTime? timeFrom;
  DateTime? timeTo;
  DateTime? checkInDateTime;
  double? checkInLatitude;
  double? checkInLongitude;
  String checkInPhotoUrl;
  DateTime? checkOutDateTime;
  double? checkOutLatitude;
  double? checkOutLongitude;
  String checkOutPhotoUrl;
  DateTime? createDate;

  ShortHistoryPipelineActivity({
    required this.id,
    required this.resId,
    required this.name,
    required this.category,
    required this.typeId,
    required this.type,
    required this.description,
    required this.date,
    required this.imageUrl,
    required this.timeFrom,
    required this.timeTo,
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