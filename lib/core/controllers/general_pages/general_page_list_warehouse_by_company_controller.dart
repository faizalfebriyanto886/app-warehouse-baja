import 'package:get/get.dart';
import 'package:sologwarehouseapp/core/controllers/main_pages/supervisor_main_pages_controller.dart';
import 'package:sologwarehouseapp/services/api_services.dart';
import 'package:sologwarehouseapp/static/api_url.dart';

class GeneralPageListWarehouseByCompanyController extends GetxController {
  static GeneralPageListWarehouseByCompanyController get controller =>
      Get.find<GeneralPageListWarehouseByCompanyController>();
  var companyId = Get.arguments['company_id'];
  List warehouseList = [];
  bool isLoading = true;

  @override
  void onInit() {
    getWarehouses();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getWarehouses() async {
    warehouseList.clear();
    isLoading = true;
    update();
    ApiServices apiServices = ApiServices();
    apiServices.getData(
      url: ApiUrl.warehouseList,
      parameters: {
        "company_id": companyId == null ? "" : companyId,
      },
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
