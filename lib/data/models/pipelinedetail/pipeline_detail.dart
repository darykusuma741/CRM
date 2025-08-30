import '../address_data.dart';
import '../lead.dart';
import '../pipeline.dart';

class PipelineDetail with AddressData {
  String id;
  String name;
  bool isLost;
  PipelineStatus pipelineStatus;
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
  String period;
  DateTime? expectedClosing;
  double? expectedRevenueFirst;
  double? expectedRevenueSecond;
  double probability;

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

  PipelineDetail({
    required this.id,
    required this.name,
    required this.isLost,
    required this.pipelineStatus,
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
    required this.companyWebsite,
    required this.period,
    required this.expectedClosing,
    required this.expectedRevenueFirst,
    required this.expectedRevenueSecond,
    required this.probability
  });
}