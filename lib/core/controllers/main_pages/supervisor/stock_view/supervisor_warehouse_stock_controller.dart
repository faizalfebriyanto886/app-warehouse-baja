import 'package:get/get.dart';
import 'package:sologwarehouseapp/services/api_services.dart';
import 'package:sologwarehouseapp/static/api_url.dart';

import '../../supervisor_main_pages_controller.dart';

class SupervisorWarehouseStockController extends GetxController {
  static SupervisorWarehouseStockController get controller =>
      Get.find<SupervisorWarehouseStockController>();

  var warehouseId = Get.arguments['warehouse_id'];
  var warehouseName = Get.arguments['warehouse_name'];
  List stockList = [];
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
    isLoading = true;
    update();
    ApiServices apiServices = ApiServices();
    apiServices.getData(
      url: ApiUrl.stockListByWarehouseId,
      parameters: {"warehouse_id": warehouseId},
    ).then((value) {
      stockList.addAll(value.data['data']);
      isLoading = false;
      update();
      print(value);
    }).catchError((err) {
      Get.find<SupervisorMainPagesController>().signOut();
      print(err);
    });
  }
}
