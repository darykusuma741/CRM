class AddCustomerAdditionalAddressParameter {
  String customerId;
  String type;
  String name;
  String email;
  String phone;
  String mobile;
  String street;
  String street2;
  String city;
  String stateId;
  String zip;
  String countryId;
  String comment;

  AddCustomerAdditionalAddressParameter({
    required this.customerId,
    required this.type,
    required this.name,
    required this.email,
    required this.phone,
    required this.mobile,
    required this.street,
    required this.street2,
    required this.city,
    required this.stateId,
    required this.zip,
    required this.countryId,
    required this.comment
  });
}