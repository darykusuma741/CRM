import '../paging/paging_data.dart';
import '../short_lost.dart';

class LostPagingDataResponse {
  PagingData<ShortLost> lostPagingData;

  LostPagingDataResponse({
    required this.lostPagingData
  });
}