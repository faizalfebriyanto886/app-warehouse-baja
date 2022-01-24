import 'package:get/get.dart';
import 'package:sologwarehouseapp/core/controllers/main_pages/supervisor_main_pages_controller.dart';
import 'package:sologwarehouseapp/services/api_services.dart';
import 'package:sologwarehouseapp/static/api_url.dart';

class GeneralPageListPalletController extends GetxController {
  static GeneralPageListPalletController get controller =>
      Get.find<GeneralPageListPalletController>();

  List palletList = [];
  bool isLoading = true;

  @override
  void onInit() {
    getPallets();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getPallets() async {
    palletList.clear();
    isLoading = true;
    update();
    ApiServices apiServices = ApiServices();
    apiServices.getData(
      url: ApiUrl.pallet,
      parameters: {},
    ).then((value) {
      palletList.addAll(value.data['data']);
      isLoading = false;
      update();
      print(value);
    }).catchError((err) {
      Get.find<SupervisorMainPagesController>().signOut();
      print(err);
    });
  }
}