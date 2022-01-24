import 'package:get/get.dart';
import 'package:sologwarehouseapp/core/controllers/main_pages/supervisor_main_pages_controller.dart';
import 'package:sologwarehouseapp/services/api_services.dart';
import 'package:sologwarehouseapp/static/api_url.dart';

class SupervisorStockOpnameDetailController extends GetxController {
  static SupervisorStockOpnameDetailController get controller =>
      Get.find<SupervisorStockOpnameDetailController>();

  Map stockOpnameDetail = {};
  bool isLoading = true;
  var stockOpnameId = Get.arguments["stock_opname_id"];

  bool isLoadingChangeStatus = false;

  @override
  void onInit() {
    getDetailStockOpname();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getDetailStockOpname() async {
    stockOpnameDetail.clear();
    isLoading = true;
    update();
    ApiServices apiServices = ApiServices();
    apiServices.getData(
      url: "${ApiUrl.stockOpnameDetail}/$stockOpnameId",
      parameters: {},
    ).then((value) {
      stockOpnameDetail.addAll(value.data);
      isLoading = false;
      update();
      // print(value);
    }).catchError((err) {
      Get.find<SupervisorMainPagesController>().signOut();
      print(err);
    });
  }

  approve() async {
    print("${ApiUrl.stockOpnameDetail}/$stockOpnameId/approve");
    isLoadingChangeStatus = true;
    update();
    ApiServices apiServices = ApiServices();
    apiServices
        .putDataWithToken(
            url: "${ApiUrl.stockOpnameDetail}/$stockOpnameId/approve",
            parameters: {},
            isJson: false)
        .then((value) {
      getDetailStockOpname();
      // Get.snackbar(
      //   null,
      //   value.data['message'].toString(),
      //   backgroundColor: Colors.red[400],
      //   colorText: Colors.white,
      //   snackPosition: SnackPosition.BOTTOM,
      //   snackStyle: SnackStyle.FLOATING,
      //   icon: Icon(
      //     Icons.warning,
      //     color: Colors.white,
      //   ),
      //   isDismissible: true,
      //   margin: EdgeInsets.only(bottom: 10, right: 10, left: 10),
      // );
    }).catchError((err) {
      Get.find<SupervisorMainPagesController>().signOut();

      print(err);
    });
    isLoadingChangeStatus = false;
    update();
  }
}
