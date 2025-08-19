import 'package:crm/common/abstract/base_model.dart';

class ProductCategoryModel extends BaseModel<ProductCategoryModel> {
  int id;
  String name;
  String hsCode;
  String? description;
  ProductCategoryTrBy transportBy;

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
    ProductCategoryTrBy? transportBy,
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

enum ProductCategoryTrBy { air, ocean, all }

extension ProductCategoryTrByExtension on ProductCategoryTrBy {
  String toShortString() {
    switch (this) {
      case ProductCategoryTrBy.air:
        return 'Air';
      case ProductCategoryTrBy.ocean:
        return 'Ocean';
      case ProductCategoryTrBy.all:
        return 'Air and Ocean';
    }
  }
}
