import '../../../common/memory_local_data_storage.dart';
import '../leadspagingdata/leads_paging_data_parameter.dart';
import '../short_lost.dart';

abstract class LostPagingDataType {}

class InitialLostPagingDataType extends LostPagingDataType {}

class NonInitialLostPagingDataType extends LostPagingDataType {}

class LostPagingDataParameter {
  int page;
  int itemPerPage;
  LostPagingDataType lostPagingDataType;
  String search;
  MemoryLocalDataStorage memoryLocalDataStorage;
  ShortLostType shortLostType;

  LostPagingDataParameter({
    required this.page,
    this.itemPerPage = 15,
    required this.lostPagingDataType,
    this.search = "",
    required this.memoryLocalDataStorage,
    required this.shortLostType
  });
}