import 'package:get/get.dart';
import 'package:sologwarehouseapp/core/controllers/main_pages/supervisor_main_pages_controller.dart';
import 'package:sologwarehouseapp/services/api_services.dart';
import 'package:sologwarehouseapp/static/api_url.dart';

class GeneralPageListItemsController extends GetxController {
  static GeneralPageListItemsController get controller =>
      Get.find<GeneralPageListItemsController>();

  List itemList = [];
  bool isLoading = true;

  @override
  void onInit() {
    getItems();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getItems() async {
    itemList.clear();
    isLoading = true;
    update();
    ApiServices apiServices = ApiServices();
    apiServices.getData(
      url: ApiUrl.items,
      parameters: {},
    ).then((value) {
      itemList.addAll(value.data['data']);
      isLoading = false;
      update();
      print(value);
    }).catchError((err) {
      Get.find<SupervisorMainPagesController>().signOut();
      print(err);
    });
  }
}