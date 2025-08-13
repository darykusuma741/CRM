import 'package:carousel_slider/carousel_slider.dart';
import 'package:crm/common/components/custom_ink_well.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/common/constants/image_assets.dart';
import 'package:crm/data/model/activity.model.dart';
import 'package:crm/infrastructure/navigation/routes.dart';
import 'package:crm/presentation/home/controllers/home.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HomePipeline extends GetView<HomeController> {
  const HomePipeline({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      List<ActivityModel> allDataCall = controller.ctrActivityMain.allDataCall.value;
      List<ActivityModel> allDataDoc = controller.ctrActivityMain.allDataDoc.value;
      List<ActivityModel> allDataMeeting = controller.ctrActivityMain.allDataMeeting.value;
      List<ActivityModel> allDataToDo = controller.ctrActivityMain.allDataToDo.value;

      final List<PipelineState> listPipelineState = [
        PipelineState(
          title: "Call",
          count: allDataCall.length,
          imagePath: ImageAssets.iconSvgCall,
          onTap: () {
            Get.toNamed(Routes.CALL_ACTIVITIES, arguments: allDataCall);
          },
        ),
        PipelineState(
          title: "Meeting",
          count: allDataMeeting.length,
          imagePath: ImageAssets.iconSvgMeeting,
        ),
        PipelineState(
          title: "To Do",
          count: allDataToDo.length,
          imagePath: ImageAssets.iconSvgToDo,
        ),
        PipelineState(
          title: "Document",
          count: allDataDoc.length,
          imagePath: ImageAssets.iconSvgDocument,
          onTap: () {
            Get.toNamed(Routes.DOCUMENT_ACTIVITIES, arguments: allDataDoc);
          },
        ),
      ];

      final List<Widget> listWidgetView = [
        _buildListWidgetView(listPipelineState),
        _buildListWidgetView(listPipelineState),
      ];

      final selectIndex = 0.obs;

      return Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                'Get Ready for Pipeline Activities!',
                style: BaseText.grayCharcoal.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: 8.h),
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: false,
                viewportFraction: 1.0,
                enlargeCenterPage: false,
                aspectRatio: 3.4612,
                onPageChanged: (index, reason) => selectIndex.value = index,
              ),
              items: List.generate(listWidgetView.length, (index) {
                return listWidgetView[index];
              }),
            ),
            SizedBox(height: 10.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 4.w,
              children: List.generate(listWidgetView.length, (index) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  height: 5.w,
                  width: selectIndex.value == index ? 12.w : 5.w,
                  decoration: BoxDecoration(
                    color: selectIndex.value == index ? ColorsName.blueSteel : ColorsName.grayAsh,
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                );
              }),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildListWidgetView(List<PipelineState> listPipelineState) {
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0.0),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 kolom
        mainAxisExtent: 48.h, // tinggi tiap item maksimal 42px
        crossAxisSpacing: 8.w,
        mainAxisSpacing: 8.h,
      ),
      itemCount: listPipelineState.length,
      itemBuilder: (_, index) {
        return HomeItemPipeline(statePipeline: listPipelineState[index]);
      },
    );
  }
}

class HomeItemPipeline extends StatelessWidget {
  const HomeItemPipeline({super.key, required this.statePipeline});
  final PipelineState statePipeline;

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: statePipeline.onTap,
      decoration: BoxDecoration(
        color: ColorsName.white,
        borderRadius: BorderRadius.circular(6.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 32.w,
            width: 32.w,
            decoration: BoxDecoration(
              color: ColorsName.graySoftLight,
              borderRadius: BorderRadius.circular(100.r),
              border: Border.all(color: ColorsName.bluePastel.withOpacity(0.5)),
            ),
            child: Center(
              child: SvgPicture.asset(statePipeline.imagePath, width: 16.w),
            ),
          ),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                statePipeline.title,
                style: BaseText.graySlate.copyWith(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w400,
                  height: 1.3,
                  fontStyle: FontStyle.normal,
                ),
              ),
              Text(
                statePipeline.count.toString(),
                style: BaseText.grayDarker.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  height: 18 / 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PipelineState {
  final String title;
  final String imagePath;
  final int count;
  final void Function()? onTap;

  PipelineState({required this.title, this.onTap, required this.count, required this.imagePath});
}
