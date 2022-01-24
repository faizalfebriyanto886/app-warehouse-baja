import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response, MultipartFile, FormData;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sologwarehouseapp/core/controllers/main_pages/supervisor/good_receiving/supervisor_good_receiving_controller.dart';
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
}
