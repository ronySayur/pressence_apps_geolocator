// ignore_for_file: prefer_const_constructors

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
          IconButton(
              onPressed: () => Get.toNamed(Routes.ADD_PEGAWAI),
              icon: wAppIcon(
                icon: Icons.person,
                size: wDimension.iconSize24,
              ))
        ],
      ),
      body: Stack(
        children: [Container()],
      ),
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
