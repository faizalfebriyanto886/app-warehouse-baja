import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response, MultipartFile, FormData;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sologwarehouseapp/core/controllers/main_pages/supervisor_main_pages_controller.dart';
import 'package:sologwarehouseapp/core/views/general_pages/general_page_list_company_view.dart';
import 'package:sologwarehouseapp/core/views/general_pages/general_page_list_warehouse_by_company_view.dart';
import 'package:sologwarehouseapp/core/views/main_pages/supervisor/putaway/form/supervisor_list_item_to_add_putaway_by_warehouse_id_view.dart';
import 'package:sologwarehouseapp/services/api_services.dart';
import 'package:sologwarehouseapp/static/api_url.dart';
import 'package:sologwarehouseapp/static/shared_preferences_key.dart';

import '../supervisor_stock_opname_controller.dart';

class SupervisorAddStockOpnameController extends GetxController {
  static SupervisorAddStockOpnameController get controller =>
      Get.find<SupervisorAddStockOpnameController>();

  Map company = {};
  Map warehouse = {};
  String type = "";
  List items = [];
  bool isSaveRunning = false;
  List<TextEditingController> qtyController = [];

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
      type = "";
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
      type = "";
      update();
    }
  }

  changeType({required String newType}) {
    Get.back();
    type = newType;
    items.clear();
    qtyController.clear();
    if (newType == "Full") {
      getItem();
    }
    update();
  }

  getItem() async {
    items.clear();
    update();
    ApiServices apiServices = ApiServices();
    apiServices.getData(
      url: ApiUrl.itemListForNewPutawayByWarehouseId,
      parameters: {
        "warehouse_id": warehouse['id'] == null ? "" : warehouse['id'],
      },
    ).then((value) {
      var data = value.data['data'];
      items.clear();
      for (int i = 0; i < data.length; i++) {
        print(data[i]);
        items.add(data[i]);
        qtyController.add(new TextEditingController());
        qtyController.last.text = data[i]['qty'].toString();
        update();
      }
    }).catchError((err) {
      Get.find<SupervisorMainPagesController>().signOut();
      print(err);
    });
  }

  addNewItem() async {
    var value = await Get.to(
      () => SupervisorListItemToAddPutawayByWarehouseIdView(),
      arguments: {
        "warehouse_id": warehouse['id'],
      },
    );
    if (value != null) {
      print(value['item']['qty']);
      items.add(value['item']);
      qtyController.add(new TextEditingController());
      qtyController.last.text = value['item']['qty'].toString();
      update();
    }
    // print(items.toList());
  }

  removeItem({required int indexItem}) {
    items.removeAt(indexItem);
    qtyController.removeAt(indexItem);
    update();
  }

  changeQtyEachItem({required int indexItem, required int newQty}) {
    qtyController[indexItem].text = newQty.toString();
    update();
  }

  saveStockOpname() async {
    if (company.isEmpty || warehouse.isEmpty || items.isEmpty) {
      Get.snackbar(
        "Oops!",
        // errorValue.toString(),
        "Make sure you have selected company, warehouse and add item",
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
      isSaveRunning = true;
      update();
      List detailItem = [];
      // print(items[0]);
      for (int index = 0; index < items.length; index++) {
        detailItem.add({
          "item_id": items[index]['id'],
          "warehouse_receipt_detail_id": items[index]
              ['warehouse_receipt_detail_id'],
          "rack_id": items[index]['rack_id'],
          "qty": items[index]['qty'],
          "qty_riil": qtyController[index].text.toString(),
        });
        update();
      }

      Map dataToSend = {
        "company_id": company['id'],
        "type": type == "Full" ? 1 : 2,
        "warehouse_id": warehouse['id'],
        "detail": detailItem.toList(),
      };
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
          ApiUrl.stockOpnameAddNew,
          data: dataToSend,
        );
        Get.find<SupervisorStockOpnameController>().getStockOpname();
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
      print(dataToSend);
      isSaveRunning = false;
      update();
    }
  }
}
