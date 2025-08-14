import 'package:crm/common/components/custom_ink_well.dart';
import 'package:crm/common/components/custom_list.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/common/constants/image_assets.dart';
import 'package:crm/presentation/home/controllers/home.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeMainGeneralMeeting extends GetView<HomeController> {
  const HomeMainGeneralMeeting({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Today’s General Meeting',
                style: BaseText.grayCharcoal.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w500),
              ),
              InkWell(
                onTap: () {},
                child: Text(
                  'See all',
                  style: BaseText.blueSteel.copyWith(fontSize: 10.sp, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Container(
            width: double.infinity,
            height: 124.h,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
            decoration: BoxDecoration(color: ColorsName.white, borderRadius: BorderRadius.circular(6.r)),
            child: CustomList(
              paddingDivider: EdgeInsets.all(0.0),
              scroll: true,
              items: [1, 2, 3, 4, 5],
              itemBuilder: (context, index) {
                return HomeMainGeneralMeetingItem(
                  stateN: HomeMainGeneralMeetingState(description: 'Quarterly Business Revieved', date: DateTime.now()),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class HomeMainGeneralMeetingItem extends StatelessWidget {
  const HomeMainGeneralMeetingItem({super.key, required this.stateN});
  final HomeMainGeneralMeetingState stateN;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 13.h),
      child: Column(
        children: [
          Row(
            spacing: 10.w,
            children: [
              Container(
                width: 34.w,
                height: 34.w,
                decoration: BoxDecoration(
                  color: ColorsName.graySoftLight,
                  borderRadius: BorderRadius.circular(100.r),
                  border: Border.all(color: ColorsName.bluePastel.withOpacity(0.5)),
                ),
                child: Center(
                  child: SvgPicture.asset(ImageAssets.iconSvgNotif1, width: 16.w),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stateN.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: BaseText.grayCharcoal.copyWith(fontSize: 13.sp),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      DateFormat('d MMM yyyy, HH:mm').format(stateN.date),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: BaseText.graySlate.copyWith(fontSize: 11.sp),
                    ),
                  ],
                ),
              ),
              CustomInkWell(
                onTap: () {},
                height: 30.h,
                width: 68.w,
                decoration: BoxDecoration(
                  color: ColorsName.white,
                  border: Border.all(color: ColorsName.bluePastel),
                ),
                child: Center(
                  child: Text('Check-in', style: BaseText.blueSteel.copyWith(fontSize: 11.sp, fontWeight: FontWeight.w500)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class HomeMainGeneralMeetingState {
  String description;
  DateTime date;

  HomeMainGeneralMeetingState({
    required this.description,
    required this.date,
  });
}
