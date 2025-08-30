import 'package:crm/common/ext/response_wrapper_ext.dart';
import 'package:crm/common/ext/string_ext.dart';

import '../../common/responsewrapper/response_wrapper.dart';
import '../models/paging/paging_data.dart';

extension PagingDataMappingExt on ResponseWrapper {
  PagingData<T> mapFromResponseToPagingData<T>(List<T> Function(dynamic dataResponse) onMapToPagingData, {String? dataFieldName = "result"}) {
    if (response is List) {
      return PagingData<T>(
        page: 1,
        nextPage: null,
        data: onMapToPagingData(response)
      );
    }
    return PagingData<T>(
      page: ResponseWrapper(response["page"]).mapFromResponseToNonNullableInt(
        desiredValueIfNull: 1
      ),
      nextPage: ResponseWrapper(response["next_page"]).mapFromResponseToInt(),
      data: onMapToPagingData(response[dataFieldName.isNotEmptyString ? dataFieldName! : "data"])
    );
  }
}