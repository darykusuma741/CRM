import 'dart:math';

import 'package:crm/data/dummy/title.dummy.dart';
import 'package:crm/data/enum/address_type.dart';
import 'package:crm/data/enum/customer_detail_type.dart';
import 'package:crm/data/enum/customer_type.dart';
import 'package:crm/data/enum/transport_by.dart';
import 'package:crm/data/model/additional_address.model.dart';
import 'package:crm/data/model/customer.model.dart';
import 'package:crm/data/model/marking.model.dart';

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
      additionalAddress: [
        AdditionalAddressModel(
          id: Random().nextInt(999999),
          addressType: AddressType.contact,
          title: TitleDummy.data.first,
          contactName: 'Dary Kusuma',
          phoneNumber: '082398283892',
        ),
      ],
      markings: [
        MarkingModel(
          id: Random().nextInt(999999),
          markingName: 'SkySwift-22',
          transportBy: TransportBy.air,
        ),
      ],
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
      additionalAddress: [],
      markings: [],
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
      additionalAddress: [],
      markings: [],
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
      additionalAddress: [],
      markings: [],
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
      additionalAddress: [],
      markings: [],
      email: 'admin@sbrmanufacture.com',
    ),
  ];
}
