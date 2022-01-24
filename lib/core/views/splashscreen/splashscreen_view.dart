import 'package:sologwarehouseapp/core/controllers/splashscreen/splashscreen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashscreenView extends StatelessWidget {
  final SplashscreenController controller = Get.put(SplashscreenController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (_) {
        return Scaffold(
          backgroundColor: Colors.white,
          // bottomNavigationBar: Container(
          //   color: ColorApp.mainColorApp,
          //   height: 50,
          //   child: Text(
          //     "Fleet Management System\nv0.0.1",
          //     textAlign: TextAlign.center,
          //     style: TextStyle(
          //       color: Colors.white,
          //       fontSize: 12,
          //       fontWeight: FontWeight.normal,
          //     ),
          //   ),
          // ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Image.asset(
                    "assets/images/logo/logo_solog.png",
                    // width: 140,
                  ),
                ),
                // Container(
                //   margin: EdgeInsets.only(top: 20),
                //   child: Text(
                //     "Solog WMS",
                //     textAlign: TextAlign.center,
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontSize: 22,
                //       fontWeight: FontWeight.w600,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
