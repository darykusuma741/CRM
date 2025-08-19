import 'package:crm/common/components/custom_list.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/data/model/freight_product.model.dart';
import 'package:crm/presentation/freight_product/controllers/freight_product.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FreightProductItems extends GetView<FreightProductController> {
  const FreightProductItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final List<FreightProductModel> data = controller.data.value;
      return CustomList<FreightProductModel>(
        scroll: false,
        items: data,
        paddingDivider: EdgeInsets.symmetric(horizontal: 16.w),
        itemBuilder: (context, index) {
          final FreightProductModel item = data[index];
          return FreightProductItemsItem(item);
        },
      );
    });
  }
}

class FreightProductItemsItem extends GetView<FreightProductController> {
  const FreightProductItemsItem(this.item, {super.key});
  final FreightProductModel item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => controller.onClickItem(item),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.name,
              style: BaseText.grayCharcoal.copyWith(fontSize: 13.sp),
            ),
            SizedBox(height: 4.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Transport: ${item.transportBy.toShortString()}',
                  style: BaseText.grayGraphiteDark.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w300),
                ),
                Text(
                  'Type: ${item.type.toShortString()}',
                  style: BaseText.grayGraphiteDark.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
