import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scan/scan.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sologwarehouseapp/core/views/authentication/sign_in.dart';
import 'package:sologwarehouseapp/core/views/main_pages/supervisor/scanner/supervisor_detail_item_scan_view.dart';

class SupervisorMainPagesController extends GetxController {
  static SupervisorMainPagesController get controller =>
      Get.find<SupervisorMainPagesController>();

  ScanController scanController = ScanController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  scan(context) async {
    await [Permission.camera].request();
    var status = await Permission.camera.status;
    if (status.isDenied) {
    } else if (status.isGranted) {
      Get.bottomSheet(
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(
                bottom: 25,
              ),
              child: FloatingActionButton(
                elevation: 0,
                backgroundColor: Colors.white,
                onPressed: () {
                  Get.back();
                },
                child: Icon(
                  Icons.close,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.55,
              child: ScanView(
                controller: scanController,
// custom scan area, if set to 1.0, will scan full area
                scanAreaScale: .8,
                scanLineColor: Colors.green.shade400,
                onCapture: (data) {
                  Get.back();
                  Get.to(
                    () => SupervisorDetailItemScanView(),
                    arguments: {
                      "item_code": data.toString(),
                    },
                  );
                },
              ),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
      );
      // FlutterBarcodeScanner.getBarcodeStreamReceiver(
      //   "#000000",
      //   "Cancel",
      //   true,
      //   ScanMode.DEFAULT,
      // )?.listen((barcode) {
      //   if (barcode != null) {
      //     print(barcode);
      //     Get.to(
      //       () => SupervisorDetailItemScanView(),
      //       arguments: {
      //         "item_code": barcode.toString(),
      //       },
      //     );
      //   }
      // });
    }
  }

  signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear().whenComplete(() => Get.offAll(() => SignIn()));
    update();
  }
}
