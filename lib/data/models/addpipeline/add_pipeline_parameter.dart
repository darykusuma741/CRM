abstract class AddPipelineParameter {}

class CreateNewCustomerAddPipelineParameter extends AddPipelineParameter {
  String customerName;
  String companyName;
  String name;
  String website;
  String opportunity;
  int priority;
  int expectedRevenueFirst;
  int expectedRevenueSecond;
  String period;
  DateTime? expectedClosing;
  String contactEmail;
  String contactPhoneNumber;
  String contactName;

  CreateNewCustomerAddPipelineParameter({
    required this.customerName,
    required this.companyName,
    required this.name,
    required this.website,
    required this.opportunity,
    required this.priority,
    required this.expectedRevenueFirst,
    required this.expectedRevenueSecond,
    required this.period,
    required this.expectedClosing,
    required this.contactEmail,
    required this.contactPhoneNumber,
    required this.contactName
  });
}

class LinkWithCustomerAddPipelineParameter extends AddPipelineParameter {
  String customerId;
  String customerName;
  String opportunity;
  String name;
  String website;
  int priority;
  int expectedRevenueFirst;
  int expectedRevenueSecond;
  String period;
  DateTime? expectedClosing;
  String contactEmail;
  String contactPhoneNumber;
  String contactName;

  LinkWithCustomerAddPipelineParameter({
    required this.customerId,
    required this.customerName,
    required this.opportunity,
    required this.name,
    required this.website,
    required this.priority,
    required this.expectedRevenueFirst,
    required this.expectedRevenueSecond,
    required this.period,
    required this.expectedClosing,
    required this.contactEmail,
    required this.contactPhoneNumber,
    required this.contactName
  });
}