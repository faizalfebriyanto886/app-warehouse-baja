import 'package:get/get.dart';
import 'package:sologwarehouseapp/core/controllers/main_pages/supervisor_main_pages_controller.dart';
import 'package:sologwarehouseapp/services/api_services.dart';
import 'package:sologwarehouseapp/static/api_url.dart';

class GeneralPageListRackController extends GetxController {
  static GeneralPageListRackController get controller =>
      Get.find<GeneralPageListRackController>();

  var warehouseId = Get.arguments['warehouse_id'];

  List rackList = [];
  bool isLoading = true;

  @override
  void onInit() {
    getRack();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getRack() async {
    rackList.clear();
    isLoading = true;
    update();
    ApiServices apiServices = ApiServices();
    apiServices.getData(
      url: ApiUrl.rack,
      parameters: {
        "warehouse_id": warehouseId == null ? "" : warehouseId,
      },
    ).then((value) {
      rackList.addAll(value.data['rack']);
      isLoading = false;
      update();
      print(value);
    }).catchError((err) {
      Get.find<SupervisorMainPagesController>().signOut();
      print(err);
    });
  }
}
