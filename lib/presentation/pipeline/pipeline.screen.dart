import 'package:crm/common/components/custom_scaffold.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/presentation/pipeline/filter/pipeline.filter.dart';
import 'package:crm/presentation/pipeline/header/pipeline.header.dart';
import 'package:crm/presentation/pipeline/items/pipeline.items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'controllers/pipeline.controller.dart';

class PipelineScreen extends GetView<PipelineController> {
  const PipelineScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      light: true,
      backgroundColor: ColorsName.white,
      body: Column(
        children: [
          PipelineHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10.h),
                  PipelineFilter(),
                  SizedBox(height: 14.h),
                  PipelineItems(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
