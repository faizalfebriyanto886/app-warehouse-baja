import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sologwarehouseapp/core/views/main_pages/supervisor/good_receiving/supervisor_good_receiving_filter_view.dart';
import 'package:sologwarehouseapp/services/api_services.dart';
import 'package:sologwarehouseapp/static/api_url.dart';

import '../../supervisor_main_pages_controller.dart';

class SupervisorGoodReceivingController extends GetxController {
  static SupervisorGoodReceivingController get controller =>
      Get.find<SupervisorGoodReceivingController>();

  String selectedCategory = "All";
  List category = [
    "All",
    "Draft",
    "Approved",
  ];

  List goodReceiveList = [];
  var customerId = "";
  var warehouseId = "";
  var companyId = "";
  DateTime startDate = DateTime.now().add(Duration(days: -7));
  DateTime endDate = DateTime.now();

  bool isLoading = true;

  @override
  void onInit() {
    getGoodReceiveList();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  changeCategory(int index) {
    selectedCategory = category[index];
    update();
    getGoodReceiveList();
  }

  changeFilter() async {
    var value = await Get.to(() => SupervisorGoodReceivingFilterView());
    if (value != null) {
      // print(value);

      if (value['company'].isNotEmpty) {
        companyId = value['company']['id'];
      }

      if (value['customer'].isNotEmpty) {
        customerId = value['customer']['id'];
      }

      if (value['warehouse'].isNotEmpty) {
        warehouseId = value['warehouse']['id'];
      }

      if (value['start_date'] != null) {
        startDate = value['start_date'];
      }

      if (value['end_date'] != null) {
        endDate = value['end_date'];
      }

      update();
      getGoodReceiveList();
    }
  }

  reset() {
    selectedCategory = category[0];
    customerId = "";
    customerId = "";
    warehouseId = "";
    startDate = DateTime.now().add(Duration(days: -7));
    endDate = DateTime.now();
    update();
    getGoodReceiveList();
  }

  getGoodReceiveList() async {
    goodReceiveList.clear();
    isLoading = true;
    update();
    ApiServices apiServices = ApiServices();
    apiServices.getData(
      url: ApiUrl.receiptList,
      parameters: {
        "status": selectedCategory == "All"
            ? ""
            : selectedCategory == "Draft"
                ? 0
                : 1,
        "customer_id": customerId,
        "warehouse_id": warehouseId,
        "company_id": companyId,
        "start_date": DateFormat("dd-MMM-yyyy").format(startDate),
        "end_date": DateFormat("dd-MMM-yyyy").format(endDate),
      },
    ).then((value) {
      goodReceiveList.addAll(value.data['data']);
      isLoading = false;
      update();
      print(value);
    }).catchError((err) {
      Get.find<SupervisorMainPagesController>().signOut();
      print(err);
    });
  }
}
