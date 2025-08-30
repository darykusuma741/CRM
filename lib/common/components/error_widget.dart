import 'package:crm/common/ext/error_provider_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/base_text.dart';
import '../constants/colors_name.dart';
import '../error_provider/error_provider.dart';

class ErrorIndicatorWidget extends StatelessWidget {
  final ErrorProvider errorProvider;
  final dynamic e;

  const ErrorIndicatorWidget({
    super.key,
    required this.errorProvider,
    required this.e
  });

  @override
  Widget build(BuildContext context) {
    ErrorProviderResult errorProviderResult = errorProvider
      .onGetErrorProviderResult(e)
      .toErrorProviderResultNonNull();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          errorProviderResult.title,
          style: BaseText.redDark.copyWith(
            fontWeight: BaseText.medium,
            fontSize: 14.sp,
            color: ColorsName.grayDark
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 2.h),
        Text(
          errorProviderResult.message,
          style: BaseText.redDark.copyWith(
            color: ColorsName.grayLight,
            fontWeight: BaseText.light,
            fontSize: 14.sp
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}