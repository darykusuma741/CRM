import 'package:crm/common/components/custom_scaffold.dart';
import 'package:crm/common/constants/colors_name.dart';
import 'package:crm/presentation/home/controllers/home.controller.dart';
import 'package:crm/presentation/home/profile/header/home.profile.header.dart';
import 'package:crm/presentation/home/profile/menu/home.profile.menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeProfile extends GetView<HomeController> {
  const HomeProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      light: true,
      backgroundColor: ColorsName.graySoft,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeProfileHeader(),
            HomeProfileMenu(),
          ],
        ),
      ),
    );
  }
}
