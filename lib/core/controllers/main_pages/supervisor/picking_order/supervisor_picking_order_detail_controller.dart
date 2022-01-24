import 'package:get/get.dart';
import 'package:sologwarehouseapp/core/controllers/main_pages/supervisor/picking_order/supervisor_picking_order_controller.dart';
import 'package:sologwarehouseapp/services/api_services.dart';
import 'package:sologwarehouseapp/static/api_url.dart';

import '../../supervisor_main_pages_controller.dart';

class SupervisorPickingOrderDetailController extends GetxController {
  static SupervisorPickingOrderDetailController get controller =>
      Get.find<SupervisorPickingOrderDetailController>();
  var pickingOrderId = Get.arguments['picking_order_id'];
  Map pickingDetail = {};
  bool isLoading = true;
  bool isLoadingChangeStatus = false;

  @override
  void onInit() {
    getPickingOrder();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getPickingOrder() async {
    pickingDetail.clear();
    isLoading = true;
    update();
    ApiServices apiServices = ApiServices();
    apiServices.getData(
      url: "${ApiUrl.pickingDetail}/$pickingOrderId",
      parameters: {},
    ).then((value) {
      pickingDetail.addAll(value.data);
      isLoading = false;
      update();
      print(value);
    }).catchError((err) {
      Get.find<SupervisorMainPagesController>().signOut();
      print(err);
    });
  }

  approvePickingOrder() async {
    pickingDetail.clear();
    isLoadingChangeStatus = true;
    update();
    ApiServices apiServices = ApiServices();
    apiServices
        .putDataWithToken(
      url: "${ApiUrl.pickingDetail}/$pickingOrderId/approve",
      parameters: {},
      isJson: false,
    )
        .then((value) {
      getPickingOrder();
      Get.find<SupervisorPickingOrderController>().getPickingOrder();
      print(value);
    }).catchError((err) {
      Get.find<SupervisorMainPagesController>().signOut();
      print(err);
    });
    isLoadingChangeStatus = false;
    update();
  }
}
