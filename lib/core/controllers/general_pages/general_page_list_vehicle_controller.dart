import 'package:get/get.dart';
import 'package:sologwarehouseapp/core/controllers/main_pages/supervisor_main_pages_controller.dart';
import 'package:sologwarehouseapp/services/api_services.dart';
import 'package:sologwarehouseapp/static/api_url.dart';

class GeneralPageListVehicleController extends GetxController {
  static GeneralPageListVehicleController get controller =>
      Get.find<GeneralPageListVehicleController>();

  List vehicleList = [];
  bool isLoading = true;

  @override
  void onInit() {
    getVehicles();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getVehicles() async {
    vehicleList.clear();
    isLoading = true;
    update();
    ApiServices apiServices = ApiServices();
    apiServices.getData(
      url: ApiUrl.vehicle,
      parameters: {},
    ).then((value) {
      vehicleList.addAll(value.data['vehicle']);
      isLoading = false;
      update();
      print(value);
    }).catchError((err) {
      Get.find<SupervisorMainPagesController>().signOut();
      print(err);
    });
  }
}
