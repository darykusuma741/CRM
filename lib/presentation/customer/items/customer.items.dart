import 'package:crm/common/components/custom_list.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/data/enum/customer_detail_type.dart';
import 'package:crm/data/model/customer.model.dart';
import 'package:crm/presentation/customer/controllers/customer.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomerItems extends GetView<CustomerController> {
  const CustomerItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final List<CustomerModel> data = controller.data.value;
      return CustomList<CustomerModel>(
        scroll: false,
        items: data,
        paddingDivider: EdgeInsets.symmetric(horizontal: 16.w),
        itemBuilder: (context, index) {
          final CustomerModel item = data[index];
          return CustomerItemsItem(item);
        },
      );
    });
  }
}

class CustomerItemsItem extends GetView<CustomerController> {
  const CustomerItemsItem(this.item, {super.key});
  final CustomerModel item;

  @override
  Widget build(BuildContext context) {
    String name = '';
    if (item.detailType.isCompany) {
      name = item.companyName ?? '-';
    } else {
      name = item.customerName ?? '-';
    }

    return InkWell(
      onTap: () => controller.onClickItem(item),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: BaseText.grayCharcoal.copyWith(fontSize: 13.sp),
                ),
                SizedBox(height: 4.h),
                Text(
                  item.email ?? '-',
                  style: BaseText.grayGraphiteDark.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w300),
                ),
              ],
            ),
            Container(
              width: 68.w,
              height: 19.h,
              decoration: BoxDecoration(
                color: item.detailType.isCompany ? ColorsName.blueExtraLight : ColorsName.greenMintPale,
                borderRadius: BorderRadius.circular(25.r),
                border: Border.all(color: item.detailType.isCompany ? ColorsName.greenPastelMint : ColorsName.bluePaleSoft, width: 0.5),
              ),
              child: Center(
                child: Text(
                  item.detailType.toShortString(),
                  style: (item.detailType.isCompany ? BaseText.blueBrightSky : BaseText.greenPrimary).copyWith(fontSize: 10.sp),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
