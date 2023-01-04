import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pressence_apps_geolocator/app/widgets/widgets.dart';

import '../controllers/new_password_controller.dart';

class NewPasswordView extends GetView<NewPasswordController> {
  const NewPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('New Password'),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextField(
                autocorrect: false,
                controller: controller.newPassC,
                obscureText: true,
                decoration: const InputDecoration(
                    labelText: "New Password", border: OutlineInputBorder())),
            SizedBox(height: wDimension.height20),
            Obx(() => ElevatedButton(
                onPressed: () async {
                  if (controller.isLoading.isFalse) {
                    await controller.newPaswword();
                  }
                },
                child: controller.isLoading.isFalse
                    ? wSmallText(
                        text: "Login",
                        color: Colors.white,
                        weight: FontWeight.bold,
                      )
                    : wBigText(text: "Loading")))
          ],
        ));
  }
}
