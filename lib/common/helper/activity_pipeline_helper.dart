import '../constants/image_assets.dart';

class ActivityPipelineHelper {
  static String convertFromActivityPipelineActionToSvgImageUrl(String activityPipelineAction) {
    var lowerCaseActivityPipelineAction = activityPipelineAction.toLowerCase();
    if (lowerCaseActivityPipelineAction == "upload_file") {
      return ImageAssets.iconSvgMeeting;
    } else if (lowerCaseActivityPipelineAction == "phonecall") {
      return ImageAssets.iconSvgPhone;
    } else if (lowerCaseActivityPipelineAction == "meeting") {
      return ImageAssets.iconSvgMeeting;
    } else {
      return ImageAssets.iconSvgdoNotDisturbOn;
    }
  }
}