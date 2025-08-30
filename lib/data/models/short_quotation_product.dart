class ShortQuotationProduct {
  String id;
  String productId;
  String productName;
  int qty;
  String qtyUnit;
  double unitPrice;
  double totalPrice;
  String description;
  double discount;
  String productPackagingId;
  String productPackagingName;
  String taxId;
  String taxName;

  ShortQuotationProduct({
    required this.id,
    required this.productId,
    required this.productName,
    required this.qty,
    required this.qtyUnit,
    required this.unitPrice,
    required this.totalPrice,
    required this.description,
    required this.discount,
    required this.productPackagingId,
    required this.productPackagingName,
    required this.taxId,
    required this.taxName
  });
}