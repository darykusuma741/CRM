import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:crm/common/components/custom_button.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/common/constants/image_assets.dart';

Future<T?> customModalButton<T>(BuildContext context, {required String title, String? saveTitle, required String content, T Function()? onSave}) async {
  T? result;

  await showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Container(
          width: double.infinity,
          height: 176.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          decoration: BoxDecoration(color: ColorsName.white, borderRadius: BorderRadius.circular(8.r)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title.tr,
                    style: BaseText.grayCharcoal.copyWith(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(width: 18.w, height: 18.h, ImageAssets.iconSvgClose)),
                ],
              ),
              SizedBox(height: 24.h),
              Text(
                content.tr,
                textAlign: TextAlign.center,
                style: BaseText.grayDarker.copyWith(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Expanded(child: Container()),
              Row(
                spacing: 12.w,
                children: [
                  Expanded(
                    child: CustomButton(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      border: true,
                      borderCustom: Border.all(color: ColorsName.blueDeep),
                      title: 'Cancel',
                    ),
                  ),
                  Expanded(
                    child: CustomButton(
                      onTap: () async {
                        if (onSave != null) {
                          result = onSave();
                          Navigator.pop(context);
                        } else {
                          Navigator.pop(context);
                        }
                      },
                      borderCustom: Border.all(color: ColorsName.blueDeep),
                      title: saveTitle ?? 'Save'.tr,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
  return result;
}
