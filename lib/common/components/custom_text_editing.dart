import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:crm/common/components/custom_error_text.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/common/constants/image_assets.dart';

class CustomTextEditing extends StatelessWidget {
  const CustomTextEditing({
    super.key,
    this.label,
    this.keyboardType,
    this.inputFormatters,
    required this.hint,
    this.onChanged,
    this.required = true,
    this.controller,
    this.passwordField = false,
    this.enabled = true,
    this.error,
    this.textArea = false,
  });
  final String? label;
  final String? error;
  final String hint;
  final TextEditingController? controller;
  final bool required;
  final bool passwordField;
  final bool? enabled;
  final Function(String? value)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final bool textArea;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: error == null ? ColorsName.grayPearly : ColorsName.redTomato, width: 1.w),
    );
    final focusBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: error == null ? ColorsName.blueSteel : ColorsName.redTomato, width: 1.w),
    );

    final hintStyle = BaseText.grayMedium.copyWith(fontSize: 13.sp);
    final textStyle = (enabled == true ? BaseText.grayIronDark : BaseText.grayMedium).copyWith(fontSize: 13.sp);
    final labelStyle = BaseText.blueMuted.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w500);
    final requiredStyle = BaseText.redCherry.copyWith(fontSize: 12.sp);
    final Rx<bool> showPassword = Rx(false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Row(
            children: [
              Text(label!, style: labelStyle),
              if (required) Text(' *', style: requiredStyle),
            ],
          ),
        if (label != null) SizedBox(height: 5.h),
        Stack(
          children: [
            Obx(() {
              final sPass = showPassword.value ? false : true;
              return TextField(
                maxLines: textArea ? null : 1, // biar unlimited height (auto expand)
                minLines: textArea ? 5 : null, // tinggi minimum 5 baris
                style: textStyle,
                enabled: enabled,
                controller: controller,
                onChanged: onChanged,
                obscureText: passwordField ? sPass : false,
                inputFormatters: inputFormatters,
                keyboardType: textArea ? TextInputType.multiline : keyboardType,
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: passwordField
                      ? EdgeInsets.only(top: textArea ? 10.h : 0.h, bottom: textArea ? 10.h : 0.h, left: 12.w, right: 32.w)
                      : EdgeInsets.symmetric(horizontal: 12.w, vertical: textArea ? 10.h : 0.h),
                  constraints: BoxConstraints(maxHeight: textArea ? 84.h : 40.h),
                  hintText: hint,
                  hintStyle: hintStyle,
                  border: border,
                  enabledBorder: border,
                  errorBorder: border,
                  focusedBorder: focusBorder,
                  disabledBorder: border,
                  focusedErrorBorder: border,
                  fillColor: enabled == true ? ColorsName.white : ColorsName.grayWhiteSmoke,
                ),
              );
            }),
            if (passwordField)
              Obx(
                () => Positioned(
                  right: 12.w,
                  top: showPassword.value ? 11.h : 13.5.h,
                  child: showPassword.value
                      ? GestureDetector(
                          onTap: () => showPassword.value = !showPassword.value,
                          child: Icon(
                            Icons.remove_red_eye_rounded,
                            size: 18.sp,
                            color: ColorsName.grayAsh,
                          ),
                        )
                      : GestureDetector(
                          onTap: () => showPassword.value = !showPassword.value,
                          child: SvgPicture.asset(
                            ImageAssets.iconSvgEyeDisabled,
                            height: 15.5.h,
                            // colorFilter: ColorFilter.mode(ColorsName.grayGraphiteDark, BlendMode.srcIn),
                          ),
                        ),
                ),
              )
          ],
        ),
        if (error != null) CustomErrorText(error: error)
      ],
    );
  }
}
