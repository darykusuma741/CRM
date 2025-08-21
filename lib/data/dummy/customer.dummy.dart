import 'dart:math';

import 'package:crm/data/enum/transport_by.dart';
import 'package:crm/data/model/customer.model.dart';

class CustomerDummy {
  static final List<CustomerModel> data = [
    CustomerModel(
      id: Random().nextInt(999999),
      customerType: CustomerType.personal,
      transportBy: TransportBy.ocean,
      productCategory: ['Electronics', 'Office Equipment'],
      detailType: CustomerDetailType.company,
      companyName: 'PT Nusantara Global Teknologi',
      phoneNumber: '082983756009',
      address: 'Jl. S. Parman, Soho Podomoro no 26, Jakarta Barat, DKI Jakarta, Indonesia 441142',
      nik: '3175091234560003',
      npwp: '12.345.678.9-012.345',
      email: 'halo@nusantaraglobaltech.co.id',
    ),
    CustomerModel(
      id: Random().nextInt(999999),
      customerType: CustomerType.personal,
      transportBy: TransportBy.ocean,
      productCategory: ['Electronics', 'Office Equipment'],
      detailType: CustomerDetailType.company,
      companyName: 'PT Aman Sentosa',
      phoneNumber: '082983756009',
      address: 'Jl. S. Parman, Soho Podomoro no 26, Jakarta Barat, DKI Jakarta, Indonesia 441142',
      nik: '3175091234560003',
      npwp: '12.345.678.9-012.345',
      email: 'admin@amansentosa.com',
    ),
    CustomerModel(
      id: Random().nextInt(999999),
      customerType: CustomerType.personal,
      transportBy: TransportBy.ocean,
      productCategory: ['Electronics', 'Office Equipment'],
      detailType: CustomerDetailType.individual,
      customerName: 'Takasya Namaya',
      phoneNumber: '082983756009',
      address: 'Jl. S. Parman, Soho Podomoro no 26, Jakarta Barat, DKI Jakarta, Indonesia 441142',
      nik: '3175091234560003',
      npwp: '12.345.678.9-012.345',
      email: 'takasya@amansentosa.com',
    ),
    CustomerModel(
      id: Random().nextInt(999999),
      customerType: CustomerType.personal,
      transportBy: TransportBy.ocean,
      productCategory: ['Electronics', 'Office Equipment'],
      detailType: CustomerDetailType.individual,
      customerName: 'Budi Setia Utomo',
      phoneNumber: '082983756009',
      address: 'Jl. S. Parman, Soho Podomoro no 26, Jakarta Barat, DKI Jakarta, Indonesia 441142',
      nik: '3175091234560003',
      npwp: '12.345.678.9-012.345',
      email: 'budiutomo@sinarutamajaya.com',
    ),
    CustomerModel(
      id: Random().nextInt(999999),
      customerType: CustomerType.personal,
      transportBy: TransportBy.ocean,
      productCategory: ['Electronics', 'Office Equipment'],
      detailType: CustomerDetailType.company,
      companyName: 'PT Sumber Alam Raya Manufaktur ',
      phoneNumber: '082983756009',
      address: 'Jl. S. Parman, Soho Podomoro no 26, Jakarta Barat, DKI Jakarta, Indonesia 441142',
      nik: '3175091234560003',
      npwp: '12.345.678.9-012.345',
      email: 'admin@sbrmanufacture.com',
    ),
  ];
}
