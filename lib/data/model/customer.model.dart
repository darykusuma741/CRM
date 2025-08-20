import 'package:crm/common/abstract/base_model.dart';
import 'package:crm/data/enum/transport_by.dart';

class CustomerModel extends BaseModel<CustomerModel> {
  int id;
  String? companyName;
  String? customerName;
  String? email;
  CustomerType customerType;
  TransportBy transportBy;
  List<String> productCategory;
  CustomerDetailType detailType;

  CustomerModel({
    required this.id,
    this.companyName,
    this.customerName,
    this.email,
    required this.customerType,
    required this.transportBy,
    required this.productCategory,
    required this.detailType,
  });

  @override
  CustomerModel copyWith({
    int? id,
    String? companyName,
    String? customerName,
    String? email,
    CustomerType? customerType,
    TransportBy? transportBy,
    List<String>? productCategory,
    CustomerDetailType? detailType,
  }) {
    return CustomerModel(
      id: id ?? this.id,
      companyName: companyName ?? this.companyName,
      customerName: customerName ?? this.customerName,
      email: email ?? this.email,
      customerType: customerType ?? this.customerType,
      transportBy: transportBy ?? this.transportBy,
      productCategory: productCategory ?? this.productCategory,
      detailType: detailType ?? this.detailType,
    );
  }
}

enum CustomerType { personal, broker }

enum CustomerDetailType { company, individual }
