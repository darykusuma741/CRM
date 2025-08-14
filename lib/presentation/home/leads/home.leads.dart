import 'package:crm/common/components/custom_scaffold.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/presentation/home/leads/header/home.header.leads.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeLeads extends GetView<HomeLeads> {
  const HomeLeads({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      light: true,
      backgroundColor: ColorsName.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            HomeHeaderLeads(),
          ],
        ),
      ),
    );
  }
}
