import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../components/error_widget.dart';
import '../constants/colors_name.dart';
import '../error_provider/error_provider.dart';
import '../load_data_result/default_load_data_result_widget/prompt_indicator.dart';

class WidgetHelper {
  static Widget coveredByShimmer({
    bool hasShimmer = true,
    required Widget Function(HasShimmerParameter) child
  }) {
    HasShimmerParameter parameter = HasShimmerParameter(
      hasShimmer: hasShimmer,
      backgroundColor: hasShimmer ? ColorsName.grayLight : null
    );
    return hasShimmer ? Shimmer.fromColors(
      baseColor: ColorsName.grayDark,
      highlightColor: ColorsName.grayLight,
      child: child(parameter)
    ) : child(parameter);
  }

  static Widget buildPromptIndicator({
    required BuildContext context,
    Image? image,
    double? imageWidth,
    double? imageHeight,
    String? promptTitleText,
    String? promptText,
    String? buttonText,
    VoidCallback? onPressed,
    required PromptIndicatorType promptIndicatorType
  }) {
    return PromptIndicator(
      image: image,
      imageWidth: imageWidth,
      imageHeight: imageHeight,
      promptTitleText: promptTitleText,
      promptText: promptText,
      buttonText: buttonText ?? "OK",
      onPressed: onPressed,
      promptIndicatorType: promptIndicatorType
    );
  }

  static Widget buildFailedPromptIndicatorFromErrorProvider({
    required BuildContext context,
    required ErrorProvider errorProvider,
    required dynamic e,
    double? imageWidth,
    double? imageHeight,
    String? buttonText,
    VoidCallback? onPressed,
    PromptIndicatorType promptIndicatorType = PromptIndicatorType.vertical
  }) {
    return ErrorIndicatorWidget(
      errorProvider: errorProvider,
      e: e
    );
    // ErrorProviderResult? errorProviderResult = errorProvider.onGetErrorProviderResult(e);
    // return buildPromptIndicator(
    //   imageWidth: imageWidth,
    //   imageHeight: imageHeight,
    //   context: context,
    //   image: () {
    //     if (errorProviderResult != null) {
    //       var imageAssetUrl = errorProviderResult.imageAssetUrl;
    //       if (imageAssetUrl == null) {
    //         return null;
    //       }
    //       if (imageAssetUrl is AssetErrorProviderResultImageUrl) {
    //         String imageAssetUrlValue = imageAssetUrl.imageAssetUrl;
    //         return Image.asset(imageAssetUrlValue.isEmpty ? const LocalImages().failedImage : imageAssetUrlValue);
    //       } else if (imageAssetUrl is NetworkErrorProviderResultImageUrl) {
    //         String imageNetworkUrlValue = imageAssetUrl.imageNetworkUrl;
    //         return Image.network(imageNetworkUrlValue.isEmpty ? const LocalImages().failedImage : imageNetworkUrlValue);
    //       }
    //     }
    //     return null;
    //   }(),
    //   promptTitleText: errorProviderResult?.title,
    //   promptText: errorProviderResult?.message,
    //   buttonText: buttonText ?? errorProviderResult?.buttonText,
    //   onPressed: onPressed ?? () {
    //     if (errorProviderResult != null) {
    //       var errorProviderResultButtonAction = errorProviderResult.errorProviderResultButtonAction;
    //       if (errorProviderResultButtonAction is DefaultErrorProviderResultButtonAction) {
    //         if (errorProviderResultButtonAction.onTap != null) {
    //           return () => errorProviderResultButtonAction.onTap!(context);
    //         }
    //       }
    //     }
    //     return null;
    //   }(),
    //   promptIndicatorType: promptIndicatorType
    // );
  }
}

class HasShimmerParameter {
  bool hasShimmer;
  Color? backgroundColor;

  HasShimmerParameter({
    required this.hasShimmer,
    required this.backgroundColor
  });
}