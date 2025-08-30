import 'dart:convert';

import 'leads_label_badge_item_value.dart';

class LeadsStatus {
  String id;
  String name;
  String backgroundColorHex;
  String textColorHex;

  LeadsStatus({
    required this.id,
    required this.name,
    required this.backgroundColorHex,
    required this.textColorHex
  });
}

class ShortLeads implements LeadsLabelBadgeItemValue {
  String id;
  String name;
  LeadsStatus leadStatus;
  String contactEmail;
  String contactPhoneNumber;
  int priority;

  ShortLeads({
    required this.id,
    required this.name,
    required this.leadStatus,
    required this.contactEmail,
    required this.contactPhoneNumber,
    required this.priority
  });

  @override
  String get status => leadStatus.name;

  @override
  String get backgroundColorHex => leadStatus.backgroundColorHex;

  @override
  String get textColorHex => leadStatus.textColorHex;
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Lead implements LeadsLabelBadgeItemValue {
  int? id;
  String leadName;
  String email;
  String phone;
  @override
  String status;
  String? expectedRevenue;
  Name name;
  String jobPosition;
  LeadAddress address;
  String companyName;
  String companyWebsite;
  int rating;

  @override
  String get backgroundColorHex => "";

  @override
  String get textColorHex => "";

  Lead({
    this.id,
    required this.leadName,
    required this.email,
    required this.phone,
    required this.status,
    this.expectedRevenue,
    required this.name,
    required this.jobPosition,
    required this.address,
    required this.companyName,
    required this.companyWebsite,
    required this.rating,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'leadName': leadName,
      'email': email,
      'phone': phone,
      'status': status,
      'expectedRevenue': expectedRevenue,
      'name': name,
      'jobPosition': jobPosition,
      'address': address,
      'companyName': companyName,
      'companyWebsite': companyWebsite,
      'rating': rating,
    };
  }

  factory Lead.fromMap(Map<String, dynamic> map) {
    return Lead(
      id: map['id'] != null ? map['id'] as int : null,
      leadName: map['leadName'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      status: map['status'] as String,
      name: map['name'] as Name,
      expectedRevenue: map['expectedRevenue'] != null
          ? map['expectedRevenue'] as String
          : null,
      rating: map['rating'] as int,
      jobPosition: map['jobPosition'] as String,
      address: map['address'] as LeadAddress,
      companyName: map['companyName'] as String,
      companyWebsite: map['companyWebsite'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Lead.fromJson(String source) =>
      Lead.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Lead(id: $id, leadName: $leadName, email: $email, phone: $phone, status: $status, expectedRevenue: $expectedRevenue, rating: $rating)';
  }

  Lead copyWith({
    int? id,
    String? leadName,
    String? email,
    String? phone,
    String? status,
    String? expectedRevenue,
    Name? name,
    String? jobPosition,
    LeadAddress? address,
    String? companyName,
    String? companyWebsite,
    int? rating,
  }) {
    return Lead(
      id: id ?? this.id,
      leadName: leadName ?? this.leadName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      status: status ?? this.status,
      expectedRevenue: expectedRevenue ?? this.expectedRevenue,
      name: name ?? this.name,
      jobPosition: jobPosition ?? this.jobPosition,
      address: address ?? this.address,
      companyName: companyName ?? this.companyName,
      companyWebsite: companyWebsite ?? this.companyWebsite,
      rating: rating ?? this.rating,
    );
  }
}

class LeadAddress {
  String state;
  String country;
  String city;
  String address;

  LeadAddress({
    required this.state,
    required this.country,
    required this.city,
    required this.address
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'state': state,
      'country': country,
      'city': city,
      'address': address,
    };
  }

  factory LeadAddress.fromMap(Map<String, dynamic> map) {
    return LeadAddress(
      state: map['state'] != null ? map['state'] as String : "",
      country: map['country'] != null ? map['country'] as String : "",
      city: map['city'] != null ? map['city'] as String : "",
      address: map['address'] != null ? map['address'] as String : "",
    );
  }

  String toJson() => json.encode(toMap());

  factory LeadAddress.fromJson(String source) => LeadAddress.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return "$address, $city, $state, $country}";
  }
}

List<Lead> listLeads = [
  Lead(
    id: 1,
    leadName: "Acadia College Furnitures",
    email: "example0@mail.com",
    phone: "08123456789",
    status: "Prospects",
    name: Name(
      title: "Miss",
      name: "Melina Putri"
    ),
    jobPosition: "UI/UX Designer",
    address: LeadAddress(
      address: "Neo Soho Podomoro City Unit 3101 Jalan Letjen Parman Kav. 28, Grogol Petamburan Kec. Menteng",
      city: "Jakarta Barat",
      state: "Jakarta",
      country: "Indonesian"
    ),
    companyName: "ScaleOcean",
    companyWebsite: "www.scaleocean.com",
    rating: 3,
  ),
  Lead(
    id: 2,
    leadName: "PT Sentosa Pondasi",
    email: "sentosa0@example.com",
    phone: "08123456788",
    status: "Prospects",
    name: Name(
      title: "Miss",
      name: "Melina Putri"
    ),
    jobPosition: "UI/UX Designer",
    address: LeadAddress(
      address: "Neo Soho Podomoro City Unit 3101 Jalan Letjen Parman Kav. 28, Grogol Petamburan Kec. Menteng",
      city: "Jakarta Barat",
      state: "Jakarta",
      country: "Indonesian"
    ),
    companyName: "ScaleOcean",
    companyWebsite: "www.scaleocean.com",
    rating: 3,
  ),
  Lead(
    id: 3,
    leadName: "PT Sinar Mas Cemara Indonesia",
    email: "sincemai0@mail.com",
    phone: "08123456787",
    status: "Prospects",
    name: Name(
      title: "Miss",
      name: "Melina Putri"
    ),
    jobPosition: "UI/UX Designer",
    address: LeadAddress(
      address: "Neo Soho Podomoro City Unit 3101 Jalan Letjen Parman Kav. 28, Grogol Petamburan Kec. Menteng",
      city: "Jakarta Barat",
      state: "Jakarta",
      country: "Indonesian"
    ),
    companyName: "ScaleOcean",
    companyWebsite: "www.scaleocean.com",
    rating: 3,
  ),
  Lead(
    id: 4,
    leadName: "PT Jaya Teknologi",
    email: "jaya0@example.com",
    phone: "08123456786",
    status: "Lost",
    name: Name(
      title: "Miss",
      name: "Melina Putri"
    ),
    jobPosition: "UI/UX Designer",
    address: LeadAddress(
      address: "Neo Soho Podomoro City Unit 3101 Jalan Letjen Parman Kav. 28, Grogol Petamburan Kec. Menteng",
      city: "Jakarta Barat",
      state: "Jakarta",
      country: "Indonesian"
    ),
    companyName: "ScaleOcean",
    companyWebsite: "www.scaleocean.com",
    rating: 1,
  ),
  Lead(
    id: 5,
    leadName: "PT Cemara Abadi",
    email: "cemara0@example.com",
    phone: "08123456785",
    status: "Prospects",
    name: Name(
      title: "Miss",
      name: "Melina Putri"
    ),
    jobPosition: "UI/UX Designer",
    address: LeadAddress(
      address: "Neo Soho Podomoro City Unit 3101 Jalan Letjen Parman Kav. 28, Grogol Petamburan Kec. Menteng",
      city: "Jakarta Barat",
      state: "Jakarta",
      country: "Indonesian"
    ),
    companyName: "ScaleOcean",
    companyWebsite: "www.scaleocean.com",
    rating: 3,
  ),
  Lead(
    id: 6,
    leadName: "PT Rajawali Indonesia",
    email: "raja0@example.com",
    phone: "08123456784",
    status: "Lost",
    name: Name(
      title: "Miss",
      name: "Melina Putri"
    ),
    jobPosition: "UI/UX Designer",
    address: LeadAddress(
      address: "Neo Soho Podomoro City Unit 3101 Jalan Letjen Parman Kav. 28, Grogol Petamburan Kec. Menteng",
      city: "Jakarta Barat",
      state: "Jakarta",
      country: "Indonesian"
    ),
    companyName: "ScaleOcean",
    companyWebsite: "www.scaleocean.com",
    rating: 2,
  ),
  Lead(
    id: 7,
    leadName: "PT Jaya Bangunan",
    email: "jaya0@example.com",
    phone: "08123456783",
    status: "Prospects",
    name: Name(
      title: "Miss",
      name: "Melina Putri"
    ),
    jobPosition: "UI/UX Designer",
    address: LeadAddress(
      address: "Neo Soho Podomoro City Unit 3101 Jalan Letjen Parman Kav. 28, Grogol Petamburan Kec. Menteng",
      city: "Jakarta Barat",
      state: "Jakarta",
      country: "Indonesian"
    ),
    companyName: "ScaleOcean",
    companyWebsite: "www.scaleocean.com",
    rating: 3,
  ),
  Lead(
    id: 8,
    leadName: "PT Sentosa Pondasi",
    email: "sentosa0@example.com",
    phone: "08123456782",
    status: "Prospects",
    name: Name(
      title: "Miss",
      name: "Melina Putri"
    ),
    jobPosition: "UI/UX Designer",
    address: LeadAddress(
      address: "Neo Soho Podomoro City Unit 3101 Jalan Letjen Parman Kav. 28, Grogol Petamburan Kec. Menteng",
      city: "Jakarta Barat",
      state: "Jakarta",
      country: "Indonesian"
    ),
    companyName: "ScaleOcean",
    companyWebsite: "www.scaleocean.com",
    rating: 1,
  ),
];

class Name {
  String title;
  String name;

  Name({
    required this.title,
    required this.name
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'name': name
    };
  }

  factory Name.fromMap(Map<String, dynamic> map) {
    return Name(
      title: map['title'] != null ? map['title'] as String : "",
      name: map['name'] != null ? map['name'] as String : ""
    );
  }

  String toJson() => json.encode(toMap());

  factory Name.fromJson(String source) => Name.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return "$title $name";
  }
}