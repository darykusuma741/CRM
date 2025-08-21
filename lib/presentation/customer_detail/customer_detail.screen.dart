import 'package:crm/common/components/custom_scaffold.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/presentation/customer_detail/header/customer_detail.header.dart';
import 'package:crm/presentation/customer_detail/information/customer_detail.information.dart';
import 'package:crm/presentation/customer_detail/tab_bar/customer_detail.tab_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/customer_detail.controller.dart';

class CustomerDetailScreen extends GetView<CustomerDetailController> {
  const CustomerDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: CustomScaffold(
        appBar: CustomAppBar(
          title: 'Customer Detail',
          actions: [
            IconButton(onPressed: controller.onPressMore, icon: Icon(Icons.more_vert_rounded)),
          ],
        ),
        backgroundColor: ColorsName.white,
        body: Column(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  CustomerDetailHeader(),
                  CustomerDetailTabBar(),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  CustomerDetailInformation(),
                  Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
