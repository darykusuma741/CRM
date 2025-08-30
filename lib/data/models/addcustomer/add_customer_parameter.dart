abstract class AddCustomerParameter {}

class IndividualAddCustomerParameter extends AddCustomerParameter {
  String name;
  String taxId;
  String email;
  String phoneNumber;
  String whatsappNumber;
  String street;
  String street2;
  String city;
  String stateId;
  String zip;
  String countryId;
  String website;
  String jobPosition;
  String? userId;

  IndividualAddCustomerParameter({
    required this.name,
    required this.taxId,
    required this.email,
    required this.phoneNumber,
    required this.whatsappNumber,
    required this.street,
    required this.street2,
    required this.city,
    required this.stateId,
    required this.zip,
    required this.countryId,
    required this.website,
    required this.jobPosition,
    required this.userId,
  });
}

class CompanyAddCustomerParameter extends AddCustomerParameter {
  String name;
  String taxId;
  String email;
  String phoneNumber;
  String whatsappNumber;
  String street;
  String street2;
  String city;
  String stateId;
  String countryId;
  String zip;
  String website;
  String? userId;

  CompanyAddCustomerParameter({
    required this.name,
    required this.taxId,
    required this.email,
    required this.phoneNumber,
    required this.whatsappNumber,
    required this.street,
    required this.street2,
    required this.city,
    required this.stateId,
    required this.countryId,
    required this.zip,
    required this.website,
    required this.userId
  });
}