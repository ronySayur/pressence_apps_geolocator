// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../routes/app_pages.dart';
import '../../../widgets/widgets.dart';
import '../controllers/all_presensi_controller.dart';

class AllPresensiView extends GetView<AllPresensiController> {
  const AllPresensiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Semua Presensi'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          //Search
          Padding(
            padding: const EdgeInsets.all(20),
            child: Card(
              shape: StadiumBorder(),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Search..."),
              ),
            ),
          ),

          //List View
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Material(
                    borderRadius: BorderRadius.circular(wDimension.radius20),
                    color: Colors.grey[200],
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(Routes.DETAIL_PRESENSI);
                      },
                      borderRadius: BorderRadius.circular(wDimension.radius20),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                wSmallText(
                                  text: "Masuk",
                                  weight: FontWeight.bold,
                                ),
                                wSmallText(
                                  text:
                                      "${DateFormat.yMMMEd().format(DateTime.now())}",
                                  weight: FontWeight.bold,
                                )
                              ],
                            ),
                            wSmallText(
                                text:
                                    "${DateFormat.jms().format(DateTime.now())}"),
                            SizedBox(height: wDimension.height10),
                            wSmallText(
                              text: "Keluar",
                              weight: FontWeight.bold,
                            ),
                            wSmallText(
                                text:
                                    "${DateFormat.jms().format(DateTime.now())}"),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
