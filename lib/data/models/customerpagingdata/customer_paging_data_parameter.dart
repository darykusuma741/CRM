import '../../../common/memory_local_data_storage.dart';
import '../customer_category.dart';

abstract class CustomerPagingDataType {}

class InitialCustomerPagingDataType extends CustomerPagingDataType {}

class NonInitialCustomerPagingDataType extends CustomerPagingDataType {}

class WithCategoryCustomerPagingDataType extends CustomerPagingDataType {
  CustomerCategory customerCategory;

  WithCategoryCustomerPagingDataType({
    required this.customerCategory
  });
}

enum CustomerType {
  all, individual, company
}

class CustomerPagingDataParameter {
  int page;
  int itemPerPage;
  CustomerPagingDataType customerPagingDataType;
  String search;
  MemoryLocalDataStorage memoryLocalDataStorage;

  CustomerPagingDataParameter({
    required this.page,
    this.itemPerPage = 15,
    required this.customerPagingDataType,
    this.search = "",
    required this.memoryLocalDataStorage
  });
}