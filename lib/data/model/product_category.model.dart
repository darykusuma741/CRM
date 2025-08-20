import 'package:crm/common/abstract/base_model.dart';
import 'package:crm/data/enum/transport_by.dart';

class ProductCategoryModel extends BaseModel<ProductCategoryModel> {
  int id;
  String name;
  String hsCode;
  String? description;
  TransportBy transportBy;

  ProductCategoryModel({
    required this.id,
    required this.name,
    required this.hsCode,
    this.description,
    required this.transportBy,
  });

  @override
  ProductCategoryModel copyWith({
    int? id,
    String? name,
    String? hsCode,
    String? description,
    TransportBy? transportBy,
  }) {
    return ProductCategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      hsCode: hsCode ?? this.hsCode,
      description: description ?? this.description,
      transportBy: transportBy ?? this.transportBy,
    );
  }
}
