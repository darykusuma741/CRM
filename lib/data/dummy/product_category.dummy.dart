import 'dart:math';

import 'package:crm/data/model/product_category.model.dart';

class ProductCategoryDummy {
  static final List<ProductCategoryModel> data = [
    ProductCategoryModel(
      id: Random().nextInt(999999),
      name: 'Electronics',
      hsCode: '9503.00',
      transportBy: ProductCategoryTrBy.ocean,
    ),
    ProductCategoryModel(
      id: Random().nextInt(999999),
      name: 'Furniture',
      hsCode: '9503.00',
      transportBy: ProductCategoryTrBy.ocean,
    ),
    ProductCategoryModel(
      id: Random().nextInt(999999),
      name: 'Office Equipment',
      hsCode: '9503.00',
      transportBy: ProductCategoryTrBy.air,
    ),
    ProductCategoryModel(
      id: Random().nextInt(999999),
      name: 'Automotive Parts',
      hsCode: '9503.00',
      transportBy: ProductCategoryTrBy.air,
    ),
    ProductCategoryModel(
      id: Random().nextInt(999999),
      name: 'Pharmaceuticals',
      hsCode: '9503.00',
      transportBy: ProductCategoryTrBy.air,
    ),
  ];
}
