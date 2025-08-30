// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Customer {
  int? id;
  String name;
  String jobPosition;
  String companyName;
  String email;
  String phone;
  String status;
  String city;
  String country;

  Customer({
    this.id,
    required this.name,
    required this.jobPosition,
    required this.companyName,
    required this.email,
    required this.phone,
    required this.status,
    required this.city,
    required this.country,
  });

  Customer copyWith({
    int? id,
    String? name,
    String? jobPosition,
    String? companyName,
    String? email,
    String? phone,
    String? status,
    String? city,
    String? country,
  }) {
    return Customer(
      id: id ?? this.id,
      name: name ?? this.name,
      jobPosition: jobPosition ?? this.jobPosition,
      companyName: companyName ?? this.companyName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      status: status ?? this.status,
      city: city ?? this.city,
      country: country ?? this.country,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'job_position': jobPosition,
      'company_name': companyName,
      'email': email,
      'phone': phone,
      'status': status,
      'city': city,
      'country': country,
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      jobPosition: map['job_position'] as String,
      companyName: map['company_name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      status: map['status'] as String,
      city: map['city'] as String,
      country: map['country'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Customer.fromJson(String source) =>
      Customer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Customer(id: $id, name: $name, job_position: $jobPosition, email: $email, phone: $phone, status: $status, city: $city, country: $country)';
  }

  @override
  bool operator ==(covariant Customer other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.phone == phone &&
        other.status == status &&
        other.city == city &&
        other.country == country;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        status.hashCode ^
        city.hashCode ^
        country.hashCode;
  }
}

List<Customer> getDummyCustomers() {
  return List.generate(
    20,
    (index) => Customer(
      id: index + 1,
      name: 'Name $index',
      jobPosition: "Marketing at Company$index",
      companyName: 'Company$index',
      email: 'customer$index@example.com',
      phone: '081234567$index',
      status: index % 2 == 0 ? 'Company' : 'Individual',
      city: 'Jakarta',
      country: 'Indonesia',
    ),
  );
}
