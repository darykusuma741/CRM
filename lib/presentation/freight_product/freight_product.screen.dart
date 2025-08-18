import 'package:crm/common/components/custom_scaffold.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/presentation/freight_product/filter/freight_product.filter.dart';
import 'package:crm/presentation/freight_product/items/freight_product.items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'controllers/freight_product.controller.dart';

class FreightProductScreen extends GetView<FreightProductController> {
  const FreightProductScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        title: 'Freight Product',
      ),
      backgroundColor: ColorsName.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FreightProductFilter(),
            SizedBox(height: 6.h),
            FreightProductItems(),
          ],
        ),
      ),
    );
  }
}
