import 'package:flutter/material.dart';
import 'package:yogo_pos/app/widgets/custom_btn.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: PrimaryBtn(
          onPressed: () {
            controller.login();
          },
          text: "Go to OLO"),
    );
  }
}
