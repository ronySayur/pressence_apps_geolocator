// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pressence_apps_geolocator/app/widgets/widgets.dart';

class AddPegawaiController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadingAddPegawai = false.obs;
  //Factorismo Home
  TextEditingController nipC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passAdminC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> prosesAddPegawai() async {
    if (passAdminC.text.isNotEmpty) {
      isLoadingAddPegawai.value = true;
      try {
        String emailAdmin = auth.currentUser!.email!;

        UserCredential userCredentialAdmin =
            await auth.signInWithEmailAndPassword(
          email: emailAdmin,
          password: passAdminC.text,
        );

        UserCredential pegawaiCredential =
            await auth.createUserWithEmailAndPassword(
          email: emailC.text,
          password: "password",
        );

        //Input ke firestore
        if (pegawaiCredential.user != null) {
          String uid = pegawaiCredential.user!.uid;

          firestore.collection("pegawai").doc(uid).set({
            "nip": nipC.text,
            "name": nameC.text,
            "password": "password",
            "email": emailC.text,
            "uid": uid,
            "createdAt": DateTime.now().toIso8601String()
          });

          await pegawaiCredential.user!.sendEmailVerification();

          await auth.signOut();

          UserCredential userCredentialAdmin =
              await auth.signInWithEmailAndPassword(
            email: emailAdmin,
            password: passAdminC.text,
          );

          Get.back();
          Get.back();
          Get.snackbar("Berhhasil", "Berhasil menambahkan data pegawai");
        }
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;

        if (e.code == 'weak-password') {
          Get.snackbar("Peringatan", "Password yang digunakan terlalu lemah");
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          Get.snackbar("Peringatan", "Akun sudah ada");
          print('The account already exists for that email.');
        } else if (e.code == 'wrong-password') {
          Get.snackbar(
              "Terjadi Kesalahan", "Admin tidak dapat login. password salah");
        } else {
          Get.snackbar("Terjadi Kesalahan", e.code);
        }
      } catch (e) {
        print(e);
      }
    } else {
      Get.snackbar("Terjadi Kesalahan", "Password wajib diisi");
    }
  }

  Future<void> addPegawai() async {
    if (nipC.text.isNotEmpty &&
        nameC.text.isNotEmpty &&
        emailC.text.isNotEmpty) {
      isLoading.value = true;
      Get.defaultDialog(
          title: "Valdiasi admin",
          content: Column(
            children: [
              wSmallText(text: "masukan password untuk validasi"),
              SizedBox(height: wDimension.height10),
              TextField(
                controller: passAdminC,
                autocorrect: false,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "Password", border: OutlineInputBorder()),
              ),
              OutlinedButton(
                  onPressed: () async {
                    isLoading.value = false;
                    Get.back();
                  },
                  child: Text("Cancel")),
              Obx(() => ElevatedButton(
                  onPressed: () async {
                    if (isLoadingAddPegawai.isFalse) {
                      await prosesAddPegawai();
                    }
                    isLoading.value = false;
                  },
                  child: Text(isLoadingAddPegawai.isFalse
                      ? "Add Pegawai"
                      : "Loading..")))
            ],
          ));
    } else {
      Get.snackbar("Error", "Terjadi kesalahan");
    }
  }
}
