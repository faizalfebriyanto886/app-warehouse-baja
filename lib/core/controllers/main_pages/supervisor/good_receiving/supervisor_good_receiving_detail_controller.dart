import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response, MultipartFile, FormData;
import 'package:permission_handler/permission_handler.dart';
import 'package:scan/scan.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sologwarehouseapp/core/controllers/main_pages/supervisor/good_receiving/supervisor_good_receiving_controller.dart';
import 'package:sologwarehouseapp/core/views/main_pages/supervisor/scanner/supervisor_detail_item_scan_view.dart';
import 'package:sologwarehouseapp/services/api_services.dart';
import 'package:sologwarehouseapp/static/api_url.dart';
import 'package:sologwarehouseapp/static/shared_preferences_key.dart';

import '../../supervisor_main_pages_controller.dart';

class SupervisorGoodReceivingDetailController extends GetxController {
  static SupervisorGoodReceivingDetailController get controller =>
      Get.find<SupervisorGoodReceivingDetailController>();

  var goodReceivingId = Get.arguments['good_receiving_id'];
  // var putawayId = Get.arguments['putaway_id'];
  Map goodReceivingDetail = {};
  bool isLoading = true;
  bool isLoadingApprove = false;
  bool itemsCheck = false;
  ScanController scanController = ScanController();
  
  List<bool> isChecked = [];


  @override
  // TODO: implement listeners
  int get listeners => super.listeners;

  @override
  void onInit() {
    getGoodReceivingDetail();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getGoodReceivingDetail() {
    goodReceivingDetail.clear();
    isLoading = true;
    update();
    ApiServices apiServices = ApiServices();
    apiServices.getData(
      url: "${ApiUrl.receiptDetail}/$goodReceivingId",
      parameters: {},
    ).then((value) {
      goodReceivingDetail.addAll(value.data);
      for (var i = 0; i < goodReceivingDetail['detail'].length; i ++) {
        isChecked.add(false);
      }
      isLoading = false;
      update();
      print(goodReceivingDetail['item']['status']);
    }).catchError((err) {
      Get.find<SupervisorMainPagesController>().signOut();
      print(err);
    });
  }

  approveReceipt() async {
    isLoadingApprove = true;
    update();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String tokenType = preferences.getString(SharedPreferencesKey.tokenType)!;
    String accessToken =
        preferences.getString(SharedPreferencesKey.accessToken)!;
    String tokenTypeWithAccessToken = "$tokenType $accessToken";
    // print(tokenTypeWithAccessToken);

    //initializing Dio
    Dio dio = Dio();

    //add header dio authorization
    dio.options.headers["Authorization"] = tokenTypeWithAccessToken;

    //initializing response
    try {
      Response response = await dio.post(
        "${ApiUrl.receiveApprove}/$goodReceivingId",
        data: {},
      );
      getGoodReceivingDetail();
      Get.find<SupervisorGoodReceivingController>().getGoodReceiveList();
      print("Response :$response");
    } on DioError catch (e) {
      Get.snackbar(
        "Oops!",
        // errorValue.toString(),
        e.response!.data['message'].toString(),
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
      print(e.response);
    }
    isLoadingApprove = false;
    update();
  }

  cekItems(value){  
    // if(!value){
    //   itemsCheck = value;
    // }
    if (itemsCheck == true) {
      Get.snackbar(
        "Success", 
        "Data barang ditemukan",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.2),
        colorText: Colors.green,
        margin: EdgeInsets.only(bottom: 10)
      );
    } else {
      Get.snackbar(
        "Failed",
        "Data barang tidak ditemukan",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.2),
        colorText: Colors.red,
        margin: EdgeInsets.only(bottom: 10, left: 10, right: 10)
      );
    }
    print(value);
    update();
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
                  print(data.toString());
                  cekItems(context);
                  scanController.resume();
                  // Get.to(
                  //   () => SupervisorDetailItemScanView(),
                  //   arguments: {
                  //     "item_code": data.toString(),
                  //   },
                  // );
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
}


