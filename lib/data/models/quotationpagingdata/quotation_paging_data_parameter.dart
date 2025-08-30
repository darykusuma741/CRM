import '../../../common/memory_local_data_storage.dart';
import '../quotation_category.dart';

abstract class QuotationPagingDataInputType {}

class AllQuotationPagingDataInputType extends QuotationPagingDataInputType {}

class BasedPipelineQuotationPagingDataInputType extends QuotationPagingDataInputType {
  String pipelineId;
  String pipelineName;

  BasedPipelineQuotationPagingDataInputType({
    required this.pipelineId,
    required this.pipelineName
  });
}

class BasedCustomerQuotationPagingDataInputType extends QuotationPagingDataInputType {
  String customerId;
  String customerName;

  BasedCustomerQuotationPagingDataInputType({
    required this.customerId,
    required this.customerName
  });
}

abstract class QuotationPagingDataType {}

class InitialQuotationPagingDataType extends QuotationPagingDataType {}

class NonInitialQuotationPagingDataType extends QuotationPagingDataType {}

class WithCategoryQuotationPagingDataType extends QuotationPagingDataType {
  QuotationCategory quotationCategory;

  WithCategoryQuotationPagingDataType({
    required this.quotationCategory
  });
}

class QuotationPagingDataParameter {
  int page;
  int dataCountPerPage;
  QuotationPagingDataType quotationPagingDataType;
  QuotationPagingDataInputType quotationPagingDataInputType;
  String search;
  MemoryLocalDataStorage memoryLocalDataStorage;

  QuotationPagingDataParameter({
    required this.page,
    this.dataCountPerPage = 15,
    required this.quotationPagingDataType,
    required this.quotationPagingDataInputType,
    this.search = "",
    required this.memoryLocalDataStorage
  });
}