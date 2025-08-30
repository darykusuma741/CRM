class EditPipelineParameter {
  String pipelineId;
  String customerId;
  String customerName;
  String name;
  String opportunity;
  int priority;
  int expectedRevenueFirst;
  int expectedRevenueSecond;
  String period;
  DateTime? expectedClosing;
  String website;
  String contactName;
  String contactEmail;
  String contactPhoneNumber;

  EditPipelineParameter({
    required this.pipelineId,
    required this.customerId,
    required this.customerName,
    required this.name,
    required this.opportunity,
    required this.priority,
    required this.expectedRevenueFirst,
    required this.expectedRevenueSecond,
    required this.period,
    required this.expectedClosing,
    required this.website,
    required this.contactName,
    required this.contactEmail,
    required this.contactPhoneNumber
  });
}