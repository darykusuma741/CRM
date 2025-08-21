import 'package:crm/common/abstract/base_model.dart';
import 'package:crm/data/enum/address_type.dart';
import 'package:crm/data/enum/title_type.dart';

class AdditionalAddressModel extends BaseModel<AdditionalAddressModel> {
  int id;
  TitleType title;
  AddressType addressType;
  String contactName;
  String? jobPosition;
  String? email;
  String phoneNumber;

  AdditionalAddressModel({
    required this.id,
    required this.title,
    required this.addressType,
    required this.contactName,
    this.jobPosition,
    this.email,
    required this.phoneNumber,
  });

  @override
  AdditionalAddressModel copyWith({
    int? id,
    TitleType? title,
    AddressType? addressType,
    String? contactName,
    String? jobPosition,
    String? email,
    String? phoneNumber,
  }) {
    return AdditionalAddressModel(
      id: id ?? this.id,
      title: title ?? this.title,
      addressType: addressType ?? this.addressType,
      contactName: contactName ?? this.contactName,
      jobPosition: jobPosition ?? this.jobPosition,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
