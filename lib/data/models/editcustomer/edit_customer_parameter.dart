abstract class EditCustomerParameter {
  String customerId;

  EditCustomerParameter({
    required this.customerId
  });
}

class IndividualEditCustomerParameter extends EditCustomerParameter {
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

  IndividualEditCustomerParameter({
    required super.customerId,
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
    required this.userId
  });
}

class CompanyEditCustomerParameter extends EditCustomerParameter {
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

  CompanyEditCustomerParameter({
    required super.customerId,
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