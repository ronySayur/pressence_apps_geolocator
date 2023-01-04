// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pressence_apps_geolocator/app/widgets/widgets.dart';

import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;

  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> login() async {
    if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: emailC.text,
          password: passC.text,
        );

        //Verifikasi email
        if (userCredential.user != null) {
          if (userCredential.user!.emailVerified == true) {
          isLoading.value = false;
            if (passC.text == "password") {
              Get.snackbar("Peringatan", "Ubah password anda");
              Get.offAllNamed(Routes.NEW_PASSWORD);
            } else {
              Get.offAllNamed(Routes.HOME);
            }
          } else {
            Get.defaultDialog(
                title: "Peringatan",
                middleText:
                    "akun belum di Verifikasi. kirim verifikasi sekarang!",
                actions: [
                  OutlinedButton(
                      onPressed: () {
                        isLoading.value = false;
                        Get.back();
                      },
                      child: wSmallText(text: "Cancel")),
                  ElevatedButton(
                      onPressed: () async {
                        try {
                          isLoading.value = false;
                          Get.snackbar("Berhasil", "Cek Email anda!");
                          await userCredential.user!.sendEmailVerification();
                          Get.back();
                        } catch (e) {
                          isLoading.value = false;
                          Get.snackbar("Error", "$e");
                        }
                      },
                      child: wSmallText(
                        text: "Kirim",
                        color: Colors.white,
                      )),
                ]);
          }
        }
          isLoading.value = false;
      } on FirebaseAuthException catch (e) {
          isLoading.value = false;
        if (e.code == 'user-not-found') {
          Get.snackbar("Terjadi Kesalahan!", "Email tidak terdaftar");
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
          Get.snackbar("Terjadi Kesalahan!", "Password salah!");
        }
      } catch (e) {
          isLoading.value = false;
        print('$e');
      }
    } else {
      Get.snackbar("Terjadi Kesalahan!", "Email dan password wajib diisi");
    }
  }
}
