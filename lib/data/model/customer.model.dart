import 'package:crm/common/abstract/base_model.dart';
import 'package:crm/data/enum/transport_by.dart';
import 'package:crm/data/model/additional_address.model.dart';

class CustomerModel extends BaseModel<CustomerModel> {
  int id;
  String? companyName;
  String? customerName;
  String? phoneNumber;
  String? email;
  String? address;
  String? nik;
  String? npwp;
  CustomerType customerType;
  TransportBy transportBy;
  List<String> productCategory;
  CustomerDetailType detailType;
  List<AdditionalAddressModel> additionalAddress;

  CustomerModel({
    required this.id,
    this.companyName,
    this.customerName,
    this.phoneNumber,
    this.email,
    this.address,
    this.nik,
    this.npwp,
    required this.customerType,
    required this.transportBy,
    required this.productCategory,
    required this.detailType,
    required this.additionalAddress,
  });

  @override
  CustomerModel copyWith({
    int? id,
    String? companyName,
    String? customerName,
    String? phoneNumber,
    String? email,
    String? address,
    String? nik,
    String? npwp,
    CustomerType? customerType,
    TransportBy? transportBy,
    List<String>? productCategory,
    CustomerDetailType? detailType,
    List<AdditionalAddressModel>? additionalAddress,
  }) {
    return CustomerModel(
      id: id ?? this.id,
      companyName: companyName ?? this.companyName,
      customerName: customerName ?? this.customerName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      address: address ?? this.address,
      nik: nik ?? this.nik,
      npwp: npwp ?? this.npwp,
      customerType: customerType ?? this.customerType,
      transportBy: transportBy ?? this.transportBy,
      productCategory: productCategory ?? this.productCategory,
      detailType: detailType ?? this.detailType,
      additionalAddress: additionalAddress ?? this.additionalAddress,
    );
  }
}

enum CustomerType { personal, broker }

enum CustomerDetailType { company, individual }

extension FreightProductTypeExtension on CustomerDetailType {
  String toShortString() {
    switch (this) {
      case CustomerDetailType.company:
        return 'Company';
      case CustomerDetailType.individual:
        return 'Individual';
    }
  }

  bool get isCompany => this == CustomerDetailType.company;
  bool get isIndividual => this == CustomerDetailType.individual;
}

extension CustomerTypeExtension on CustomerType {
  String toShortString() {
    switch (this) {
      case CustomerType.broker:
        return 'Broker';
      case CustomerType.personal:
        return 'Personal';
    }
  }

  bool get isBroker => this == CustomerType.broker;
  bool get isPersonal => this == CustomerType.personal;
}
