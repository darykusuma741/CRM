// ignore_for_file: avoid_print

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:crm/common/components/custom_error_text.dart';
import 'package:crm/common/components/dashed_rect_painter.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/common/constants/image_assets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;

class CustomUpload extends StatelessWidget {
  const CustomUpload({
    super.key,
    this.label,
    this.required = true,
    this.error,
    this.multiple = false,
    this.maxFile = 5,
    this.onChange,
    this.files,
    this.hint,
    this.maxFileSizeMB = 1,
    this.formatsText,
    this.onRemove,
  });
  final String? label;
  final String? hint;
  final String? formatsText;
  final bool required;
  final bool multiple;
  final int maxFile;
  final List<File>? files;
  final String? error;
  final int maxFileSizeMB;
  final void Function(File file)? onChange;
  final Function(File file)? onRemove;

  @override
  Widget build(BuildContext context) {
    final labelStyle = BaseText.blueMuted.copyWith(fontSize: 12.sp);
    final requiredStyle = BaseText.redCherry.copyWith(fontSize: 12.sp);
    final border = Border.all(color: error == null ? ColorsName.grayLight : ColorsName.redTomato, width: 1.w);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Row(
            children: [
              Text(label!, style: labelStyle),
              if (required) Text(' *', style: requiredStyle),
            ],
          ),
        if (label != null) SizedBox(height: 5.h),
        Column(
          children: [
            if ((!multiple && (files == null ? [] : files!).isEmpty || multiple) && ((files == null ? [] : files!).length < maxFile))
              InkWell(
                onTap: () async {
                  try {
                    await Permission.storage.request();
                  } catch (e) {
                    print(e);
                  }
                  final result = await FilePicker.platform.pickFiles(
                    allowMultiple: false,
                    // withData: true,
                    // type: FileType.custom,
                    // allowedExtensions: ['pdf', 'docx'],
                  );

                  if (result != null && result.files.single.path != null) {
                    final fileF = File(result.files.single.path!);
                    final fileSize = await fileF.length();

                    if (fileSize > maxFileSizeMB * 1024 * 1024) {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Maximum file size $maxFileSizeMB MB")),
                      );
                      return;
                    } else {
                      if (onChange != null) onChange!(fileF);
                    }
                  }
                },
                borderRadius: BorderRadius.circular(7.r),
                child: CustomPaint(
                  painter: DashedRectPainter(radius: 7.r),
                  child: Container(
                    width: double.infinity,
                    height: 74.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.r),
                      border: border,
                      color: ColorsName.grayFaint,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              width: 10.67.w,
                              height: 10.67.h,
                              ImageAssets.iconSvgUpload,
                            ),
                            SizedBox(width: 6.67.w),
                            Text(hint ?? '', style: BaseText.blueSteel.copyWith(fontSize: 12.sp)),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Text('Formats: ${formatsText ?? ''} (Max ${maxFileSizeMB}MB)',
                            style: BaseText.grayModern.copyWith(fontSize: 11.sp, fontWeight: FontWeight.w300)),
                      ],
                    ),
                  ),
                ),
              ),
            if (multiple && (files == null ? [] : files!).isNotEmpty) SizedBox(height: 8.h),
            if ((files == null ? [] : files!).isNotEmpty)
              Column(
                spacing: 5.h,
                children: files!.map((e) {
                  return CustomUploadNotEmpty(file: e, border: border, onRemove: onRemove == null ? (v) {} : onRemove!);
                }).toList(),
              ),
          ],
        ),
        if (error != null) CustomErrorText(error: error)
      ],
    );
  }
}

class CustomUploadNotEmpty extends StatelessWidget {
  const CustomUploadNotEmpty({super.key, required this.file, required this.onRemove, required this.border});
  final File file;
  final BoxBorder border;
  final Function(File file) onRemove;

  @override
  Widget build(BuildContext context) {
    String fileName = path.basename(file.path);
    final Rx<double> size = Rx(0);
    if (isImageFile(file)) {
      return InkWell(
        onTap: () => onRemove(file),
        child: SizedBox(
          width: 63.w,
          height: 63.w,
          child: Stack(
            children: [
              Positioned(
                bottom: 0.0,
                left: 0.0,
                child: Container(
                  width: 56.w,
                  height: 56.w,
                  decoration: BoxDecoration(color: ColorsName.white, borderRadius: BorderRadius.circular(4.r), border: Border.all(color: ColorsName.grayCloud)),
                  child: ClipRRect(borderRadius: BorderRadius.circular(4.r), child: Image.file(file, fit: BoxFit.cover)),
                ),
              ),
              Positioned(
                top: 0.0,
                right: 0.0,
                child: SizedBox(
                  width: 16.w,
                  height: 16.w,
                  child: SvgPicture.asset(
                    ImageAssets.iconSvgdoNotDisturbOn,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Obx(() {
      file.length().then((v) {
        size.value = v / (1024 * 1024);
      });
      return Container(
        height: 55.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          color: ColorsName.grayWhiteSmoke,
          borderRadius: BorderRadius.circular(6.r),
          border: border,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // SvgPicture.asset(width: 24.w, height: 24.w, ImageAssets.iconSvgPdf),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    fileName,
                    style: BaseText.grayDarker.copyWith(fontSize: 12.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text('${size.value.toStringAsFixed(2)} MB', style: BaseText.graySlate.copyWith(fontSize: 11.sp)),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            SvgPicture.asset(width: 16.w, height: 16.w, ImageAssets.iconSvgEdit),
          ],
        ),
      );
    });
  }

  bool isImageFile(File file) {
    final ext = path.extension(file.path).toLowerCase();
    return ['.jpg', '.jpeg', '.png', '.gif', '.bmp', '.webp'].contains(ext);
  }
}
