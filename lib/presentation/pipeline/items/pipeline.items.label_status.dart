import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/presentation/pipeline/controllers/pipeline.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PipelineItemsLabelStatus extends GetView<PipelineController> {
  const PipelineItemsLabelStatus({super.key, required this.status});
  final String status;

  @override
  Widget build(BuildContext context) {
    late Color bgColor;
    late Color borderColor;
    late TextStyle styleColor;
    switch (status) {
      case 'New':
        bgColor = ColorsName.blueExtraLight;
        borderColor = ColorsName.bluePaleSoft;
        styleColor = BaseText.blueBrightSky;
        break;
      case 'Qualified':
        bgColor = ColorsName.blueAquaPale;
        borderColor = ColorsName.greenAquaMint;
        styleColor = BaseText.tealBright;
        break;
      case 'Proposition':
        bgColor = ColorsName.yellowPale;
        borderColor = ColorsName.yellowSoft;
        styleColor = BaseText.yellowGolden;
        break;
      case 'Won':
        bgColor = ColorsName.greenMintPale;
        borderColor = ColorsName.greenPastelMint;
        styleColor = BaseText.greenPrimary;
      case 'Lost':
        bgColor = ColorsName.redSoftPale;
        borderColor = ColorsName.redBlush;
        styleColor = BaseText.redLight;
        break;
      default:
        bgColor = ColorsName.blueAquaPale;
        borderColor = ColorsName.greenAquaMint;
        styleColor = BaseText.tealBright;
    }
    return Container(
      width: 80.w,
      padding: EdgeInsets.symmetric(vertical: 4.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(25.r),
        border: Border.all(color: borderColor, width: 0.5),
      ),
      child: Center(
        child: Text(status, style: styleColor.copyWith(fontSize: 10.sp)),
      ),
    );
  }
}
