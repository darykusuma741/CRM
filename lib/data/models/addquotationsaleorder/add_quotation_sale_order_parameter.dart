import '../short_quotation_product.dart';

class AddQuotationSaleOrderParameter {
  String quotationId;
  ShortQuotationProduct shortQuotationProduct;

  AddQuotationSaleOrderParameter({
    required this.quotationId,
    required this.shortQuotationProduct
  });
}