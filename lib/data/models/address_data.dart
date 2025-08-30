import 'package:crm/common/ext/string_ext.dart';

mixin AddressData {
  String get street;
  String get street2;
  String get city;
  String get zip;
  String get state;
  String get country;

  String get address {
    String result = "";
    void addResult(String value) {
      if (value.isEmptyString) {
        return;
      }
      result += "${result.isNotEmptyString ? ", " : ""}$value";
    }
    addResult(street);
    addResult(street2);
    addResult(city);
    addResult(state);
    addResult(zip);
    addResult(country);
    return result;
  }
}