import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/common/constants/image_assets.dart';
import 'package:crm/presentation/leads_detail/controllers/leads_detail.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class LeadsDetailButton extends GetView<LeadsDetailController> {
  const LeadsDetailButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: Container()),
        Container(
          width: 84.w,
          height: 34.h,
          decoration: BoxDecoration(color: ColorsName.blueDeep, borderRadius: BorderRadius.circular(100.r)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            // spacing: 12.w,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: SvgPicture.asset(
                    ImageAssets.iconCallWhite,
                    width: 14.w,
                    height: 14.w,
                  ),
                ),
              ),
              Container(
                width: 0.8,
                height: 12.0,
                decoration: BoxDecoration(color: ColorsName.white),
              ),
              Expanded(
                child: SvgPicture.asset(
                  ImageAssets.iconEmailWhite,
                  width: 14.w,
                  height: 14.w,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          width: double.infinity,
          height: 68.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: ColorsName.white,
            border: Border.all(color: ColorsName.grayCloud, width: 1.w),
            boxShadow: [
              BoxShadow(
                color: ColorsName.grayDarkest.withOpacity(0.08),
                offset: Offset(0.0, 0.44),
                // spreadRadius: 1.32,
                blurRadius: .0,
              ),
              BoxShadow(
                color: ColorsName.grayDarkest.withOpacity(0.05),
                offset: Offset(0.0, 2.0),
                // spreadRadius: 1.32,
                blurRadius: 5.0,
              ),
            ],
          ),
          child: Row(
            children: [
              Material(
                color: ColorsName.white,
                borderRadius: BorderRadius.circular(7.r),
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(7.r),
                  child: Container(
                    width: 100.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorsName.blueDeepSeaDark),
                      borderRadius: BorderRadius.circular(7.r),
                    ),
                    child: Center(
                      child: Text(
                        'Lost',
                        style: BaseText.blueDeepSeaDark.copyWith(fontSize: 13.sp),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(7.r),
                  child: InkWell(
                    onTap: controller.onClickConvertToPipeline,
                    borderRadius: BorderRadius.circular(7.r),
                    child: Ink(
                      width: 100.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.r),
                        gradient: LinearGradient(
                          begin: Alignment.centerRight, // karena hampir 270deg (dari kanan ke kiri)
                          end: Alignment.centerLeft,
                          colors: const [
                            Color(0xFF1D66AF), // 10.52%
                            Color(0xFF17436B), // 54.79%
                            Color(0xFF123A5C), // 99.06%
                          ],
                          stops: const [
                            0.1052,
                            0.5479,
                            0.9906,
                          ],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Convert to Pipeline',
                          style: BaseText.white.copyWith(fontSize: 13.sp),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
