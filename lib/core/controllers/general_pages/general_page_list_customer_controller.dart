import 'package:get/get.dart';
import 'package:sologwarehouseapp/core/controllers/main_pages/supervisor_main_pages_controller.dart';
import 'package:sologwarehouseapp/services/api_services.dart';
import 'package:sologwarehouseapp/static/api_url.dart';

class GeneralPageListCustomerController extends GetxController {
  static GeneralPageListCustomerController get controller =>
      Get.find<GeneralPageListCustomerController>();

  List customerList = [];
  bool isLoading = true;

  @override
  void onInit() {
    getCustomer();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getCustomer() async {
    customerList.clear();
    isLoading = true;
    update();
    ApiServices apiServices = ApiServices();
    apiServices.getData(
      url: ApiUrl.customer,
      parameters: {},
    ).then((value) {
      customerList.addAll(value.data['customer']);
      isLoading = false;
      update();
      print(value);
    }).catchError((err) {
      Get.find<SupervisorMainPagesController>().signOut();
      print(err);
    });
  }
}
