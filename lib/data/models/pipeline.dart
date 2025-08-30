// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:crm/data/models/pipeline_phase..dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'activity.dart';
import 'pipeline_label_badge_item_value.dart';

class PipelineStatus {
  String id;
  String name;
  String backgroundColorHex;
  String textColorHex;

  PipelineStatus({
    required this.id,
    required this.name,
    required this.backgroundColorHex,
    required this.textColorHex
  });
}

class ShortPipeline implements PipelineLabelBadgeItemValue {
  String id;
  String name;
  PipelineStatus pipelineStatus;
  @override
  bool isLost;
  String contactEmail;
  String contactPhoneNumber;
  int priority;
  double? expectedRevenue;

  ShortPipeline({
    required this.id,
    required this.name,
    required this.pipelineStatus,
    required this.isLost,
    required this.contactEmail,
    required this.contactPhoneNumber,
    required this.priority,
    this.expectedRevenue
  });

  @override
  String get state => pipelineStatus.name;

  @override
  String get backgroundColorHex => pipelineStatus.backgroundColorHex;

  @override
  String get textColorHex => pipelineStatus.textColorHex;
}

class Pipeline implements PipelineLabelBadgeItemValue {
  final int id;
  final String companyName;
  final String companyWebsite;
  final String opportunity;
  final int priority;
  final int expectedRevenueFrom;
  final int expectedRevenueTo;
  final String period;
  final DateTime periodDate;
  final String pipelineName;
  final String customerName;
  final String email;
  final String phone;
  String state;
  bool isSelected;
  bool isLost;
  final int rating;
  final List<Activity> activities;
  final List<PipelinePhase>? pipelineState;

  @override
  String get backgroundColorHex => "";

  @override
  String get textColorHex => "";

  Pipeline({
    required this.id,
    required this.companyName,
    required this.companyWebsite,
    required this.opportunity,
    required this.priority,
    required this.expectedRevenueFrom,
    required this.expectedRevenueTo,
    required this.period,
    required this.periodDate,
    required this.email,
    required this.phone,
    required this.pipelineName,
    required this.customerName,
    required this.state,
    required this.isSelected,
    required this.isLost,
    required this.rating,
    required this.activities,
    this.pipelineState,
  });

  // Pipeline(
  //     {required this.id,
  //     required this.customerName,
  //     required this.email,
  //     required this.phone,
  //     required this.state,
  //     this.isSelected = false});

  @override
  String toString() {
    return 'Pipeline(id: $id, pipelineName: $pipelineName, customerName: $customerName, email: $email, phone: $phone, state: $state, isSelected: $isSelected, activities: $activities, pipelineState: $pipelineState)';
  }

  Pipeline copyWith({
    int? id,
    String? companyName,
    String? companyWebsite,
    String? opportunity,
    int? priority,
    int? expectedRevenueFrom,
    int? expectedRevenueTo,
    String? period,
    DateTime? periodDate,
    String? pipelineName,
    String? customerName,
    int? rating,
    String? email,
    String? phone,
    String? state,
    bool? isSelected,
    bool? isLost,
    List<Activity>? activities,
    List<PipelinePhase>? pipelineState,
  }) {
    return Pipeline(
      id: id ?? this.id,
      companyName: companyName ?? this.companyName,
      companyWebsite: companyWebsite ?? this.companyWebsite,
      opportunity: opportunity ?? this.opportunity,
      priority: priority ?? this.priority,
      expectedRevenueFrom: expectedRevenueFrom ?? this.expectedRevenueFrom,
      expectedRevenueTo: expectedRevenueTo ?? this.expectedRevenueTo,
      period: period ?? this.period,
      periodDate: periodDate ?? this.periodDate,
      pipelineName: pipelineName ?? this.pipelineName,
      customerName: customerName ?? this.customerName,
      rating: rating ?? this.rating,
      isLost: isLost ?? this.isLost,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      state: state ?? this.state,
      isSelected: isSelected ?? this.isSelected,
      activities: activities ?? this.activities,
      pipelineState: pipelineState ?? this.pipelineState,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'pipelineName': pipelineName,
      'companyName': companyName,
      'companyWebsite': companyWebsite,
      'opportunity': opportunity,
      'priority': priority,
      'expectedRevenueFrom': expectedRevenueFrom,
      'expectedRevenueTo': expectedRevenueTo,
      'period': period,
      'periodDate': DateFormat('dd/MM/yyyy').format(periodDate),
      'customerName': customerName,
      'email': email,
      'phone': phone,
      'state': state,
      'isSelected': isSelected,
      'isLost': isLost ? 1 : 0,
      'activities': activities.map((x) => x.toMap()).toList(),
      'pipelineState': pipelineState!.map((x) => x.toMap()).toList(),
    };
  }

