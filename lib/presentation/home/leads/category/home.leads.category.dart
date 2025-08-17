import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/data/model/leads.model.dart';
import 'package:crm/presentation/home/controllers/home.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeLeadsCategory extends GetView<HomeController> {
  const HomeLeadsCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 16.w),
              HomeLeadsCategoryItem(
                count: 5,
                label: 'All',
                select: controller.selectCategory.value == null,
                onTap: () {
                  controller.selectCategory.value = null;
                  controller.filterLeads();
                },
              ),
              SizedBox(width: 8.w),
              HomeLeadsCategoryItem(
                count: 3,
                label: 'Prospects',
                select: controller.selectCategory.value == LeadsType.prospects,
                onTap: () {
                  controller.selectCategory.value = LeadsType.prospects;
                  controller.filterLeads();
                },
              ),
              SizedBox(width: 8.w),
              HomeLeadsCategoryItem(
                count: 2,
                label: 'Lost',
                select: controller.selectCategory.value == LeadsType.lost,
                onTap: () {
                  controller.selectCategory.value = LeadsType.lost;
                  controller.filterLeads();
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}

class HomeLeadsCategoryItem extends StatelessWidget {
  const HomeLeadsCategoryItem({super.key, required this.onTap, required this.label, required this.count, this.select = false});
  final String label;
  final int count;
  final bool select;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100.r),
      child: Container(
        height: 26.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          color: select ? ColorsName.bluePastel.withOpacity(.5) : ColorsName.grayFaint,
          borderRadius: BorderRadius.circular(100.r),
          border: Border.all(color: select ? ColorsName.bluePastel : ColorsName.grayCloud),
        ),
        child: Center(
          child: Text(
            '$label (${count.toString()})',
            style: (select ? BaseText.blueDusty : BaseText.grayGraphiteDark)
                .copyWith(fontSize: 11.sp, fontWeight: FontWeight.w400, letterSpacing: 0.0, height: 1.0),
          ),
        ),
      ),
    );
  }
}
