import 'package:crm/common/components/custom_list.dart';
import 'package:crm/common/components/custom_rating.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/data/model/leads.model.dart';
import 'package:crm/infrastructure/navigation/routes.dart';
import 'package:crm/presentation/home/controllers/home.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeLeadsItems extends GetView<HomeController> {
  const HomeLeadsItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final List<LeadsModel> data = controller.dataLeads.value;
      return CustomList(
        items: data,
        itemBuilder: (context, index) {
          return HomeLeadsItem(data[index]);
        },
      );
    });
  }
}

class HomeLeadsItem extends StatelessWidget {
  const HomeLeadsItem(this.data, {super.key});
  final LeadsModel data;

  @override
  Widget build(BuildContext context) {
    LeadsType type = data.type;
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.LEADS_DETAIL, arguments: data);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 66.w,
                  height: 19.h,
                  decoration: BoxDecoration(
                    color: type == LeadsType.lost ? ColorsName.redPaleSoft : ColorsName.greenPale,
                    borderRadius: BorderRadius.circular(25.r),
                    border: Border.all(color: type == LeadsType.lost ? ColorsName.redPastel : ColorsName.greenPastelMint, width: 0.5),
                  ),
                  child: Center(
                    child: Text(
                      type.toShortString(),
                      style: (type == LeadsType.lost ? BaseText.redBright : BaseText.greenPrimary).copyWith(fontSize: 10.sp),
                    ),
                  ),
                ),
                CustomRating(count: data.rating),
              ],
            ),
            SizedBox(height: 6.h),
            Text(
              data.title,
              style: BaseText.grayCharcoal.copyWith(fontSize: 13.sp),
            ),
            SizedBox(height: 4.h),
            Text(
              data.email,
              style: BaseText.grayGraphiteDark.copyWith(fontSize: 11.sp, fontWeight: FontWeight.w300),
            ),
            SizedBox(height: 2.h),
            Text(
              data.noHp,
              style: BaseText.grayGraphiteDark.copyWith(fontSize: 11.sp, fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
    );
  }
}
