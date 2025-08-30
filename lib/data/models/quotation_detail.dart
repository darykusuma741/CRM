class QuotationDetail {
  String id;
  String code;
  String status;
  String pipelineId;
  String customerId;
  String customerName;
  String invoiceAddress;
  String deliveryAddress;
  String pricelistId;
  String pricelist;
  DateTime? expirationDate;
  String paymentTermsId;
  String paymentTerms;

  QuotationDetail({
    required this.id,
    required this.code,
    required this.status,
    required this.pipelineId,
    required this.customerId,
    required this.customerName,
    required this.invoiceAddress,
    required this.deliveryAddress,
    required this.pricelistId,
    required this.pricelist,
    required this.expirationDate,
    required this.paymentTermsId,
    required this.paymentTerms
  });
}