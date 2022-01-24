import 'dart:async';
import 'package:sologwarehouseapp/core/views/authentication/sign_in.dart';
import 'package:sologwarehouseapp/core/views/main_pages/supervisor_main_pages_view.dart';
import 'package:sologwarehouseapp/static/shared_preferences_key.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashscreenController extends GetxController {
  static SplashscreenController get controller =>
      Get.find<SplashscreenController>();

  // * status untuk mengetahui apakah aplikasi sudah dalam keadaan login atau belum
  bool isLoggedIn = false;

  // * Method untuk mendapatkan status login dari shared preferences
  getStatusLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // check apakah shared preferences isLoggedIn tidak kosong?
    if (prefs.getBool(SharedPreferencesKey.isLoggedIn) != null) {
      // jika tidak kosong maka, maka shared preferences isLoggedIn akan di cek
      // apakah valuenya true atau false
      if (prefs.getBool(SharedPreferencesKey.isLoggedIn)!) {
        isLoggedIn = true;
      } else {
        isLoggedIn = false;
      }
    }
    update();
    onDoneLoading();
  }

  // * Method yang dijalankan setelah mendapatkan status login
  onDoneLoading() {
    // jika isLoggedIn sudah bernilai true
    // maka akan redirect ke main pages
    // jika false akan redirect ke signIn
    Timer(Duration(milliseconds: 2000), () {
      if (isLoggedIn) {
        Get.off(() => SupervisorMainPagesView());
      } else {
        Get.off(() => SignIn());
      }
    });
  }

  @override
  void onInit() {
    getStatusLogin();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
