import 'detail_amount_quotation_product_content.dart';

class DetailAmountQuotationProductResponse {
  List<DetailAmountQuotationProductContent> descriptionDetailAmountQuotationProductContentList;
  List<DetailAmountQuotationProductContent> summaryDetailAmountQuotationProductContentList;

  DetailAmountQuotationProductResponse({
    required this.descriptionDetailAmountQuotationProductContentList,
    required this.summaryDetailAmountQuotationProductContentList
  });
}