import 'package:sologwarehouseapp/core/views/main_pages/supervisor_main_pages_view.dart';
import 'package:sologwarehouseapp/services/api_services.dart';
import 'package:sologwarehouseapp/static/api_url.dart';
import 'package:sologwarehouseapp/static/shared_preferences_key.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInController extends GetxController {
  //controller username
  TextEditingController usernameController = TextEditingController();

  //controller password
  TextEditingController passwordController = TextEditingController();

  //boolean status apakah password bisa dilihat
  bool isPasswordVisible = false;

  //boolean untuk status proses login
  bool isLoading = false;

  static SignInController get controller => Get.find<SignInController>();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /*
  Method untuk mengubah visibilitas password
  */
  changeVisibilityPassword() {
    isPasswordVisible = !isPasswordVisible;

    //update adalah method bawaan dari Framework GetX untuk mengupdate state
    update();
  }

  /*
  Method untuk mengecek validitas apakah username dan passoword sudah terisi
  */
  validation() async {
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      return Get.snackbar(
        "Oops!",
        "Mohon lengkapi username ataupun katasandi",
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        snackStyle: SnackStyle.FLOATING,
        icon: Icon(
          Icons.warning,
          color: Colors.white,
        ),
        isDismissible: true,
        margin: EdgeInsets.only(bottom: 10, right: 10, left: 10),
      );
    } else {
      signIn();
    }
  }

  signIn() {
    isLoading = true;
    update();
    ApiServices apiServices = ApiServices();
    apiServices
        .postData(
      url: ApiUrl.signIn,
      parameters: {
        "username": usernameController.text.toString().trim(),
        "password": passwordController.text.toString().trim(),
      },
      isJson: true,
    )
        .then((value) async {
      isLoading = false;
      update();
      var data = value.data;
      print(data);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(SharedPreferencesKey.accessToken, data['api_token']);
      prefs.setString(SharedPreferencesKey.tokenType, "Bearer");
      prefs.setBool(SharedPreferencesKey.isLoggedIn, true);
      Get.off(() => SupervisorMainPagesView());
    }).catchError((errorValue) {
      isLoading = false;
      update();
      Get.snackbar(
        "Oops!",
        "Username atau katasandi mungkin salah",
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
        duration: Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
        snackStyle: SnackStyle.FLOATING,
        icon: Icon(
          Icons.warning,
          color: Colors.white,
        ),
        isDismissible: true,
        margin: EdgeInsets.only(bottom: 10, right: 10, left: 10),
      );
    });
  }
}
