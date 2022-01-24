import 'package:get/get.dart';
import 'package:sologwarehouseapp/services/api_services.dart';
import 'package:sologwarehouseapp/static/api_url.dart';

import '../../supervisor_main_pages_controller.dart';

class SupervisorStockOverviewController extends GetxController {
  static SupervisorStockOverviewController get controller =>
      Get.find<SupervisorStockOverviewController>();

  List warehouseList = [];
  bool isLoading = true;

  @override
  void onInit() {
    getWarehouse();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getWarehouse() async {
    warehouseList.clear();
    isLoading = true;
    update();
    ApiServices apiServices = ApiServices();
    apiServices.getData(
      url: ApiUrl.warehouseList,
      parameters: {},
    ).then((value) {
      warehouseList.addAll(value.data['warehouse']);
      isLoading = false;
      update();
      print(value);
    }).catchError((err) {
      Get.find<SupervisorMainPagesController>().signOut();
      print(err);
    });
  }
}
