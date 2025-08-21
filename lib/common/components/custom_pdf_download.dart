import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/common/constants/image_assets.dart';

class CustomPdfDownload extends StatelessWidget {
  const CustomPdfDownload({super.key, required this.pdfName});
  final String pdfName;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: ColorsName.grayWhiteSmoke,
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: ColorsName.grayLight),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(width: 24.w, height: 24.w, ImageAssets.iconSvgPdf),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  pdfName,
                  style: BaseText.grayDarker.copyWith(fontSize: 12.sp),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text('1 MB', style: BaseText.graySlate.copyWith(fontSize: 11.sp)),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          // SvgPicture.asset(width: 16.w, height: 16.w, ImageAssets.iconSvgEdit),
        ],
      ),
    );
  }
}
