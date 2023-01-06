import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pressence_apps_geolocator/app/widgets/widgets.dart';

import '../controllers/update_profile_controller.dart';

class UpdateProfileView extends GetView<UpdateProfileController> {
  final Map<String, dynamic> user = Get.arguments;
  @override
  Widget build(BuildContext context) {
    controller.nipC.text = user["nip"];
    controller.nameC.text = user["name"];
    controller.emailC.text = user["email"];

    return Scaffold(
        appBar: AppBar(
          title: const Text('Update Pegawai'),
          centerTitle: true,
        ),
        body: ListView(padding: EdgeInsets.all(wDimension.height20), children: [
          TextField(
            controller: controller.nipC,
            readOnly: true,
            decoration:
                InputDecoration(labelText: "NIP", border: OutlineInputBorder()),
          ),
          SizedBox(height: 20),
          TextField(
            controller: controller.emailC,
            readOnly: true,
            decoration: InputDecoration(
                labelText: "Email", border: OutlineInputBorder()),
          ),
          SizedBox(height: 20),
          TextField(
            controller: controller.nameC,
            decoration: InputDecoration(
                labelText: "Name", border: OutlineInputBorder()),
          ),
          SizedBox(height: wDimension.height20),
          wSmallText(text: "Photo Profile"),
          SizedBox(height: wDimension.height10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GetBuilder<UpdateProfileController>(
                builder: (c) {
                  if (c.image != null) {
                    return ClipOval(
                      child: Container(
                        height: wDimension.height20 * 5,
                        width: wDimension.width20 * 5,
                        child: Image.file(
                          File(c.image!.path),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  } else {
                    if (user["profile"] != null) {
                      return ClipOval(
                        child: Container(
                          height: wDimension.height20 * 5,
                          width: wDimension.width20 * 5,
                          child: Image.network(
                            user["profile"],
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    } else {
                      return Text("No Image choosen");
                    }
                  }
                },
              ),
              // user["profile"] != null && user["profile"] != ""
              //     ? Text("Foto Profil")
              //     : Text("no choosen"),
              TextButton(
                  onPressed: () {
                    controller.pickImage();
                  },
                  child: wSmallText(text: "choose"))
            ],
          ),
          SizedBox(height: wDimension.height30),
          Obx(() => ElevatedButton(
              onPressed: () async {
                if (controller.isLoading.isFalse) {
                  await controller.updateProfile(user["uid"]);
                }
              },
              child: controller.isLoading.isFalse
                  ? wSmallText(
                      text: "Update Pegawai",
                      color: Colors.white,
                      weight: FontWeight.bold,
                    )
                  : CircularProgressIndicator()))
        ]));
  }
}
