import 'package:crm/common/components/custom_text_editing.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/common/constants/image_assets.dart';
import 'package:crm/presentation/pipeline/controllers/pipeline.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class PipelineHeader extends GetView<PipelineController> {
  const PipelineHeader({super.key});

  @override
  Widget build(BuildContext context) {
    double topPadding = MediaQuery.of(context).padding.top;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorsName.navyDark,
            ColorsName.blueNight,
          ],
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: topPadding + 14.h),
          Container(
            padding: EdgeInsets.only(left: 16.w - 6.65.w),
            child: Row(
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    borderRadius: BorderRadius.circular(100.r),
                    child: Ink(
                      height: 28.w,
                      width: 28.w,
                      child: Center(
                        child: SvgPicture.asset(
                          ImageAssets.iconSvgArrowLeftBlack,
                          width: 14.7.w,
                          height: 11.w,
                          colorFilter: ColorFilter.mode(ColorsName.white, BlendMode.srcIn),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 11.67.w - 6.65.w),
                Text('My Pipeline', style: BaseText.white.copyWith(fontSize: 16.sp)),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                SizedBox(height: 12.h),
                CustomTextEditing(
                  onChanged: (v) {
                    // controller.searchCustomer(v);
                  },
                  // controller: controller.searchCustomerCtr.value,
                  hint: 'Search your pipeline name...',
                  borderRadius: BorderRadius.circular(100.r),
                  borderSide: BorderSide(width: 0.0, color: Colors.transparent),
                  fillColor: ColorsName.grayCloudy,
                  prefixIcon: Container(
                    // color: Colors.amber,
                    padding: EdgeInsets.only(right: 6.w, left: 12.w, top: 10.h, bottom: 10.h),
                    child: SvgPicture.asset(ImageAssets.iconSvgSearch, width: 14.w),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 14.h),
        ],
      ),
    );
  }
}
