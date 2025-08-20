import 'dart:math';

import 'package:crm/data/enum/transport_by.dart';
import 'package:crm/data/model/customer.model.dart';

class CustomerDummy {
  static final List<CustomerModel> data = [
    CustomerModel(
      id: Random().nextInt(999999),
      customerType: CustomerType.personal,
      transportBy: TransportBy.ocean,
      productCategory: [],
      detailType: CustomerDetailType.company,
      companyName: 'PT Nusantara Global Teknologi',
      email: 'halo@nusantaraglobaltech.co.id',
    ),
    CustomerModel(
      id: Random().nextInt(999999),
      customerType: CustomerType.personal,
      transportBy: TransportBy.ocean,
      productCategory: [],
      detailType: CustomerDetailType.company,
      companyName: 'PT Aman Sentosa',
      email: 'admin@amansentosa.com',
    ),
    CustomerModel(
      id: Random().nextInt(999999),
      customerType: CustomerType.personal,
      transportBy: TransportBy.ocean,
      productCategory: [],
      detailType: CustomerDetailType.individual,
      companyName: 'Takasya Namaya',
      email: 'takasya@amansentosa.com',
    ),
    CustomerModel(
      id: Random().nextInt(999999),
      customerType: CustomerType.personal,
      transportBy: TransportBy.ocean,
      productCategory: [],
      detailType: CustomerDetailType.individual,
      companyName: 'Budi Setia Utomo',
      email: 'budiutomo@sinarutamajaya.com',
    ),
    CustomerModel(
      id: Random().nextInt(999999),
      customerType: CustomerType.personal,
      transportBy: TransportBy.ocean,
      productCategory: [],
      detailType: CustomerDetailType.company,
      companyName: 'PT Sumber Alam Raya Manufaktur ',
      email: 'admin@sbrmanufacture.com',
    ),
  ];
}
