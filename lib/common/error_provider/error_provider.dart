import 'package:flutter/material.dart';

abstract class ErrorProvider {
  ErrorProviderResult? onGetErrorProviderResult(dynamic e);
}

class ErrorProviderResult {
  String title;
  String message;
  ErrorProviderResultImageUrl? imageAssetUrl;
  double? imageAssetWidth;
  double? imageAssetHeight;
  String? buttonText;
  ErrorProviderResultButtonAction? errorProviderResultButtonAction;

  ErrorProviderResult({
    this.title = "(No Title)",
    this.message = "(No Message)",
    this.imageAssetUrl,
    this.imageAssetWidth,
    this.imageAssetHeight,
    this.buttonText,
    this.errorProviderResultButtonAction
  });
}

abstract class ErrorProviderResultImageUrl {}

class AssetErrorProviderResultImageUrl extends ErrorProviderResultImageUrl {
  String imageAssetUrl;

  AssetErrorProviderResultImageUrl({
    required this.imageAssetUrl
  });
}

class NetworkErrorProviderResultImageUrl extends ErrorProviderResultImageUrl {
  String imageNetworkUrl;

  NetworkErrorProviderResultImageUrl({
    required this.imageNetworkUrl
  });
}

abstract class ErrorProviderResultButtonAction {
  String? errorActionText;

  ErrorProviderResultButtonAction({
    required this.errorActionText
  });
}

class DeeplinkErrorProviderResultButtonAction extends ErrorProviderResultButtonAction {
  String deeplinkUrl;

  DeeplinkErrorProviderResultButtonAction({
    required this.deeplinkUrl,
    super.errorActionText
  });
}

class DefaultErrorProviderResultButtonAction extends ErrorProviderResultButtonAction {
  void Function(BuildContext)? onTap;

  DefaultErrorProviderResultButtonAction({
    required this.onTap,
    super.errorActionText
  });
}