// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../widgets/widgets.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
        actions: [
          //buat ada dan tiada
          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: controller.streamRole(),
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return SizedBox();
                }

                String role = snap.data!.data()!["role"];

                //jika ini admin
                if (role == "admin") {
                  return IconButton(
                    onPressed: () => Get.toNamed(Routes.ADD_PEGAWAI),
                    icon: wAppIcon(
                      icon: Icons.person,
                      size: wDimension.iconSize24,
                    ),
                  );
                } else {
                  return SizedBox();
                }
              }),
        ],
      ),
      body: Container(),
      floatingActionButton: Obx(() => FloatingActionButton(
            onPressed: () async {
              if (controller.isLoading.isFalse) {
                controller.isLoading.value = true;
                await FirebaseAuth.instance.signOut();
                controller.isLoading.value = false;
                Get.offAllNamed(Routes.LOGIN);
              }
            },
            child: controller.isLoading.isFalse
                ? wAppIcon(icon: Icons.logout)
                : CircularProgressIndicator(),
          )),
    );
  }
}
