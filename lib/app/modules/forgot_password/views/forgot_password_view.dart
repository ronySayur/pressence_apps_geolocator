// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../widgets/widgets.dart';
import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
        centerTitle: true,
      ),
      body: ListView(padding: EdgeInsets.all(20), children: [
        TextField(
            autocorrect: false,
            controller: controller.emailC,
            decoration: InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(),
            )),
        SizedBox(height: wDimension.height10),
        Obx(() => ElevatedButton(
            onPressed: () async {
              if (controller.isLoading.isFalse) {
                await controller.sendEmail();
              }
            },
            child: controller.isLoading.isFalse
                ? wSmallText(
                    text: "Login",
                    color: Colors.white,
                    weight: FontWeight.bold,
                  )
                : wBigText(text: "Loading")))
      ]),
    );
  }
}
