import 'package:crm/common/ext/string_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum PromptIndicatorType {
  horizontal, vertical
}

class PromptIndicator extends StatelessWidget {
  final Image? image;
  final double? imageWidth;
  final double? imageHeight;
  final String? promptTitleText;
  final String? promptText;
  final String? buttonText;
  final VoidCallback? onPressed;
  final PromptIndicatorType promptIndicatorType;

  const PromptIndicator({
    Key? key,
    this.image,
    this.imageWidth,
    this.imageHeight,
    this.promptTitleText,
    this.promptText,
    this.buttonText,
    this.onPressed,
    this.promptIndicatorType = PromptIndicatorType.vertical
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    if (promptIndicatorType == PromptIndicatorType.vertical) {
      return _VerticalPromptIndicator(
        image: image,
        imageWidth: imageWidth,
        imageHeight: imageHeight,
        promptTitleText: promptTitleText,
        promptText: promptText,
        buttonText: buttonText,
        onPressed: onPressed
      );
    } else {
      return _HorizontalPromptIndicator(
        image: image,
        imageWidth: imageWidth,
        imageHeight: imageHeight,
        promptTitleText: promptTitleText,
        promptText: promptText,
        buttonText: buttonText,
        onPressed: onPressed
      );
    }
  }
}

class _VerticalPromptIndicator extends StatelessWidget {
  final Image? image;
  final double? imageWidth;
  final double? imageHeight;
  final String? promptTitleText;
  final String? promptText;
  final String? buttonText;
  final VoidCallback? onPressed;

  const _VerticalPromptIndicator({
    Key? key,
    this.image,
    this.imageWidth,
    this.imageHeight,
    this.promptTitleText,
    this.promptText,
    this.buttonText,
    this.onPressed
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> columnWidget = <Widget>[
      if (image != null) ...[
        SizedBox(
          width: imageWidth ?? double.infinity,
          height: imageHeight ?? 200,
          child: FittedBox(
            child: image
          )
        ),
        const SizedBox(height: 20),
      ],
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (promptTitleText.isNotEmptyString) ...[
              Text(
                promptTitleText ?? "",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600
                ),
                textAlign: TextAlign.center
              ),
            ],
            if (promptText.isNotEmptyString) ...[
              const SizedBox(height: 10.0),
              Text(
                promptText ?? "",
                style: const TextStyle(
                  color: Colors.black,
                ),
                textAlign: TextAlign.center
              )
            ]
          ]
        ),
      ),
    ];
    if (onPressed != null) {
      columnWidget.addAll(
        <Widget>[
          const SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: onPressed,
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap
                ),
                child: Text(buttonText ?? ""),
              )
            ),
          ),
        ]
      );
    }
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: columnWidget,
      )
    );
  }
}

class _HorizontalPromptIndicator extends StatelessWidget {
  final Image? image;
  final double? imageWidth;
  final double? imageHeight;
  final String? promptTitleText;
  final String? promptText;
  final String? buttonText;
  final VoidCallback? onPressed;

  const _HorizontalPromptIndicator({
    Key? key,
    this.image,
    this.imageWidth,
    this.imageHeight,
    this.promptTitleText,
    this.promptText,
    this.buttonText,
    this.onPressed
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> rowWidget = <Widget>[
      if (image != null) ...[
        SizedBox(
          width: imageWidth ?? 55,
          height: imageHeight ?? 55,
          child: FittedBox(
            child: image
          )
        ),
        SizedBox(width: 2.w),
      ],
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (promptTitleText.isEmptyString) ...[
              Text(
                promptTitleText ?? "",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600
                ),
                textAlign: TextAlign.start
              ),
            ],
            if (promptText.isNotEmptyString) ...[
              const SizedBox(height: 4.0),
              Text(promptText ?? "", style: const TextStyle(color: Colors.black), textAlign: TextAlign.start)
            ]
          ]
        ),
      ),
    ];
    if (onPressed != null) {
      rowWidget.addAll(
        <Widget>[
          SizedBox(width: 2.w),
          SizedBox(
            child: TextButton(
              onPressed: onPressed,
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                foregroundColor: Colors.white,
                backgroundColor: Colors.black,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap
              ),
              child: Text(buttonText ?? ""),
            )
          ),
        ]
      );
    }
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 9),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: rowWidget,
        ),
      )
    );
  }
}