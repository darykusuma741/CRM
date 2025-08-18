import 'package:crm/common/components/custom_list.dart';
import 'package:crm/common/components/custom_scaffold.dart';
import 'package:crm/common/components/custom_text_editing.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/common/constants/image_assets.dart';
import 'package:crm/common/helper/formatter.helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import 'controllers/product_service.controller.dart';

class ProductServiceScreen extends GetView<ProductServiceController> {
  const ProductServiceScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final data = controller.data.value;

      return CustomScaffold(
        appBar: CustomAppBar(
          title: 'Product Service',
        ),
        backgroundColor: ColorsName.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: CustomTextEditing(
                  onChanged: (v) {
                    controller.searchProduct(v);
                  },
                  hint: 'Search your product',
                  borderRadius: BorderRadius.circular(100.r),
                  borderSide: BorderSide(width: 0.0, color: Colors.transparent),
                  fillColor: ColorsName.grayCloudy,
                  prefixIcon: Container(
                    // color: Colors.amber,
                    padding: EdgeInsets.only(right: 6.w, left: 12.w, top: 10.h, bottom: 10.h),
                    child: SvgPicture.asset(ImageAssets.iconSvgSearch, width: 14.w),
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              CustomList(
                scroll: false,
                items: data,
                paddingDivider: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data[index].title,
                          style: BaseText.grayCharcoal.copyWith(fontSize: 13.sp),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          FormatterHelper.formatRupiah(data[index].price),
                          style: BaseText.grayGraphiteDark.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      );
    });
  }
}

class ProductServiceItem extends StatelessWidget {
  const ProductServiceItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
