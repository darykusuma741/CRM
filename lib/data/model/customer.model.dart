import 'package:crm/common/abstract/base_model.dart';
import 'package:crm/data/enum/customer_detail_type.dart';
import 'package:crm/data/enum/customer_type.dart';
import 'package:crm/data/enum/transport_by.dart';
import 'package:crm/data/model/additional_address.model.dart';
import 'package:crm/data/model/marking.model.dart';

class CustomerModel extends BaseModel<CustomerModel> {
  int id;
  String? title;
  String? city;
  String? companyName;
  String? customerName;
  String? phoneNumber;
  String? email;
  String? address;
  String? nik;
  String? npwp;
  String? state;
  String? country;
  String? streetAddress;
  String? postalCode;
  String? taxId;
  CustomerType customerType;
  TransportBy transportBy;
  List<String> productCategory;
  CustomerDetailType detailType;
  List<AdditionalAddressModel> additionalAddress;
  List<MarkingModel> markings;

  CustomerModel({
    required this.id,
    this.title,
    this.city,
    this.companyName,
    this.customerName,
    this.phoneNumber,
    this.email,
    this.address,
    this.nik,
    this.npwp,
    this.state,
    this.country,
    this.streetAddress,
    this.postalCode,
    this.taxId,
    required this.customerType,
    required this.transportBy,
    required this.productCategory,
    required this.detailType,
    required this.additionalAddress,
    required this.markings,
  });

  @override
  CustomerModel copyWith({
    int? id,
    String? title,
    String? city,
    String? companyName,
    String? customerName,
    String? phoneNumber,
    String? email,
    String? address,
    String? nik,
    String? npwp,
    String? state,
    String? country,
    String? streetAddress,
    String? postalCode,
    String? taxId,
    CustomerType? customerType,
    TransportBy? transportBy,
    List<String>? productCategory,
    CustomerDetailType? detailType,
    List<AdditionalAddressModel>? additionalAddress,
    List<MarkingModel>? markings,
  }) {
    return CustomerModel(
      id: id ?? this.id,
      title: title ?? this.title,
      city: city ?? this.city,
      companyName: companyName ?? this.companyName,
      customerName: customerName ?? this.customerName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      address: address ?? this.address,
      nik: nik ?? this.nik,
      npwp: npwp ?? this.npwp,
      state: state ?? this.state,
      country: country ?? this.country,
      streetAddress: streetAddress ?? this.streetAddress,
      postalCode: postalCode ?? this.postalCode,
      taxId: taxId ?? this.taxId,
      customerType: customerType ?? this.customerType,
      transportBy: transportBy ?? this.transportBy,
      productCategory: productCategory ?? this.productCategory,
      detailType: detailType ?? this.detailType,
      additionalAddress: additionalAddress ?? this.additionalAddress,
      markings: markings ?? this.markings,
    );
  }
}
