import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController emailC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> sendEmail() async {
    if (emailC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        await auth.sendPasswordResetEmail(email: emailC.text);
        Get.back();
        Get.snackbar("Berhasil", "cek email anda");
      } catch (e) {
        Get.snackbar("Peringatan", "$e");
      } finally {
        isLoading.value = false;
      }
    } else {
      Get.snackbar("Peringatan!", "Email tidak boleh kosong");
    }
  }
}
