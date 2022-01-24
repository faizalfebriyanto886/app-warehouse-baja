import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  //controller username
  TextEditingController usernameController = TextEditingController();

  //boolean status apakah password bisa dilihat
  bool isPasswordVisible = false;
  static ForgotPasswordController get controller =>
      Get.find<ForgotPasswordController>();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  /*
  Method untuk mengecek validitas apakah username dan passoword sudah terisi
  */
  validation() {
    if (usernameController.text.isEmpty) {
      return Get.snackbar(
        "Oops!",
        "Mohon lengkapi username",
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        snackStyle: SnackStyle.FLOATING,
        icon: Icon(
          Icons.close,
          color: Colors.white,
        ),
        isDismissible: true,
        margin: EdgeInsets.only(bottom: 10, right: 10, left: 10),
      );
    } else {
      forgotPassword();
    }
  }

  forgotPassword() {}
}
