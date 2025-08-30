import 'additional_label_badge_item_value.dart';
import 'address_data.dart';

class ShortCustomerAdditionalAddress with AddressData implements AdditionalLabelBadgeItemValue {
  String id;
  String contactName;
  @override
  String street;
  @override
  String street2;
  @override
  String city;
  @override
  String state;
  String stateId;
  @override
  String zip;
  @override
  String country;
  String countryId;
  String email;
  String phoneNumber;
  String whatsappNumber;
  String notes;
  String type;

  @override
  String get backgroundColorHex => throw UnimplementedError();

  @override
  String get name => throw UnimplementedError();

  @override
  String get textColorHex => throw UnimplementedError();

  ShortCustomerAdditionalAddress({
    required this.id,
    required this.contactName,
    required this.street,
    required this.street2,
    required this.city,
    required this.state,
    required this.stateId,
    required this.zip,
    required this.country,
    required this.countryId,
    required this.email,
    required this.phoneNumber,
    required this.whatsappNumber,
    required this.notes,
    required this.type
  });
}