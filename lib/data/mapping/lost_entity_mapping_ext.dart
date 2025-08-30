import 'package:crm/common/ext/response_wrapper_ext.dart';
import 'package:crm/data/mapping/paging_mapping_ext.dart';

import '../../common/helper/date_helper.dart';
import '../../common/responsewrapper/response_wrapper.dart';
import '../models/lostpagingdata/lost_paging_data_response.dart';
import '../models/short_lost.dart';

extension LostEntityMappingExt on ResponseWrapper {
  LostPagingDataResponse mapFromResponseToLostPagingDataResponse(ShortLostType shortLostType) {
    return LostPagingDataResponse(
      lostPagingData: ResponseWrapper(response).mapFromResponseToPagingData<ShortLost>(
        (dataResponse) => ResponseWrapper(dataResponse).mapFromResponseToList(
          (value) => ResponseWrapper(value).mapFromResponseToShortLost(shortLostType)
        ),
        dataFieldName: "result"
      )
    );
  }

  ShortLost mapFromResponseToShortLost(ShortLostType shortLostType) {
    var lostReasonResponseWrapper = ResponseWrapper(response["lost_reason_id"]);
    return ShortLost(
      ownerId: ResponseWrapper(response["id"]).mapFromResponseToNonNullableString(),
      name: ResponseWrapper(response["name"]).mapFromResponseToNonNullableString(),
      priority: ResponseWrapper(response["priority"]).mapFromResponseToNonNullableInt(),
      companyName: ResponseWrapper(response["partner_name"]).mapFromResponseToNonNullableString(),
      contactName: ResponseWrapper(response["contact_name"]).mapFromResponseToNonNullableString(),
      lostReasonId: lostReasonResponseWrapper.getArrayData(0).mapFromResponseToNonNullableString(),
      lostReasonName: lostReasonResponseWrapper.getArrayData(1).mapFromResponseToNonNullableString(),
      createDate: ResponseWrapper(response["create_date"]).mapFromResponseToDateTime(
        dateFormat: DateHelper.standardDateFormat,
        convertIntoLocalTime: false
      ),
      shortLostType: shortLostType
    );
  }
}