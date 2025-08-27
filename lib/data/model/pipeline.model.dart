import 'package:crm/common/abstract/base_model.dart';

class PipelineModel extends BaseModel<PipelineModel> {
  int id;
  String opportunity;
  String customerName;
  String? companyName;
  String website;
  int priority;
  int expectedRevenue;
  int probability;
  DateTime? expectedClosing;
  String? title;
  String contactName;
  String jobPosition;
  String? email;
  String phoneNumber;
  String city;
  String state;
  String country;
  String streetAddress;
  String postalCode;
  List<String> productCategory;
  String stages;

  PipelineModel({
    required this.id,
    required this.opportunity,
    required this.customerName,
    required this.companyName,
    required this.website,
    this.priority = 0,
    this.expectedRevenue = 0,
    this.probability = 0,
    required this.expectedClosing,
    this.title,
    required this.contactName,
    required this.jobPosition,
    this.email,
    required this.phoneNumber,
    required this.city,
    required this.state,
    required this.country,
    required this.streetAddress,
    required this.postalCode,
    required this.productCategory,
    required this.stages,
  });

  @override
  PipelineModel copyWith({
    int? id,
    String? opportunity,
    String? customerName,
    String? companyName,
    String? website,
    int? priority,
    int? expectedRevenue,
    int? probability,
    DateTime? expectedClosing,
    String? title,
    String? contactName,
    String? jobPosition,
    String? email,
    String? phoneNumber,
    String? city,
    String? state,
    String? country,
    String? streetAddress,
    String? postalCode,
    List<String>? productCategory,
    String? stages,
  }) {
    return PipelineModel(
      id: id ?? this.id,
      opportunity: opportunity ?? this.opportunity,
      customerName: customerName ?? this.customerName,
      companyName: companyName ?? this.companyName,
      website: website ?? this.website,
      priority: priority ?? this.priority,
      expectedRevenue: expectedRevenue ?? this.expectedRevenue,
      probability: probability ?? this.probability,
      expectedClosing: expectedClosing ?? this.expectedClosing,
      title: title ?? this.title,
      contactName: contactName ?? this.contactName,
      jobPosition: jobPosition ?? this.jobPosition,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      streetAddress: streetAddress ?? this.streetAddress,
      postalCode: postalCode ?? this.postalCode,
      productCategory: productCategory ?? this.productCategory,
      stages: stages ?? this.stages,
    );
  }
}
