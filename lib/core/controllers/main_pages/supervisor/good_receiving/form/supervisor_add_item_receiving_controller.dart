import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scan/scan.dart';
import 'package:sologwarehouseapp/core/controllers/main_pages/supervisor/good_receiving/form/supervisor_add_receiving_controller.dart';
import 'package:sologwarehouseapp/core/views/general_pages/general_page_list_items_view.dart';
import 'package:sologwarehouseapp/core/views/general_pages/general_page_list_pallet_view.dart';
import 'package:sologwarehouseapp/core/views/general_pages/general_page_list_rack_view.dart';
import 'package:sologwarehouseapp/core/views/main_pages/supervisor/good_receiving/form/supervisor_add_item_receiving_view.dart';

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
  final noSeriControllerText = TextEditingController();
  final orderNumberControllerText = TextEditingController();
  final batchControllerText = TextEditingController();

  ScanController scanController = ScanController();

  List<Map<String, dynamic>> items = [];

  bool isUsePallet = false;
  Map item = {};
  Map pallet = {};
  Map rack = {};

  Map selectedImposition = {};
  String selectedStorageTitle = "";
  String selectedStorageValue = "";

  String valueScan = "";
  var valueScanCode = Get.arguments['value_scan'];

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
        "serial_number" : noSeriControllerText.toString(),
        "order_number" : orderNumberControllerText.toString(),
        "batch" : batchControllerText.toString(),
      };
      // print(itemToSendBack);
      Get.back(result: {"items": itemToSendBack});
    }
  }

  nextItems() {
    if (item.isEmpty) {
      Get.snackbar(
        "Oops", 
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
    } else if (isUsePallet && pallet.isEmpty || isUsePallet && palletQtyControllerText.text.isEmpty) {
      Get.snackbar(
        "Oops!",
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
        // "serial_number" : noSeriControllerText.toString(),
        // "order_number" : orderNumberControllerText.toString(),
        // "batch" : batchControllerText.toString(),
      };
        noSeriControllerText.text = "";
        orderNumberControllerText.text = "";
        batchControllerText.text = "";
        update();
        Get.find<SupervisorAddReceivingController>().items.add(itemToSendBack);
        update();
      // Get.back(result: {
      //   "items": itemToSendBack
      // });
    }
  }

    scan(context) async {
    await [Permission.camera].request();
    var status = await Permission.camera.status;
    if (status.isDenied) {
    } else if (status.isGranted) {
      Get.bottomSheet(
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(
                bottom: 25,
              ),
              child: FloatingActionButton(
                elevation: 0,
                backgroundColor: Colors.white,
                onPressed: () {
                  Get.back();
                },
                child: Icon(
                  Icons.close,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.55,
              child: ScanView(
                controller: scanController,
                // custom scan area, if set to 1.0, will scan full area
                scanAreaScale: .8,
                scanLineColor: Colors.green.shade400,
                onCapture: (data) {
                  print(data);
                  noSeriControllerText.text = data;
                  update();
                  Get.back();
                },
              ),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
      );
      // FlutterBarcodeScanner.getBarcodeStreamReceiver(
      //   "#000000",
      //   "Cancel",
      //   true,
      //   ScanMode.DEFAULT,
      // )?.listen((barcode) {
      //   if (barcode != null) {
      //     print(barcode);
      //     Get.to(
      //       () => SupervisorDetailItemScanView(),
      //       arguments: {
      //         "item_code": barcode.toString(),
      //       },
      //     );
      //   }
      // });
    }
  }

  // addItems() async {
  //   var value = await Get.to(() => SupervisorAddItemReceiving(), arguments: {
  //     "warehouse_id": warehouseId,
  //   });
  //   if (value != null) {
  //     items.add(value['items']);
  //     update();
  //     print("Form add receiving : ${value['items']}");
  //   }
  // }
}
