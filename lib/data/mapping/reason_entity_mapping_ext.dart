import 'package:crm/common/ext/response_wrapper_ext.dart';

import '../../common/responsewrapper/response_wrapper.dart';
import '../models/lost_reason.dart';
import '../models/lostreasonlist/lost_reason_list_response.dart';

extension ReasonEntityMappingExt on ResponseWrapper {
  LostReasonListResponse mapFromResponseToReasonListResponse() {
    return LostReasonListResponse(
      lostReasonList: () {
        var resultLeadCategoryList = ResponseWrapper(response["CrmLostReason"]).mapFromResponseToList(
          (leadsCategoryResponse) => ResponseWrapper(leadsCategoryResponse).mapFromResponseToLostReason()
        );
        return resultLeadCategoryList;
      }()
    );
  }

  LostReason mapFromResponseToLostReason() {
    return LostReason(
      id: ResponseWrapper(response["id"]).mapFromResponseToNonNullableString(),
      name: ResponseWrapper(response["name"]).mapFromResponseToNonNullableString(),
    );
  }
}