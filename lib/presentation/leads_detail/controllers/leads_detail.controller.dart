import 'package:crm/common/components/custom_modal_bottom.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/image_assets.dart';
import 'package:crm/data/model/leads.model.dart';
import 'package:crm/infrastructure/navigation/routes.dart';
import 'package:crm/presentation/leads_detail/component/leads_detail.convert.component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class LeadsDetailController extends GetxController {
  final Rx<LeadsModel> item = Rx(Get.arguments);

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onClickConvertToPipeline() async {
    await customModalBottom(LeadsDetailConvertComponent());
  }

  void onPressMore() {
    customModalBottom(Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(),
      child: Column(
        children: [
          InkWell(
            onTap: () async {
              final dynamic result = await Get.toNamed(Routes.LEADS_FORM, arguments: item.value);
              if (result != null) {
                item.value = result;
              }
            },
            child: Container(
              height: 34.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  SvgPicture.asset(ImageAssets.iconSvgEdit, width: 16.w),
                  SizedBox(width: 8.w),
                  Text('Edit', style: BaseText.grayDarkest.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w400)),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ),
          SizedBox(height: 12.h),
        ],
      ),
    ));
  }
}
