import '../../../common/load_data_result/load_data_result.dart';
import 'paging_data.dart';

class PagingDataState<T> {
  int currentPage;
  LoadDataResult<PagingData<T>> pagingDataLoadDataResult;

  PagingDataState({
    required this.currentPage,
    required this.pagingDataLoadDataResult,
  });
}