  factory Pipeline.fromMap(Map<String, dynamic> map) {
    return Pipeline(
      id: map['id'] as int,
      pipelineName: map['pipelineName'] as String,
      companyName: map['companyName'] as String,
      companyWebsite: map['companyWebsite'] as String,
      opportunity: map['opportunity'] as String,
      priority: map['priority'] as int,
      expectedRevenueFrom: map['expectedRevenueFrom'] as int,
      expectedRevenueTo: map['expectedRevenueTo'] as int,
      period: map['period'] as String,
      periodDate: DateFormat('dd/MM/yyyy').parse(map['periodDate'] as String),
      customerName: map['customerName'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      state: map['state'] as String,
      rating: map['rating'] as int,
      isLost: (map['isLost'] as int) == 1,
      isSelected: map['isSelected'] as bool,
      activities: List<Activity>.from(
        (map['activities'] as List<int>).map<Activity>(
          (x) => Activity.fromMap(x as Map<String, dynamic>),
        ),
      ),
      pipelineState: map['pipelineState'] != null
          ? List<PipelinePhase>.from(
              (map['pipelineState'] as List<int>).map<PipelinePhase?>(
                (x) => PipelinePhase.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Pipeline.fromJson(String source) =>
      Pipeline.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant Pipeline other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.companyName == companyName &&
        other.companyWebsite == companyWebsite &&
        other.opportunity == opportunity &&
        other.priority == priority &&
        other.expectedRevenueFrom == expectedRevenueFrom &&
        other.expectedRevenueTo == expectedRevenueTo &&
        other.period == period &&
        other.periodDate == periodDate &&
        other.pipelineName == pipelineName &&
        other.customerName == customerName &&
        other.email == email &&
        other.phone == phone &&
        other.state == state &&
        other.isSelected == isSelected &&
        listEquals(other.activities, activities) &&
        listEquals(other.pipelineState, pipelineState);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        companyName.hashCode ^
        companyWebsite.hashCode ^
        opportunity.hashCode ^
        priority.hashCode ^
        expectedRevenueFrom.hashCode ^
        expectedRevenueTo.hashCode ^
        period.hashCode ^
        periodDate.hashCode ^
        pipelineName.hashCode ^
        customerName.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        state.hashCode ^
        rating.hashCode ^
        isSelected.hashCode ^
        activities.hashCode ^
        pipelineState.hashCode;
  }
}

List<Pipeline> listCustomerPipelines = [
  Pipeline(
    id: 1,
    pipelineName: "Pipeline 1",
    companyName: "Scale Ocean",
    companyWebsite: "scaleocean.com",
    opportunity: "This is the opportunity",
    priority: 3,
    expectedRevenueFrom: 10000,
    expectedRevenueTo: 20000,
    period: "Weekly",
    periodDate: DateTime.now(),
    customerName: "PT Jaya Bangunan",
    email: "HvLq0@example.com",
    phone: "08123456789",
    state: "New",
    isLost: false,
    rating: 3,
    isSelected: false,
    activities: [
      Activity(
        id: 1,
        status: "Check-out",
        isCheckedIn: true,
        activityType: "Visit",
        activityName: "Design Quotation",
        imgPath: "",
        date: "10 July 23, 07:00",
      )
    ],
  ),
  Pipeline(
    id: 2,
    pipelineName: "Pipeline 2",
    companyName: "Scale Ocean",
    companyWebsite: "scaleocean.com",
    opportunity: "This is the opportunity",
    priority: 3,
    expectedRevenueFrom: 10000,
    expectedRevenueTo: 20000,
    period: "Weekly",
    periodDate: DateTime.now(),
    customerName: "PT Sentosa Pondasi",
    email: "sentosa0@example.com",
    phone: "08123456788",
    state: "Win",
    rating: 3,
    isSelected: false,
    isLost: false,
    activities: [],
  ),
  Pipeline(
    id: 3,
    pipelineName: "Pipeline 3",
    companyName: "Scale Ocean",
    companyWebsite: "scaleocean.com",
    opportunity: "This is the opportunity",
    priority: 3,
    expectedRevenueFrom: 10000,
    expectedRevenueTo: 20000,
    period: "Weekly",
    periodDate: DateTime.now(),
    customerName: "PT Jaya Bangunan",
    email: "HvLq0@example.com",
    phone: "08123456789",
    state: "Qualified",
    rating: 2,
    isSelected: false,
    isLost: false,
    activities: [],
  ),
  Pipeline(
    id: 4,
    pipelineName: "Pipeline 4",
    companyName: "Scale Ocean",
    companyWebsite: "scaleocean.com",
    opportunity: "This is the opportunity",
    priority: 3,
    expectedRevenueFrom: 10000,
    expectedRevenueTo: 20000,
    period: "Weekly",
    periodDate: DateTime.now(),
    customerName: "PT Jaya Bangunan",
    email: "HvLq0@example.com",
    phone: "08123456789",
    state: "Proposition",
    rating: 3,
    isSelected: false,
    isLost: false,
    activities: [],
  ),
  Pipeline(
    id: 5,
    pipelineName: "Pipeline 5",
    companyName: "Scale Ocean",
    companyWebsite: "scaleocean.com",
    opportunity: "This is the opportunity",
    priority: 3,
    expectedRevenueFrom: 10000,
    expectedRevenueTo: 20000,
    period: "Weekly",
    periodDate: DateTime.now(),
    customerName: "PT Jaya Bangunan",
    email: "HvLq0@example.com",
    phone: "08123456789",
    state: "New",
    rating: 2,
    isSelected: false,
    isLost: false,
    activities: [],
  ),
  Pipeline(
    id: 6,
    pipelineName: "Pipeline 6",
    companyName: "Scale Ocean",
    companyWebsite: "scaleocean.com",
    opportunity: "This is the opportunity",
    priority: 3,
    expectedRevenueFrom: 10000,
    expectedRevenueTo: 20000,
    period: "Weekly",
    periodDate: DateTime.now(),
    customerName: "PT Jaya Bangunan",
    email: "HvLq0@example.com",
    phone: "08123456789",
    state: "Proposition",
    rating: 2,
    isSelected: false,
    isLost: true,
    activities: [],
  ),
  Pipeline(
    id: 7,
    pipelineName: "Pipeline 7",
    companyName: "Scale Ocean",
    companyWebsite: "scaleocean.com",
    opportunity: "This is the opportunity",
    priority: 3,
    expectedRevenueFrom: 10000,
    expectedRevenueTo: 20000,
    period: "Weekly",
    periodDate: DateTime.now(),
    customerName: "PT Jaya Bangunan",
    email: "HvLq0@example.com",
    phone: "08123456789",
    state: "New",
    isLost: false,
    rating: 3,
    isSelected: false,
    activities: [
      Activity(
        id: 1,
        status: "Check-out",
        isCheckedIn: true,
        activityType: "Visit",
        activityName: "Design Quotation",
        imgPath: "",
        date: "10 July 23, 07:00",
      )
    ],
  ),
  Pipeline(
    id: 8,
    pipelineName: "Pipeline 8",
    companyName: "Scale Ocean",
    companyWebsite: "scaleocean.com",
    opportunity: "This is the opportunity",
    priority: 3,
    expectedRevenueFrom: 10000,
    expectedRevenueTo: 20000,
    period: "Weekly",
    periodDate: DateTime.now(),
    customerName: "PT Sentosa Pondasi",
    email: "sentosa0@example.com",
    phone: "08123456788",
    state: "Win",
    rating: 3,
    isSelected: false,
    isLost: false,
    activities: [],
  ),
  Pipeline(
    id: 9,
    pipelineName: "Pipeline 9",
    companyName: "Scale Ocean",
    companyWebsite: "scaleocean.com",
    opportunity: "This is the opportunity",
    priority: 3,
    expectedRevenueFrom: 10000,
    expectedRevenueTo: 20000,
    period: "Weekly",
    periodDate: DateTime.now(),
    customerName: "PT Jaya Bangunan",
    email: "HvLq0@example.com",
    phone: "08123456789",
    state: "Qualified",
    rating: 2,
    isSelected: false,
    isLost: false,
    activities: [],
  ),
  Pipeline(
    id: 10,
    pipelineName: "Pipeline 10",
    companyName: "Scale Ocean",
    companyWebsite: "scaleocean.com",
    opportunity: "This is the opportunity",
    priority: 3,
    expectedRevenueFrom: 10000,
    expectedRevenueTo: 20000,
    period: "Weekly",
    periodDate: DateTime.now(),
    customerName: "PT Jaya Bangunan",
    email: "HvLq0@example.com",
    phone: "08123456789",
    state: "Proposition",
    rating: 3,
    isSelected: false,
    isLost: false,
    activities: [],
  ),
  Pipeline(
    id: 11,
    pipelineName: "Pipeline 12",
    companyName: "Scale Ocean",
    companyWebsite: "scaleocean.com",
    opportunity: "This is the opportunity",
    priority: 3,
    expectedRevenueFrom: 10000,
    expectedRevenueTo: 20000,
    period: "Weekly",
    periodDate: DateTime.now(),
    customerName: "PT Jaya Bangunan",
    email: "HvLq0@example.com",
    phone: "08123456789",
    state: "New",
    rating: 2,
    isSelected: false,
    isLost: false,
    activities: [],
  ),
];

enum Customer { existingPipeline, existingCustomer, newCustomer }
