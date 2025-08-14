import 'package:crm/presentation/home/controllers/home.controller.dart';
import 'package:crm/presentation/home/main/general_meeting/home.main.general_meeting.dart';
import 'package:crm/presentation/home/main/header/home.main.header.dart';
import 'package:crm/presentation/home/main/pipeline/home.main.pipeline.dart';
import 'package:crm/presentation/home/main/status/home.main.status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeMain extends GetView<HomeController> {
  const HomeMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeMainHeader(),
                SizedBox(height: 14.h),
                HomeMainPipeline(),
                SizedBox(height: 18.h),
                HomeMainGeneralMeeting(),
              ],
            ),
          ),
        ),
        HomeMainStatus(),
      ],
    );
  }
}
