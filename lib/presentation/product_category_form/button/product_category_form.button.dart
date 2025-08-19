import 'package:crm/common/components/custom_button.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/presentation/product_category_form/controllers/product_category_form.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProductCategoryFormButton extends GetView<ProductCategoryFormController> {
  const ProductCategoryFormButton({super.key});

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
