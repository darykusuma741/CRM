import 'customer_category.dart';

class ShortCustomer {
  String id;
  String name;
  String companyName;
  String jobPosition;
  String email;
  String city;
  String zip;
  CustomerCategory customerCategory;
  String stateId;
  String stateName;
  String countryId;
  String countryName;
  String website;

  ShortCustomer({
    required this.id,
    required this.name,
    required this.companyName,
    required this.jobPosition,
    required this.email,
    required this.city,
    required this.zip,
    required this.customerCategory,
    required this.stateId,
    required this.stateName,
    required this.countryId,
    required this.countryName,
    required this.website
  });
}