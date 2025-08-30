import 'quotation_label_badge_item_value.dart';

class ShortQuotation implements QuotationLabelBadgeItemValue {
  String id;
  String code;
  String name;
  @override
  String status;
  @override
  String statusName;
  DateTime? dateOrderDate;
  String pricelist;
  double pricelistValue;

  ShortQuotation({
    required this.id,
    required this.code,
    required this.name,
    required this.status,
    required this.statusName,
    required this.dateOrderDate,
    required this.pricelist,
    required this.pricelistValue
  });

  @override
  String get backgroundColorHex => "";

  @override
  String get textColorHex => "";
}