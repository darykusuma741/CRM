import 'dart:math';

import 'package:crm/data/model/product_service.model.dart';

class ProductServiceDummy {
  static List<ProductServiceModel> data = [
    ProductServiceModel(
      id: Random().nextInt(999999),
      price: 7999000,
      title: 'Smartphone X200 Ultra Edition 128GB Dual Camera',
    ),
    ProductServiceModel(
      id: Random().nextInt(999999),
      price: 565000,
      title: 'Children’s Puzzle Set',
    ),
    ProductServiceModel(
      id: Random().nextInt(999999),
      price: 1125000,
      title: 'SprintMax Lightweight Running Shoes for Training',
    ),
    ProductServiceModel(
      id: Random().nextInt(999999),
      price: 2390000,
      title: 'Scandinavian Solid Oak Wooden Coffee Table',
    ),
    ProductServiceModel(
      id: Random().nextInt(999999),
      price: 980000,
      title: 'Running Shoes SprintMax',
    ),
  ];
}
