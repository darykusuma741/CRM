import 'package:crm/common/components/custom_divider.dart';
import 'package:crm/common/components/custom_scaffold.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'controllers/product_category_detail.controller.dart';

class ProductCategoryDetailScreen extends GetView<ProductCategoryDetailController> {
  const ProductCategoryDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return CustomScaffold(
        appBar: CustomAppBar(
          title: 'Product Category Detail',
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
                      "HS Code",
                      style: BaseText.graySlate.copyWith(fontSize: 11.sp, fontWeight: FontWeight.w300),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      controller.item.value.hsCode,
                      style: BaseText.grayDarker.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "Description",
                      style: BaseText.graySlate.copyWith(fontSize: 11.sp, fontWeight: FontWeight.w300),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      controller.item.value.description ?? '-',
                      style: BaseText.grayDarker.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w400),
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
