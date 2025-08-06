import 'package:crm/common/components/custom_button.dart';
import 'package:crm/presentation/login/controllers/login.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginFormButton extends GetView<LoginController> {
  const LoginFormButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      title: 'Login',
    );
  }
}
