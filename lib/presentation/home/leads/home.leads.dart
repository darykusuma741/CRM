import 'package:crm/common/components/custom_floating_action_container.dart';
import 'package:crm/common/components/custom_scaffold.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/infrastructure/navigation/routes.dart';
import 'package:crm/presentation/home/leads/category/home.leads.category.dart';
import 'package:crm/presentation/home/leads/header/home.header.leads.dart';
import 'package:crm/presentation/home/leads/items/home.leads.items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeLeads extends GetView<HomeLeads> {
  const HomeLeads({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      light: true,
      backgroundColor: ColorsName.white,
      floatingActionButton: CustomFloatingActionContainer(onTap: () {
        Get.toNamed(Routes.LEADS_FORM);
      }),
      body: Column(
        children: [
          HomeHeaderLeads(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10.h),
                  HomeLeadsCategory(),
                  SizedBox(height: 14.h),
                  HomeLeadsItems(),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
