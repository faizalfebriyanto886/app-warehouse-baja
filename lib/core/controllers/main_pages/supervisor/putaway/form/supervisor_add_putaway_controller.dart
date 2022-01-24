import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response, MultipartFile, FormData;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sologwarehouseapp/core/controllers/main_pages/supervisor/putaway/supervisor_putaway_controller.dart';
import 'package:sologwarehouseapp/core/views/general_pages/general_page_list_rack_view.dart';
import 'package:sologwarehouseapp/core/views/general_pages/general_page_list_warehouse_by_company_view.dart';
import 'package:sologwarehouseapp/core/views/main_pages/supervisor/putaway/form/supervisor_list_item_to_add_putaway_by_warehouse_id_view.dart';
import 'package:sologwarehouseapp/static/api_url.dart';
import 'package:sologwarehouseapp/static/shared_preferences_key.dart';

class SupervisorAddPutawayController extends GetxController {
  static SupervisorAddPutawayController get controller =>
      Get.find<SupervisorAddPutawayController>();

  Map warehouse = {};
  List items = [];
  List<TextEditingController> qtyController = [];
  final descriptionControllerText = TextEditingController();

  bool isSaveRunning = false;
  DateTime receiveDate = DateTime.now();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  changeWarehouse() async {
    var value = await Get.to(
      () => GeneralPageListWarehouseByCompanyView(),
      arguments: {
        "company_id": null,
      },
    );
    if (value != null) {
      warehouse.addAll(value['warehouse']);
      items.clear();
      qtyController.clear();
      update();
    }
  }

  changeReceiveDate(BuildContext context) async {
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

  changeBinDestinationEachItem({required int indexItem}) async {
    var value = await Get.to(() => GeneralPageListRackView(), arguments: {
      "warehouse_id": warehouse['id'],
    });
    if (value != null) {
      items[indexItem]['bin_destination'] = value['rack'];
      update();
    }
  }

  changeQtyEachItem({required int indexItem, required double newQty}) {
    items[indexItem]['item']['qty'] = newQty;
    update();
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
      items.add({"bin_destination": {}, "item": value['item']});
      qtyController.add(new TextEditingController());
      qtyController.last.text = items.last['item']['qty'];
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

  savePutaway() async {
    if (warehouse.isEmpty) {
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
      List<bool> checkEachItemHasChoosenBinDestination = [];
      List listItem = [];
      listItem.clear();
      checkEachItemHasChoosenBinDestination.clear();
      update();
      for (int i = 0; i < items.length; i++) {
        if (items[i]['bin_destination'].isEmpty) {
          checkEachItemHasChoosenBinDestination.add(false);
          update();
        } else {
          listItem.add({
            "id": 1239293,
            "item_id": items[i]['item']['id'],
            "rack_id": items[i]['item']['rack_id'],
            "qty": qtyController[i].text.toString() == "" ||
                    qtyController[i].text.toString() == "0"
                ? "0"
                : qtyController[i].text.toString(),
            "warehouse_receipt_id": items[i]['item']['warehouse_receipt_id'],
            "warehouse_receipt_detail_id": items[i]['item']
                ['warehouse_receipt_detail_id'],
            "destination_rack_id": items[i]['bin_destination']['id'],
          });
          checkEachItemHasChoosenBinDestination.add(true);
          update();
        }
      }
      if (checkEachItemHasChoosenBinDestination.contains(false)) {
        Get.snackbar(
          "Oops!",
          // errorValue.toString(),
          "Please fill all bin destination for all items",
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
        Map dataToSend = {
          "warehouse_from_id": warehouse['id'],
          "description": descriptionControllerText.text.toString(),
          "date_transaction": DateFormat("dd-MM-yyyy").format(receiveDate),
          "detail": listItem.toList(),
        };
        print(dataToSend);
        isSaveRunning = true;
        update();
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String tokenType =
            preferences.getString(SharedPreferencesKey.tokenType)!;
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
            ApiUrl.putawayAddNew,
            data: dataToSend,
          );
          Get.find<SupervisorPutawayController>().getPutAway();
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
}
