import 'package:crm/common/abstract/base_model.dart';

class FreightProductModel extends BaseModel<FreightProductModel> {
  int id;
  String name;
  String? branch;
  String? internalReference;
  FreightProductType type;
  FreightProductTrBy transportBy;
  List<String> productCategory;
  String? photo;

  FreightProductModel({
    required this.id,
    required this.name,
    this.branch,
    this.internalReference,
    required this.type,
    required this.transportBy,
    required this.productCategory,
    this.photo,
  });

  @override
  FreightProductModel copyWith({
    int? id,
    String? name,
    String? branch,
    String? internalReference,
    FreightProductType? type,
    FreightProductTrBy? transportBy,
    List<String>? productCategory,
    String? photo,
  }) {
    return FreightProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      branch: branch ?? this.branch,
      internalReference: internalReference ?? this.internalReference,
      type: type ?? this.type,
      transportBy: transportBy ?? this.transportBy,
      productCategory: productCategory ?? this.productCategory,
      photo: photo ?? this.photo,
    );
  }
}

enum FreightProductType { product, service }

enum FreightProductTrBy { air, ocean, all }

extension FreightProductTrByExtension on FreightProductTrBy {
  String toShortString() {
    switch (this) {
      case FreightProductTrBy.air:
        return 'Air';
      case FreightProductTrBy.ocean:
        return 'Ocean';
      case FreightProductTrBy.all:
        return 'Air and Ocean';
    }
  }
}

extension FreightProductTypeExtension on FreightProductType {
  String toShortString() {
    switch (this) {
      case FreightProductType.product:
        return 'Product';
      case FreightProductType.service:
        return 'Service';
    }
  }
}
