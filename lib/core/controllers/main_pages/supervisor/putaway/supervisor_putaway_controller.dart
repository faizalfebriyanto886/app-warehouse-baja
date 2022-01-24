import 'package:get/get.dart';
import 'package:sologwarehouseapp/services/api_services.dart';
import 'package:sologwarehouseapp/static/api_url.dart';

import '../../supervisor_main_pages_controller.dart';

class SupervisorPutawayController extends GetxController {
  static SupervisorPutawayController get controller =>
      Get.find<SupervisorPutawayController>();

  List putAwayList = [];
  bool isLoading = true;

  @override
  void onInit() {
    getPutAway();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getPutAway() async {
    putAwayList.clear();
    isLoading = true;
    update();
    ApiServices apiServices = ApiServices();
    apiServices.getData(
      url: ApiUrl.putaway,
      parameters: {},
    ).then((value) {
      putAwayList.addAll(value.data['data']);
      isLoading = false;
      update();
      print(value);
    }).catchError((err) {
      Get.find<SupervisorMainPagesController>().signOut();
      print(err);
    });
  }
}
