import 'package:get/get.dart';
import 'package:sologwarehouseapp/services/api_services.dart';
import 'package:sologwarehouseapp/static/api_url.dart';

import '../../../supervisor_main_pages_controller.dart';

class SupervisorListItemToAddPutawayByWarehouseIdController
    extends GetxController {
  static SupervisorListItemToAddPutawayByWarehouseIdController get controller =>
      Get.find<SupervisorListItemToAddPutawayByWarehouseIdController>();
  var warehouseId = Get.arguments['warehouse_id'];
  List itemList = [];
  bool isLoading = true;
  bool needReset = false;

  @override
  void onInit() {
    getItem();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getItem() async {
    itemList.clear();
    isLoading = true;
    update();
    ApiServices apiServices = ApiServices();
    apiServices.getData(
      url: ApiUrl.itemListForNewPutawayByWarehouseId,
      parameters: {
        "warehouse_id": warehouseId == null ? "" : warehouseId,
      },
    ).then((value) {
      itemList.addAll(value.data['data']);
      update();
      print(value);
    }).catchError((err) {
      Get.find<SupervisorMainPagesController>().signOut();
      print(err);
    });
  }
}
