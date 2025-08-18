import 'package:crm/common/abstract/base_model.dart';

class ProductServiceModel extends BaseModel<ProductServiceModel> {
  int id;
  String title;
  int price;

  ProductServiceModel({
    required this.id,
    required this.title,
    required this.price,
  });

  @override
  ProductServiceModel copyWith({
    int? id,
    String? title,
    int? price,
  }) {
    return ProductServiceModel(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
    );
  }
}
