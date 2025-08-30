import '../short_quotation_product.dart';

class EditQuotationParameter {
  String id;
  String partnerId;
  String pipelineId;
  DateTime validityDate;
  String pricelistId;
  String paymentTermId;
  List<ShortQuotationProduct> shortQuotationProductList;

  EditQuotationParameter({
    required this.id,
    required this.partnerId,
    required this.pipelineId,
    required this.validityDate,
    required this.pricelistId,
    required this.paymentTermId,
    required this.shortQuotationProductList
  });
}