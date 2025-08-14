import 'package:crm/common/abstract/base_model.dart';

class LocationGeocodingModel extends BaseModel<LocationGeocodingModel> {
  String formattedAddress;
  double latitude;
  double longitude;

  LocationGeocodingModel({
    required this.formattedAddress,
    required this.latitude,
    required this.longitude,
  });

  factory LocationGeocodingModel.fromJson(Map<String, dynamic> json) {
    return LocationGeocodingModel(
      formattedAddress: json['formatted_address'],
      latitude: json['geometry']['location']['lat'],
      longitude: json['geometry']['location']['lng'],
    );
  }

  @override
  LocationGeocodingModel copyWith({
    String? formattedAddress,
    double? latitude,
    double? longitude,
  }) {
    return LocationGeocodingModel(
      formattedAddress: formattedAddress ?? this.formattedAddress,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
