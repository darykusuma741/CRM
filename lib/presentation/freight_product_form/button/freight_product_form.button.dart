import 'package:crm/common/components/custom_button.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/presentation/freight_product_form/controllers/freight_product_form.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FreightProductFormButton extends GetView<FreightProductFormController> {
  const FreightProductFormButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: CustomButton(
        onTap: controller.onSubmit,
        title: 'Submit',
        bgColor: ColorsName.blueDeep,
      ),
    );
  }
}
