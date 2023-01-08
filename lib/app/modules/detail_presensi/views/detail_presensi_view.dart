// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pressence_apps_geolocator/app/widgets/widgets.dart';

import '../controllers/detail_presensi_controller.dart';

class DetailPresensiView extends GetView<DetailPresensiController> {
  const DetailPresensiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail Presensi'),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.all(wDimension.radius20),
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(wDimension.radius20),
                  color: Colors.grey[200]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: wSmallText(
                      text: "${DateFormat.yMMMMEEEEd().format(DateTime.now())}",
                      weight: FontWeight.bold,
                      size: 17,
                    ),
                  ),
                  SizedBox(height: wDimension.height20),
                  wSmallText(text: "Masuk", weight: FontWeight.bold),
                  wSmallText(
                      text: "${DateFormat.jms().format(DateTime.now())}"),
                  wSmallText(text: "Posisi: "),
                  wSmallText(text: "Status: Di dalam area"),

                  //
                  SizedBox(height: wDimension.height20),
                  wSmallText(text: "Keluar", weight: FontWeight.bold),
                  wSmallText(
                      text: "${DateFormat.jms().format(DateTime.now())}"),
                  wSmallText(text: "Posisi: "),
                  wSmallText(text: "Status: Di dalam area"),
                ],
              ),
            ),
          ],
        ));
  }
}
