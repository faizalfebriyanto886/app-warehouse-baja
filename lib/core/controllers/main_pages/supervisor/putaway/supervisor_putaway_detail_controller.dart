import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response, MultipartFile, FormData;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sologwarehouseapp/core/controllers/main_pages/supervisor/putaway/supervisor_putaway_controller.dart';
import 'package:sologwarehouseapp/services/api_services.dart';
import 'package:sologwarehouseapp/static/api_url.dart';
import 'package:sologwarehouseapp/static/shared_preferences_key.dart';

import '../../supervisor_main_pages_controller.dart';

class SupervisorPutawayDetailController extends GetxController {
  static SupervisorPutawayDetailController get controller =>
      Get.find<SupervisorPutawayDetailController>();
  var putawayId = Get.arguments['putaway_id'];
  Map putAwayDetail = {};
  bool isLoading = true;
  bool isLoadingChangeStatus = false;

  @override
  void onInit() {
    getDetail();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getDetail() async {
    putAwayDetail.clear();
    isLoading = true;
    update();
    ApiServices apiServices = ApiServices();
    apiServices.getData(
      url: "${ApiUrl.putawayDetail}/$putawayId",
      parameters: {},
    ).then((value) {
      putAwayDetail.addAll(value.data);
      isLoading = false;
      update();
      print(value);
    }).catchError((err) {
      Get.find<SupervisorMainPagesController>().signOut();
      print(err);
    });
  }

  changeStatusToItemOut() async {
    isLoadingChangeStatus = true;
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
        "${ApiUrl.putawayItemOut}/$putawayId",
        data: {},
      );
      getDetail();
      Get.find<SupervisorPutawayController>().getPutAway();
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
    isLoadingChangeStatus = false;
    update();
  }

  changeStatusToItemIn() async {
    isLoadingChangeStatus = true;
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
        "${ApiUrl.putawayItemIn}/$putawayId",
        data: {},
      );
      getDetail();
      Get.find<SupervisorPutawayController>().getPutAway();
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
    isLoadingChangeStatus = false;
    update();
  }
}
