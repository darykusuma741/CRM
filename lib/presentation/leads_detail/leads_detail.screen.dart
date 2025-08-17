import 'package:crm/common/components/custom_scaffold.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/presentation/leads_detail/button/leads_detail.button.dart';
import 'package:crm/presentation/leads_detail/header/leads_detail.header.dart';
import 'package:crm/presentation/leads_detail/items/leads_detail.items.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/leads_detail.controller.dart';

class LeadsDetailScreen extends GetView<LeadsDetailController> {
  const LeadsDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      light: true,
      // appBar: CustomAppBar(
      //   title: const Text('LeadsDetailScreen'),
      //   centerTitle: true,
      // ),
      backgroundColor: ColorsName.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LeadsDetailHeader(),
                LeadsDetailItems(),
              ],
            ),
          ),
          LeadsDetailButton(),
        ],
      ),
    );
  }
}
