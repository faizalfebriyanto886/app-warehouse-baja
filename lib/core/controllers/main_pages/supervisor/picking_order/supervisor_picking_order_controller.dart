import 'package:get/get.dart';
import 'package:sologwarehouseapp/services/api_services.dart';
import 'package:sologwarehouseapp/static/api_url.dart';

import '../../supervisor_main_pages_controller.dart';

class SupervisorPickingOrderController extends GetxController {
  static SupervisorPickingOrderController get controller =>
      Get.find<SupervisorPickingOrderController>();

  List pickingList = [];
  bool isLoading = true;

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
    pickingList.clear();
    isLoading = true;
    update();
    ApiServices apiServices = ApiServices();
    apiServices.getData(
      url: ApiUrl.picking,
      parameters: {},
    ).then((value) {
      pickingList.addAll(value.data['data']);
      isLoading = false;
      update();
      print(value);
    }).catchError((err) {
      print(err.response);
      Get.find<SupervisorMainPagesController>().signOut();
    });
  }
}
