import 'package:crm/common/components/custom_divider.dart';
import 'package:crm/common/components/custom_scaffold.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/common/constants/image_assets.dart';
import 'package:crm/data/enum/transport_by.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import 'controllers/freight_product_detail.controller.dart';

class FreightProductDetailScreen extends GetView<FreightProductDetailController> {
  const FreightProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return CustomScaffold(
        appBar: CustomAppBar(
          title: 'Freight Product Detail',
          actions: [
            IconButton(onPressed: controller.onPressMore, icon: Icon(Icons.more_vert_rounded)),
          ],
        ),
        backgroundColor: ColorsName.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 220.h,
                decoration: BoxDecoration(color: ColorsName.graySnow),
                child: controller.item.value.photo == null
                    ? Center(child: SvgPicture.asset(ImageAssets.iconSvgPhotoNull, width: 160.w))
                    : Image.network(
                        controller.item.value.photo!,
                        fit: BoxFit.cover,
                      ),
              ),
              Container(
                width: double.infinity,
                height: 70.h,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      controller.item.value.name,
                      style: BaseText.grayCharcoal.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'Product',
                      style: BaseText.graySlate.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              CustomDivider(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Detail Information",
                      style: BaseText.grayCharcoal.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "Transport by",
                      style: BaseText.graySlate.copyWith(fontSize: 11.sp, fontWeight: FontWeight.w300),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      controller.item.value.transportBy.toShortString(),
                      style: BaseText.grayDarker.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "Branch",
                      style: BaseText.graySlate.copyWith(fontSize: 11.sp, fontWeight: FontWeight.w300),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      controller.item.value.branch ?? '-',
                      style: BaseText.grayDarker.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "Internal Reference",
                      style: BaseText.graySlate.copyWith(fontSize: 11.sp, fontWeight: FontWeight.w300),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      controller.item.value.internalReference ?? '-',
                      style: BaseText.grayDarker.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "Product Category",
                      style: BaseText.graySlate.copyWith(fontSize: 11.sp, fontWeight: FontWeight.w300),
                    ),
                    SizedBox(height: 4.h),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: controller.item.value.productCategory.map((e) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                            decoration: BoxDecoration(
                                color: ColorsName.graySoftPale,
                                border: Border.all(color: ColorsName.bluePastel, width: 0.8.r),
                                borderRadius: BorderRadius.circular(4.r)),
                            child: Text(
                              e,
                              style: BaseText.grayDarker.copyWith(fontSize: 11.sp, fontWeight: FontWeight.w400),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
