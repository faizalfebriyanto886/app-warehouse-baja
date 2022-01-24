import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sologwarehouseapp/core/views/general_pages/general_page_list_items_view.dart';
import 'package:sologwarehouseapp/core/views/general_pages/general_page_list_pallet_view.dart';
import 'package:sologwarehouseapp/core/views/general_pages/general_page_list_rack_view.dart';

class SupervisorAddItemReceivingController extends GetxController {
  static SupervisorAddItemReceivingController get controller =>
      Get.find<SupervisorAddItemReceivingController>();

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

  var warehouseId = "";

  @override
  void onInit() {
    initStarter();
    super.onInit();
    if (Get.arguments['warehouse_id'] != null) {
      warehouseId = Get.arguments['warehouse_id'].toString();
      update();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  initStarter() {
    selectedImposition = imposition[0];
    selectedStorageTitle = storage[0]['title'];
    selectedStorageValue = storage[0]['value'];
    // quantityItemControllerText.text = "0";
    // weightControllerText.text = "0";
    // lengthControllerText.text = "0";
    // widthControllerText.text = "0";
    // heightControllerText.text = "0";
    // palletQtyControllerText.text = "0";
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
      weightControllerText.text = value['items']['volume'].toString();
      lengthControllerText.text = value['items']['long'].toString();
      widthControllerText.text = value['items']['wide'].toString();
      heightControllerText.text = value['items']['height'].toString();
      update();
    }
  }

  changeRack() async {
    var value = await Get.to(() => GeneralPageListRackView(), arguments: {
      "warehouse_id": warehouseId,
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
