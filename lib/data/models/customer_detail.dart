import 'address_data.dart';
import 'customer_category.dart';

class CustomerDetail with AddressData {
  String id;
  String userId;
  String userName;
  String name;
  String companyName;
  String jobPosition;
  String email;
  String taxNo;
  String taxId;
  String taxName;
  @override
  String street;
  @override
  String street2;
  @override
  String city;
  @override
  String zip;
  CustomerCategory customerCategory;
  String stateId;
  String stateName;
  String countryId;
  String countryName;
  String phoneNumber;
  String whatsappNumber;
  String website;

  @override
  String get country => countryName;

  @override
  String get state => stateName;

  CustomerDetail({
    required this.id,
    required this.userId,
    required this.userName,
    required this.name,
    required this.companyName,
    required this.jobPosition,
    required this.email,
    required this.taxNo,
    required this.taxId,
    required this.taxName,
    required this.street,
    required this.street2,
    required this.city,
    required this.zip,
    required this.customerCategory,
    required this.stateId,
    required this.stateName,
    required this.countryId,
    required this.countryName,
    required this.phoneNumber,
    required this.whatsappNumber,
    required this.website
  });
}