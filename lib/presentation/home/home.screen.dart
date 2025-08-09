import 'package:crm/common/components/custom_scaffold.dart';
import 'package:crm/presentation/home/bottom_nav/home.bottom_nav.dart';
import 'package:crm/presentation/home/general_meeting/home.general_meeting.dart';
import 'package:crm/presentation/home/header/home.header.dart';
import 'package:crm/presentation/home/pipeline/home.pipeline.dart';
import 'package:crm/presentation/home/status/home.status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'controllers/home.controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      light: true,
      bottomNavigationBar: HomeBottomNav(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HomeHeader(),
                  SizedBox(height: 14.h),
                  HomePipeline(),
                  SizedBox(height: 18.h),
                  HomeGeneralMeeting(),
                ],
              ),
            ),
          ),
          HomeStatus(),
        ],
      ),
    );
  }
}
