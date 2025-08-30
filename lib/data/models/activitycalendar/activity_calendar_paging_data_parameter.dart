import '../../../common/memory_local_data_storage.dart';

abstract class ActivityCalendarPagingDataType {}

class InitialActivityCalendarPagingDataType extends ActivityCalendarPagingDataType {}

class NonInitialActivityCalendarPagingDataType extends ActivityCalendarPagingDataType {}

class ActivityCalendarPagingDataParameter {
  DateTime? dateTimeFrom;
  DateTime? dateTimeTo;
  int page;
  int dataCountPerPage;
  ActivityCalendarPagingDataType activityCalendarPagingDataType;
  String search;
  MemoryLocalDataStorage memoryLocalDataStorage;

  ActivityCalendarPagingDataParameter({
    required this.dateTimeFrom,
    required this.dateTimeTo,
    required this.page,
    this.dataCountPerPage = 15,
    required this.activityCalendarPagingDataType,
    required this.search,
    required this.memoryLocalDataStorage
  });
}