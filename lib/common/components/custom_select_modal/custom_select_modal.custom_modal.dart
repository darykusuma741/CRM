import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:crm/common/components/custom_list.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';

class CustomSelectModalCustomModal<T> extends StatelessWidget {
  const CustomSelectModalCustomModal({
    super.key,
    this.valueData,
    required this.onChange,
    this.title,
    required this.items,
    required this.valueText,
  });
  final T? valueData;
  final List<T> items;
  final String Function(T v) valueText;
  final void Function(T? v) onChange;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final Rxn<T?> value = Rxn(valueData);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              title!,
              style: BaseText.grayCharcoal.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w500),
            ),
          ),
        if (title != null) SizedBox(height: 10.h),
        CustomList(
          items: items,
          itemBuilder: (context, index) {
            return Obx(
              () => InkWell(
                onTap: () {
                  value.value = items[index];
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 12.h),
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(valueText(items[index]), style: BaseText.grayDarker.copyWith(fontSize: 12.sp)),
                      Icon(
                        value.value == items[index] ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded,
                        size: 18.sp,
                        color: ColorsName.blueNavy,
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        SizedBox(height: 10.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                    onChange(null);
                  },
                  child: Container(
                    height: 38.h,
                    decoration: BoxDecoration(
                      color: ColorsName.white,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: ColorsName.redTomato, width: 1.w),
                    ),
                    child: Center(
                      child: Text(
                        'Reset'.tr,
                        style: BaseText.redTomato.copyWith(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                    onChange(value.value);
                  },
                  child: Container(
                    height: 38.h,
                    decoration: BoxDecoration(
                      color: ColorsName.blueDeep,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Center(
                      child: Text(
                        'Apply'.tr,
                        style: BaseText.white.copyWith(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}
