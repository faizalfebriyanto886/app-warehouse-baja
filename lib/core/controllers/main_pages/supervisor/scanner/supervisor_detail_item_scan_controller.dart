import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sologwarehouseapp/static/api_url.dart';
import 'package:sologwarehouseapp/static/shared_preferences_key.dart';

class SupervisorDetailItemScanController extends GetxController {
  static SupervisorDetailItemScanController get controller =>
      Get.find<SupervisorDetailItemScanController>();

  var itemCode = Get.arguments['item_code'];
  Map detailItem = {};
  bool isLoading = true;
  @override
  void onInit() {
    getDetailItem();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getDetailItem() async {
    detailItem.clear();
    isLoading = true;
    update();
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String tokenType = preferences.getString(SharedPreferencesKey.tokenType)!;
      String accessToken =
          preferences.getString(SharedPreferencesKey.accessToken)!;
      String tokenTypeWithAccessToken = "$tokenType $accessToken";
      print(tokenTypeWithAccessToken);

      //initializing Dio
      Dio dio = Dio();

      //add header dio authorization
      dio.options.headers["Authorization"] = tokenTypeWithAccessToken;
      Response response = await dio.get(
        "${ApiUrl.barcode}?barcode=$itemCode",
      );
      if (response.data['message'] == "OK") {
        detailItem.addAll(response.data['data']);
        update();
      }
      print(response);
    } on DioError catch (e) {
      print(e);
    }
    isLoading = false;
    update();
  }
}
