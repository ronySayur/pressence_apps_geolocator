// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pressence_apps_geolocator/app/widgets/widgets.dart';

import '../controllers/add_pegawai_controller.dart';

class AddPegawaiView extends GetView<AddPegawaiController> {
  const AddPegawaiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tambah Pegawai'),
          centerTitle: true,
        ),
        body: ListView(padding: EdgeInsets.all(wDimension.height20), children: [
          TextField(
            controller: controller.nipC,
            decoration:
                InputDecoration(labelText: "NIP", border: OutlineInputBorder()),
          ),
          SizedBox(height: 20),
          TextField(
            controller: controller.nameC,
            decoration: InputDecoration(
                labelText: "Name", border: OutlineInputBorder()),
          ),
          SizedBox(height: 20),
          TextField(
            controller: controller.jobC,
            decoration: InputDecoration(
                labelText: "Perkerjaan", border: OutlineInputBorder()),
          ),
          SizedBox(height: 20),
          TextField(
            controller: controller.emailC,
            decoration: InputDecoration(
                labelText: "Email", border: OutlineInputBorder()),
          ),
          SizedBox(height: 30),
          Obx(() => ElevatedButton(
              onPressed: () async {
                if (controller.isLoading.isFalse) {
                  await controller.addPegawai();
                }
              },
              child: controller.isLoading.isFalse
                  ? wSmallText(
                      text: "Tambah Pegawai",
                      color: Colors.white,
                      weight: FontWeight.bold,
                    )
                  : CircularProgressIndicator()))
        ]));
  }
}
