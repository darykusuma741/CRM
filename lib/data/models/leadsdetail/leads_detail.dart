import '../address_data.dart';
import '../lead.dart';

class LeadsDetail with AddressData {
  String id;
  String titleId;
  String titleName;
  String name;
  LeadsStatus leadsStatus;
  String contactName;
  String contactJobPosition;
  String contactEmail;
  String contactPhoneNumber;
  String contactState;
  String contactStateId;
  String contactCountry;
  String contactCountryId;
  String contactCity;
  String contactZip;
  String contactStreet;
  String contactStreet2;
  int priority;
  String companyName;
  String companyWebsite;

  @override
  String get street => contactStreet;
  @override
  String get street2 => contactStreet2;
  @override
  String get city => contactCity;
  @override
  String get zip => contactZip;
  @override
  String get country => contactCountry;
  @override
  String get state => contactState;

  LeadsDetail({
    required this.id,
    required this.titleId,
    required this.titleName,
    required this.name,
    required this.leadsStatus,
    required this.contactName,
    required this.contactJobPosition,
    required this.contactEmail,
    required this.contactPhoneNumber,
    required this.contactState,
    required this.contactStateId,
    required this.contactCountry,
    required this.contactCountryId,
    required this.contactCity,
    required this.contactZip,
    required this.contactStreet,
    required this.contactStreet2,
    required this.priority,
    required this.companyName,
    required this.companyWebsite
  });
}