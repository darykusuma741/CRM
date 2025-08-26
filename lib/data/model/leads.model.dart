import 'package:crm/common/abstract/base_model.dart';

class LeadsModel extends BaseModel<LeadsModel> {
  int id;
  String leadName;
  String? title;
  String contactName;
  String? companyName;
  List<String> productCategoty;
  String companyWebsite;
  String email;
  String phoneNumber;
  String jobPosition;
  String streetAddress;
  String city;
  String state;
  String country;
  String postalCode;
  int rating;
  LeadsType type;

  LeadsModel({
    required this.id,
    required this.leadName,
    this.title,
    required this.contactName,
    this.companyName,
    required this.productCategoty,
    required this.companyWebsite,
    required this.email,
    required this.phoneNumber,
    required this.jobPosition,
    required this.streetAddress,
    required this.city,
    required this.state,
    required this.country,
    required this.postalCode,
    required this.rating,
    required this.type,
  });

  @override
  LeadsModel copyWith({
    int? id,
    String? leadName,
    String? title,
    String? contactName,
    String? companyName,
    String? companyWebsite,
    List<String>? productCategoty,
    String? email,
    String? phoneNumber,
    String? jobPosition,
    String? streetAddress,
    String? city,
    String? state,
    String? country,
    String? postalCode,
    int? rating,
    LeadsType? type,
  }) {
    return LeadsModel(
      id: id ?? this.id,
      leadName: leadName ?? this.leadName,
      title: title ?? this.title,
      contactName: contactName ?? this.contactName,
      companyName: companyName ?? this.companyName,
      companyWebsite: companyWebsite ?? this.companyWebsite,
      productCategoty: productCategoty ?? this.productCategoty,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      jobPosition: jobPosition ?? this.jobPosition,
      streetAddress: streetAddress ?? this.streetAddress,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      postalCode: postalCode ?? this.postalCode,
      rating: rating ?? this.rating,
      type: type ?? this.type,
    );
  }
}

enum LeadsType {
  prospects,
  lost,
}

extension LeadsTypeExtension on LeadsType {
  String toShortString() {
    switch (this) {
      case LeadsType.lost:
        return 'Lost';
      case LeadsType.prospects:
        return 'Prospects';
    }
  }
}
