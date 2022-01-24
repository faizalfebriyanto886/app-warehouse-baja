import 'package:get/get.dart';
import 'package:sologwarehouseapp/core/controllers/main_pages/supervisor_main_pages_controller.dart';
import 'package:sologwarehouseapp/services/api_services.dart';
import 'package:sologwarehouseapp/static/api_url.dart';

class SupervisorStockOpnameController extends GetxController {
  static SupervisorStockOpnameController get controller =>
      Get.find<SupervisorStockOpnameController>();

  List stockOpnameList = [];
  bool isLoading = true;

  @override
  void onInit() {
    getStockOpname();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getStockOpname() async {
    stockOpnameList.clear();
    isLoading = true;
    update();
    ApiServices apiServices = ApiServices();
    apiServices.getData(
      url: ApiUrl.stockOpname,
      parameters: {},
    ).then((value) {
      stockOpnameList.addAll(value.data['data']);
      isLoading = false;
      update();
      print(value);
    }).catchError((err) {
      Get.find<SupervisorMainPagesController>().signOut();
      print(err);
    });
  }
}
