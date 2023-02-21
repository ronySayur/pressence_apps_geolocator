// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pressence_apps_geolocator/app/controllers/page_index_controller.dart';

import '../../../routes/app_pages.dart';
import '../../../widgets/widgets.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final pageC = Get.find<PageIndexController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
        actions: [
          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: controller.streamUser(),
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return SizedBox();
                }

                String role = snap.data!.data()!["role"];

                //jika ini admin
                if (role == "admin") {
                  return IconButton(
                    onPressed: () => Get.toNamed(Routes.PROFILE),
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
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: controller.streamUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasData) {
              Map<String, dynamic> user = snapshot.data!.data()!;
              String defaultImage =
                  "https://ui-avatars.com/api/?name=${user['name']}";
              return ListView(
                padding: EdgeInsets.all(20),
                children: [
                  Row(
                    children: [
                      ClipOval(
                        child: Container(
                          width: wDimension.width20 * 4,
                          height: wDimension.height20 * 4,
                          child: Image.network(
                            user["profile"] != null
                                ? user["profile"]
                                : defaultImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: wDimension.width10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          wBigText(
                            text: "Welcome",
                            weight: FontWeight.bold,
                          ),
                          Container(
                            width: wDimension.width20 * 10,
                            child: wSmallText(
                              text: user["position"] != null
                                  ? "${user['address']}"
                                  : "Belum ada lokasi.",
                              align: TextAlign.left,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: wDimension.height20),
                  Container(
                    padding: EdgeInsets.all(wDimension.height20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(wDimension.radius20),
                      color: Colors.grey[200],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        wBigText(
                            text: "${user['job']}", weight: FontWeight.bold),
                        SizedBox(height: 20),
                        wBigText(
                          text: "${user['nip']}",
                          weight: FontWeight.bold,
                          size: wDimension.font26,
                        ),
                        SizedBox(height: 10),
                        wBigText(text: "${user['name']}"),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: wDimension.height10,
                  ),
                  Container(
                    padding: EdgeInsets.all(wDimension.height20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(wDimension.radius20),
                      color: Colors.grey[200],
                    ),
                    child: StreamBuilder<
                            DocumentSnapshot<Map<String, dynamic>>>(
                        stream: controller.streamTodayPresence(),
                        builder: (context, snaptoday) {
                          if (snaptoday.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }

                          var dataToday = snaptoday.data!.data();
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(children: [
                                wSmallText(text: "Masuk"),
                                wSmallText(
                                    text: dataToday?["masuk"] == null
                                        ? "-"
                                        : "${DateFormat.jms().format(DateTime.parse(dataToday?['masuk']['date']))}")
                              ]),
                              Container(
                                width: wDimension.width10 / 5,
                                height: wDimension.height20 * 2,
                                color: Colors.grey,
                              ),
                              Column(children: [
                                wSmallText(text: "Keluar"),
                                                                wSmallText(
                                    text: dataToday?["keluar"] == null
                                        ? "-"
                                        : "${DateFormat.jms().format(DateTime.parse(dataToday?['keluar']['date']))}")
                              ]),
                            ],
                          );
                        }),
                  ),
                  SizedBox(height: wDimension.height20),
                  Divider(
                    color: Colors.grey[300],
                    thickness: 2,
                  ),
                  SizedBox(height: wDimension.height10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      wBigText(
                        text: "Last 5 Days",
                        weight: FontWeight.bold,
                        size: 18,
                      ),
                      TextButton(
                        onPressed: () {
                          Get.toNamed(Routes.ALL_PRESENSI);
                        },
                        child: wSmallText(text: "see more"),
                      )
                    ],
                  ),
                  SizedBox(height: wDimension.height10),
                  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: controller.streamLastPresence(),
                      builder: (context, snapPresence) {
                        if (snapPresence.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        
                        if (snapPresence.data?.docs.length == 0 ||
                            snapPresence.data == null) {
                          return SizedBox(
                            height: wDimension.height20 * 10,
                            child: Center(
                                child: Text("Belum ada histori presensi")),
                          );
                        }
                        return ListView.builder(
                          padding: EdgeInsets.all(10),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapPresence.data!.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            //Get data from json to map string dynamic
                            Map<String, dynamic> data =
                                snapPresence.data!.docs[index].data();
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Material(
                                borderRadius:
                                    BorderRadius.circular(wDimension.radius20),
                                color: Colors.grey[200],
                                child: InkWell(
                                  onTap: () {
                                    Get.toNamed(Routes.DETAIL_PRESENSI);
                                  },
                                  borderRadius: BorderRadius.circular(
                                      wDimension.radius20),
                                  child: Container(
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            wSmallText(
                                              text: "Masuk",
                                              weight: FontWeight.bold,
                                            ),
                                            wSmallText(
                                              text:
                                                  "${DateFormat.yMMMEd().format(DateTime.parse(data["date"]))}",
                                              weight: FontWeight.bold,
                                            )
                                          ],
                                        ),
                                        wSmallText(
                                            text: data['masuk']?['date'] == null
                                                ? "-"
                                                : "${DateFormat.jms().format(DateTime.parse(data['masuk']!['date']))}"),
                                        SizedBox(height: wDimension.height10),
                                        wSmallText(
                                          text: "Keluar",
                                          weight: FontWeight.bold,
                                        ),
                                        wSmallText(
                                            text: data['keluar']?['date'] ==
                                                    null
                                                ? "-"
                                                : "${DateFormat.jms().format(DateTime.parse(data['keluar']!['date']))}"),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }),
                ],
              );
            } else {
              return Center(child: Text("Tidak dapat memuat data"));
            }
          }),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.reactCircle,
        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.fingerprint, title: 'Add'),
          TabItem(icon: Icons.people, title: 'Profile'),
        ],
        initialActiveIndex: pageC.pageIndex.value,
        onTap: (int i) => pageC.changePage(i),
      ),
    );
  }
}
