import 'package:get/get.dart';
import 'package:sologwarehouseapp/core/controllers/main_pages/supervisor_main_pages_controller.dart';
import 'package:sologwarehouseapp/core/views/main_pages/supervisor/good_receiving/form/edit/supervisor_edit_item_receiving_view.dart';
import 'package:sologwarehouseapp/core/views/main_pages/supervisor/good_receiving/form/supervisor_add_item_receiving_view.dart';
import 'package:sologwarehouseapp/services/api_services.dart';
import 'package:sologwarehouseapp/static/api_url.dart';

class SupervisorEditReceivingController extends GetxController {
  static SupervisorEditReceivingController get controller =>
      Get.find<SupervisorEditReceivingController>();

  var goodReceivingId = Get.arguments['receipt_id'];
  Map goodReceivingDetail = {};
  bool isLoading = true;

  @override
  void onInit() {
    getGoodReceivingDetail();
    super.onInit();
  }

  getGoodReceivingDetail() {
    goodReceivingDetail.clear();
    isLoading = true;
    update();
    ApiServices apiServices = ApiServices();
    apiServices.getData(
      url: "${ApiUrl.receiptDetail}/$goodReceivingId",
      parameters: {},
    ).then((value) {
      goodReceivingDetail.addAll(value.data);
      update();
      print(goodReceivingDetail['item']['status']);
    }).catchError((err) {
      Get.find<SupervisorMainPagesController>().signOut();
      print(err);
    });
  }

  changeItem({required int itemIndex}) async {
    var value =
        await Get.to(() => SupervisorEditItemReceivingView(), arguments: {
      "warehouse_id": goodReceivingDetail['item']['warehouse_id'],
      "item_receiving": goodReceivingDetail['detail']
          [itemIndex], // passing item yang di klik berupa Map
    });
    if (value != null) {
      goodReceivingDetail['detail'][itemIndex] = value['items'];
      update();
      print(value);
    }
  }

  addItems() async {
    var value = await Get.to(() => SupervisorAddItemReceiving(), arguments: {
      "warehouse_id": goodReceivingDetail['item']['warehouse_id'],
    });
    if (value != null) {
      goodReceivingDetail['detail'].add(value['items']);
      update();
      print("Form add receiving : ${value['items']}");
    }
  }

  removeItem(index) {
    goodReceivingDetail['detail'].removeAt(index);
    update();
  }
}
