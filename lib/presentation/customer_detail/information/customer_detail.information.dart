import 'package:crm/common/components/custom_divider.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/common/constants/image_assets.dart';
import 'package:crm/presentation/customer_detail/controllers/customer_detail.controller.dart';
import 'package:crm/presentation/customer_detail/information/detail/customer_detail.information.detail.dart';
import 'package:crm/presentation/customer_detail/information/documents/customer_detail.documents.dart';
import 'package:crm/presentation/customer_detail/information/logistics/customer_detail.information.logistics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CustomerDetailInformation extends GetView<CustomerDetailController> {
  const CustomerDetailInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomerDetailInformationLogistics(),
              CustomDivider(),
              CustomerDetailInformationDetail(),
              CustomDivider(),
              CustomerDetailDocuments(),
              SizedBox(height: 16.h),
            ],
          ),
        ),
        Column(
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
            SizedBox(height: 16.h + MediaQuery.of(context).padding.bottom),
          ],
        )
      ],
    );
  }
}
