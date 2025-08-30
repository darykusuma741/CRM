class Product {
  String id;
  String name;
  String description;
  double quantity;
  String unitOfMeasurement;
  String unitPrice;
  double discount;
  double taxes;
  String packaging;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.quantity,
    required this.unitOfMeasurement,
    required this.unitPrice,
    required this.discount,
    required this.taxes,
    required this.packaging
  });
}