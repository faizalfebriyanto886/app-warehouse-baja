import 'package:get/get.dart';
import 'package:sologwarehouseapp/core/controllers/main_pages/supervisor_main_pages_controller.dart';
import 'package:sologwarehouseapp/services/api_services.dart';
import 'package:sologwarehouseapp/static/api_url.dart';

class GeneralPageListCompanyController extends GetxController {
  static GeneralPageListCompanyController get controller =>
      Get.find<GeneralPageListCompanyController>();

  List companyList = [];
  bool isLoading = true;

  @override
  void onInit() {
    getCompanies();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getCompanies() async {
    companyList.clear();
    isLoading = true;
    update();
    ApiServices apiServices = ApiServices();
    apiServices.getData(
      url: ApiUrl.company,
      parameters: {},
    ).then((value) {
      companyList.addAll(value.data['company']);
      isLoading = false;
      update();
      print(value);
    }).catchError((err) {
      Get.find<SupervisorMainPagesController>().signOut();
      print(err);
    });
  }
}
