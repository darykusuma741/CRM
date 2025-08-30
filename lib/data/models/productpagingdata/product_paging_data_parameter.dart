import '../../../common/memory_local_data_storage.dart';

abstract class ActivityCalendarPagingDataType {}

class InitialProductPagingDataType extends ActivityCalendarPagingDataType {}

class NonInitialProductPagingDataType extends ActivityCalendarPagingDataType {}

class ProductPagingDataParameter {
  int page;
  int itemPerPage;
  ActivityCalendarPagingDataType productPagingDataType;
  String search;
  MemoryLocalDataStorage memoryLocalDataStorage;

  ProductPagingDataParameter({
    required this.page,
    this.itemPerPage = 15,
    required this.productPagingDataType,
    this.search = "",
    required this.memoryLocalDataStorage
  });
}