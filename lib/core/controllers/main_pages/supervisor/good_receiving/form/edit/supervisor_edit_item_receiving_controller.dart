import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sologwarehouseapp/core/views/general_pages/general_page_list_items_view.dart';
import 'package:sologwarehouseapp/core/views/general_pages/general_page_list_pallet_view.dart';
import 'package:sologwarehouseapp/core/views/general_pages/general_page_list_rack_view.dart';

class SupervisorEditItemReceivingController extends GetxController {
  static SupervisorEditItemReceivingController get controller =>
      Get.find<SupervisorEditItemReceivingController>();

  List imposition = [
    {"id": 1, "name": "Kubikasi"},
    {"id": 2, "name": "Tonase"},
    {"id": 3, "name": "Item"},
    {"id": 4, "name": "Borongan"}
  ];

  List storage = [
    {
      "value": "RACK",
      "title": "Bin Location",
    },
    {
      "value": "HANDLING",
      "title": "Handling Area",
    }
  ];

  final quantityItemControllerText = TextEditingController();
  final weightControllerText = TextEditingController();
  final lengthControllerText = TextEditingController();
  final widthControllerText = TextEditingController();
  final heightControllerText = TextEditingController();
  final palletQtyControllerText = TextEditingController();
  final packageControllerText = TextEditingController();

  bool isUsePallet = false;
  Map item = {};
  Map pallet = {};
  Map rack = {};

  Map selectedImposition = {};
  String selectedStorageTitle = "";
  String selectedStorageValue = "";

  var parameterWarehouseId = Get.arguments['warehouse_id'];
  var parameterDetailItem = Get.arguments['item_receiving'];

  @override
  void onInit() {
    print(Get.arguments);
    initStarter();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  initStarter() {
    selectedImposition = imposition[(parameterDetailItem['imposition'] - 1)];
    selectedStorageTitle = parameterDetailItem['storage_type'] == "RACK"
        ? storage[0]['title']
        : storage[1]['title'];
    selectedStorageValue = parameterDetailItem['storage_type'] == "RACK"
        ? storage[0]['value']
        : storage[1]['value'];
    rack =
        parameterDetailItem['rack'] == null ? {} : parameterDetailItem['rack'];
    quantityItemControllerText.text = parameterDetailItem['qty'].toString();
    weightControllerText.text = parameterDetailItem['weight'].toString();
    lengthControllerText.text = parameterDetailItem['long'].toString();
    widthControllerText.text = parameterDetailItem['wide'].toString();
    heightControllerText.text = parameterDetailItem['high'].toString();
    palletQtyControllerText.text = parameterDetailItem['pallet_qty'].toString();
    item = {
      "id": parameterDetailItem['item_id'],
      "name": parameterDetailItem['item_name'],
    };
    update();
  }

  changeSelectedImposition(int index) {
    Get.back();
    selectedImposition = imposition[index];
    update();
  }

  changeSelectedStorage(int index) {
    Get.back();
    selectedStorageTitle = storage[index]['title'];
    selectedStorageValue = storage[index]['value'];
    if (selectedStorageTitle != storage[0]['title']) {
      rack.clear();
    }
    update();
  }

  changeItems() async {
    var value = await Get.to(() => GeneralPageListItemsView());
    if (value != null) {
      print(value);
      item.addAll(value['items']);
      quantityItemControllerText.text = "0";
      weightControllerText.text = value['items']['volume'].toString();
      lengthControllerText.text = value['items']['long'].toString();
      widthControllerText.text = value['items']['wide'].toString();
      heightControllerText.text = value['items']['height'].toString();
      update();
    }
  }

  changeRack() async {
    var value = await Get.to(() => GeneralPageListRackView(), arguments: {
      "warehouse_id": parameterWarehouseId,
    });
    if (value != null) {
      rack.addAll(value['rack']);
      update();
    }
  }

  changePallet() async {
    var value = await Get.to(() => GeneralPageListPalletView());
    if (value != null) {
      pallet.addAll(value['pallet']);
      changeStatusIsUsePallet(true);
      update();
    }
  }

  changeStatusIsUsePallet(bool value) {
    isUsePallet = value;
    update();
  }

  saveItem() {
    if (item.isEmpty) {
      Get.snackbar(
        "Oops!",
        // errorValue.toString(),
        "You didn't select item",
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
    } else if (selectedStorageTitle == storage[0]['title'] && rack.isEmpty) {
      Get.snackbar(
        "Oops!",
        // errorValue.toString(),
        "You didn't select rack",
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
    } else if (isUsePallet && pallet.isEmpty ||
        isUsePallet && palletQtyControllerText.text.isEmpty) {
      Get.snackbar(
        "Oops!",
        // errorValue.toString(),
        "Please select pallet and fill pallet quantity",
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
      Map<String, dynamic> itemToSendBack = {
        "imposition": selectedImposition['id'],
        "imposition_name": selectedImposition['name'],
        "item_name": item['name'],
        "item_id": item['id'],
        "qty": quantityItemControllerText.text.isEmpty
            ? 0
            : quantityItemControllerText.text.toString(),
        "weight": weightControllerText.text.isEmpty
            ? 0
            : weightControllerText.text.toString(),
        "long": lengthControllerText.text.isEmpty
            ? 0
            : lengthControllerText.text.toString(),
        "wide": widthControllerText.text.isEmpty
            ? 0
            : widthControllerText.text.toString(),
        "high": heightControllerText.text.isEmpty
            ? 0
            : heightControllerText.text.toString(),
        "is_use_pallet": isUsePallet ? 1 : 0,
        "storage_type": selectedStorageValue,
        "package": packageControllerText.text.toString(),
        "rack_id": rack['id'],
        "rack": rack,
        "pallet_qty":
            isUsePallet ? palletQtyControllerText.text.toString() : null,
        "pallet_id": isUsePallet ? pallet['id'] : null,
      };
      // print(itemToSendBack);
      Get.back(result: {"items": itemToSendBack});
    }
  }
}
