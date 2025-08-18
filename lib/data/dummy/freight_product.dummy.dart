import 'dart:math';

import 'package:crm/data/model/freight_product.model.dart';

class FreightProductDummy {
  static final List<FreightProductModel> data = [
    FreightProductModel(
      id: Random().nextInt(999999),
      name: 'Office Chair Ergonomic 2025',
      type: FreightProductType.product,
      transportBy: FreightProductTrBy.ocean,
      productCategory: ['Navigation Equipment'],
      internalReference: 'DMGPS-OC-2025',
      branch: 'Surabaya',
      photo:
          'https://e7.pngegg.com/pngimages/695/1018/png-clipart-desktop-computer-computer-graphics-computer-monitor-computer-purple-computer-network-thumbnail.png',
    ),
    FreightProductModel(
      id: Random().nextInt(999999),
      name: 'Laptop ASUS ZenBook 14',
      type: FreightProductType.product,
      transportBy: FreightProductTrBy.ocean,
      productCategory: ['Navigation Equipment'],
      internalReference: 'DMGPS-OC-2025',
      branch: 'Depok',
    ),
    FreightProductModel(
      id: Random().nextInt(999999),
      name: 'Portable Scanner X-Scan Pro',
      type: FreightProductType.product,
      transportBy: FreightProductTrBy.air,
      productCategory: ['Navigation Equipment'],
      internalReference: 'DMGPS-OC-2025',
      branch: 'Jakarta',
    ),
    FreightProductModel(
      id: Random().nextInt(999999),
      name: 'Smart LED Display Panel',
      type: FreightProductType.product,
      transportBy: FreightProductTrBy.air,
      productCategory: ['Navigation Equipment'],
      internalReference: 'DMGPS-OC-2025',
      branch: 'Semarang',
    ),
    FreightProductModel(
      id: Random().nextInt(999999),
      name: 'Freight Insurance Coverage',
      type: FreightProductType.service,
      transportBy: FreightProductTrBy.air,
      productCategory: ['Navigation Equipment'],
      internalReference: 'DMGPS-OC-2025',
      branch: 'Bali',
    ),
  ];
}
