import 'package:crm/common/components/custom_pdf_download.dart';
import 'package:crm/common/constants/base_text.dart';
import 'package:crm/presentation/customer_detail/controllers/customer_detail.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomerDetailDocuments extends GetView<CustomerDetailController> {
  const CustomerDetailDocuments({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final item = controller.item.value;
      return Container(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Documents', style: BaseText.grayCharcoalDark.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w500)),
            SizedBox(height: 12.h),
            _CustomerDetailDocumentsItem(label: 'NIK', value: item.nik ?? '-'),
            SizedBox(height: 10.h),
            Text('KTP', style: BaseText.graySlate.copyWith(fontSize: 11.sp, fontWeight: FontWeight.w300)),
            SizedBox(height: 1.h),
            CustomPdfDownload(pdfName: 'KTP_File.pdf'),
            SizedBox(height: 10.h),
            _CustomerDetailDocumentsItem(label: 'NPWP', value: item.npwp ?? '-'),
            SizedBox(height: 10.h),
            Text('NPWP', style: BaseText.graySlate.copyWith(fontSize: 11.sp, fontWeight: FontWeight.w300)),
            SizedBox(height: 1.h),
            CustomPdfDownload(pdfName: 'NPWP.pdf'),
            SizedBox(height: 10.h),
          ],
        ),
      );
    });
  }
}

class _CustomerDetailDocumentsItem extends StatelessWidget {
  const _CustomerDetailDocumentsItem({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: BaseText.graySlate.copyWith(fontSize: 11.sp, fontWeight: FontWeight.w300)),
        SizedBox(height: 1.h),
        Text(value, style: BaseText.grayDarker.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w400)),
      ],
    );
  }
}
