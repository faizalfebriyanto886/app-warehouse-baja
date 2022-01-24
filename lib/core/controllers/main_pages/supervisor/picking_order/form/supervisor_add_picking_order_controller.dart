import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response, MultipartFile, FormData;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sologwarehouseapp/core/controllers/main_pages/supervisor/picking_order/supervisor_picking_order_controller.dart';
import 'package:sologwarehouseapp/core/views/general_pages/general_page_list_company_view.dart';
import 'package:sologwarehouseapp/core/views/general_pages/general_page_list_warehouse_by_company_view.dart';
import 'package:sologwarehouseapp/core/views/main_pages/supervisor/putaway/form/supervisor_list_item_to_add_putaway_by_warehouse_id_view.dart';
import 'package:sologwarehouseapp/static/api_url.dart';
import 'package:sologwarehouseapp/static/shared_preferences_key.dart';

class SupervisorAddPickingOrderController extends GetxController {
  static SupervisorAddPickingOrderController get controller =>
      Get.find<SupervisorAddPickingOrderController>();

  final descriptionControllerText = TextEditingController();
  Map company = {};
  Map warehouse = {};
  List items = [];
  bool isSaveRunning = false;
  List<TextEditingController> qtyController = [];
  DateTime receiveDate = DateTime.now();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  changeCompany() async {
    var value = await Get.to(() => GeneralPageListCompany());
    if (value != null) {
      company.addAll(value['company']);
      warehouse.clear();
      items.clear();
      qtyController.clear();
      update();
    }
  }

  changeWarehouse() async {
    var value = await Get.to(
      () => GeneralPageListWarehouseByCompanyView(),
      arguments: {
        "company_id": company['id'],
      },
    );
    if (value != null) {
      warehouse.addAll(value['warehouse']);
      items.clear();
      qtyController.clear();
      update();
    }
  }

  changeDate(BuildContext context) async {
    final DateTime? date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2020),
        lastDate: DateTime(2101));
    if (date != null) {
      final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (time != null) {
        receiveDate =
            DateTime(date.year, date.month, date.day, time.hour, time.minute);
        update();
      }
    }
  }

  addNewItem() async {
    var value = await Get.to(
      () => SupervisorListItemToAddPutawayByWarehouseIdView(),
      arguments: {
        "warehouse_id": warehouse['id'],
      },
    );
    if (value != null) {
      // print(value);
      items.add(value['item']);
      qtyController.add(new TextEditingController());
      qtyController.last.text = "0";
      print(items);
      update();
    }
    print(items.toList());
  }

  removeItem({required int indexItem}) {
    items.removeAt(indexItem);
    qtyController.removeAt(indexItem);
    update();
  }

  changeQtyEachItem({required int indexItem, required double newQty}) {
    items[indexItem]['qty'] = newQty;
    update();
  }

  savePickingOrder() async {
    if (company.isEmpty || warehouse.isEmpty) {
      Get.snackbar(
        "Oops!",
        // errorValue.toString(),
        "Choose warehouse",
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        snackStyle: SnackStyle.FLOATING,
        icon: Icon(
          Icons.warning,
          color: Colors.white,
        ),
        isDismissible: true,
        margin: EdgeInsets.only(bottom: 10, right: 10, left: 10),
      );
    } else if (items.isEmpty) {
      Get.snackbar(
        "Oops!",
        // errorValue.toString(),
        "Please add item",
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        snackStyle: SnackStyle.FLOATING,
        icon: Icon(
          Icons.warning,
          color: Colors.white,
        ),
        isDismissible: true,
        margin: EdgeInsets.only(bottom: 10, right: 10, left: 10),
      );
    } else {
      List listItem = [];
      listItem.clear();
      update();
      for (int i = 0; i < items.length; i++) {
        listItem.add({
          "item_id": items[i]['id'],
          "rack_id": items[i]['rack_id'],
          "warehouse_receipt_detail_id": items[i]
              ['warehouse_receipt_detail_id'],
          "qty": qtyController[i].text.toString() == "" ||
                  qtyController[i].text.toString() == "0"
              ? "0"
              : qtyController[i].text.toString(),
        });
        update();
      }
      Map dataToSend = {
        "company_id": company['id'],
        "warehouse_id": warehouse['id'],
        "description": descriptionControllerText.text.toString(),
        "date_transaction": DateFormat("dd-MM-yyyy").format(receiveDate),
        "detail_item": listItem.toList(),
      };
      print(dataToSend);
      isSaveRunning = true;
      update();
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String tokenType = preferences.getString(SharedPreferencesKey.tokenType)!;
      String accessToken =
          preferences.getString(SharedPreferencesKey.accessToken)!;
      String tokenTypeWithAccessToken = "$tokenType $accessToken";
      // print(tokenTypeWithAccessToken);

      //initializing Dio
      Dio dio = Dio();

      //add header dio authorization
      dio.options.headers["Authorization"] = tokenTypeWithAccessToken;

      //initializing response
      try {
        Response response = await dio.post(
          ApiUrl.pickingAddNew,
          data: dataToSend,
        );
        Get.find<SupervisorPickingOrderController>().getPickingOrder();
        Get.back();
        print("Response :$response");
      } on DioError catch (e) {
        Get.snackbar(
          "Oops!",
          // errorValue.toString(),
          e.response.toString(),
          backgroundColor: Colors.red[400],
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          snackStyle: SnackStyle.FLOATING,
          icon: Icon(
            Icons.warning,
            color: Colors.white,
          ),
          isDismissible: true,
          margin: EdgeInsets.only(bottom: 10, right: 10, left: 10),
        );
        print(e.response);
      }
      isSaveRunning = false;
      update();
    }
  }
}
