import '../../../common/memory_local_data_storage.dart';
import '../lead_category.dart';

abstract class LeadsPagingDataType {}

class InitialLeadsPagingDataType extends LeadsPagingDataType {}

class NonInitialLeadsPagingDataType extends LeadsPagingDataType {}

class WithCategoryLeadsPagingDataType extends LeadsPagingDataType {
  LeadsCategory leadsCategory;

  WithCategoryLeadsPagingDataType({
    required this.leadsCategory
  });
}

class LeadsPagingDataParameter {
  int page;
  int itemPerPage;
  LeadsPagingDataType leadsPagingDataType;
  String search;
  MemoryLocalDataStorage memoryLocalDataStorage;

  LeadsPagingDataParameter({
    required this.page,
    this.itemPerPage = 15,
    required this.leadsPagingDataType,
    this.search = "",
    required this.memoryLocalDataStorage
  });
}