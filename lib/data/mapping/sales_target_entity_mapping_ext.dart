import 'package:crm/common/ext/response_wrapper_ext.dart';

import '../../common/helper/date_helper.dart';
import '../../common/responsewrapper/response_wrapper.dart';
import '../models/achievementpercentageandtargetpoint/achievement_percentage_and_target_point_response.dart';
import '../models/achievementpercentageandtargetpoint/achievement_sales_target.dart';

extension SalesTargetEntityMappingExt on ResponseWrapper {
  AchievementPercentageAndTargetPointResponse mapFromResponseToAchievementPercentageAndTargetPointResponse() {
    return AchievementPercentageAndTargetPointResponse(
      achievementSalesTargetList: () {
        var salesTargetResponseWrapper = ResponseWrapper(response).mapFromResponseToDataResponseWrapper(
          dataFieldName: "SalesTarget"
        );
        var achievementSalesTargetList = salesTargetResponseWrapper.mapFromResponseToList(
          (responseData) => ResponseWrapper(responseData).mapFromResponseToAchievementSalesTarget()
        );
        return achievementSalesTargetList;
      }()
    );
  }

  AchievementSalesTarget mapFromResponseToAchievementSalesTarget() {
    return AchievementSalesTarget(
      id: ResponseWrapper(response["id"]).mapFromResponseToNonNullableString(),
      achievementPercentage: ResponseWrapper(response["achievement_percentage"]).mapFromResponseToNonNullableDouble(),
      targetPoint: ResponseWrapper(response["target_point"]).mapFromResponseToNonNullableString(),
      targetAmount: ResponseWrapper(response["target_amt"]).mapFromResponseToNonNullableDouble(),
      state: ResponseWrapper(response["state"]).mapFromResponseToNonNullableString(),
      startDate: ResponseWrapper(response["start_date"]).mapFromResponseToDateTime(
        dateFormat: DateHelper.standardDateFormat3,
        convertIntoLocalTime: false
      ),
      endDate: ResponseWrapper(response["end_date"]).mapFromResponseToDateTime(
        dateFormat: DateHelper.standardDateFormat3,
        convertIntoLocalTime: false
      )
    );
  }
}