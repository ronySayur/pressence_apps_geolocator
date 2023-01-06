import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pressence_apps_geolocator/app/widgets/widgets.dart';

import '../controllers/update_password_controller.dart';

class UpdatePasswordView extends GetView<UpdatePasswordController> {
  const UpdatePasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Update Password'),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.all(wDimension.height10),
          children: [
            SizedBox(height: wDimension.height10),
            TextField(
                controller: controller.currC,
                obscureText: true,
                autocorrect: false,
                decoration: InputDecoration(
                    labelText: "Current Password",
                    border: OutlineInputBorder())),
            SizedBox(height: wDimension.height10),
            TextField(
                obscureText: true,
                autocorrect: false,
                controller: controller.newC,
                decoration: InputDecoration(
                    labelText: "New Password", border: OutlineInputBorder())),
            SizedBox(height: wDimension.height10),
            TextField(
                controller: controller.confirmC,
                obscureText: true,
                autocorrect: false,
                decoration: InputDecoration(
                    labelText: "Confirm Password",
                    border: OutlineInputBorder())),
            Obx(
              () => ElevatedButton(
                  onPressed: () {
                    if (controller.isLoading.isFalse) {
                      controller.updatePass;
                    }
                  },
                  child: Text((controller.isLoading.isFalse)
                      ? "Change Password"
                      : "Loading..")),
            )
          ],
        ));
  }
}
