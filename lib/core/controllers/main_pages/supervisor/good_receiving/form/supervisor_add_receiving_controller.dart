import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart' hide Response, MultipartFile, FormData;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sologwarehouseapp/core/views/general_pages/general_page_list_company_view.dart';
import 'package:sologwarehouseapp/core/views/general_pages/general_page_list_customer_view.dart';
import 'package:sologwarehouseapp/core/views/general_pages/general_page_list_vehicle_view.dart';
import 'package:sologwarehouseapp/core/views/general_pages/general_page_list_warehouse_by_company_view.dart';
import 'package:sologwarehouseapp/core/views/main_pages/supervisor/good_receiving/form/supervisor_add_item_receiving_view.dart';
import 'package:sologwarehouseapp/core/views/main_pages/supervisor/good_receiving/form/supervisor_signature_pad_view.dart';

import 'package:sologwarehouseapp/static/api_url.dart';
import 'package:sologwarehouseapp/static/shared_preferences_key.dart';

import '../supervisor_good_receiving_controller.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage; // for Firebase Storage

class SupervisorAddReceivingController extends GetxController {
  static SupervisorAddReceivingController get controller =>
      Get.find<SupervisorAddReceivingController>();

  final shipperControllerText = TextEditingController();
  final consigneeControllerText = TextEditingController();
  final destinationControllerText = TextEditingController();
  final senderSJNumberControllerText = TextEditingController();
  final descriptionControllerText = TextEditingController();

  //======
  final driverNameControllerText = TextEditingController();
  final vehicleRegNumberControllerText = TextEditingController();
  final phoneNumberControllerText = TextEditingController();

  Map company = {};
  Map warehouse = {};
  Map customer = {};
  Map vehicle = {};
  bool isSaveRunning = false;
  DateTime receiveDate = DateTime.now();
  List<Map<String, dynamic>> items = [];

  File? _photo;

  Uint8List? signatureImage;

  final picker = ImagePicker();
  List<File> attachmentFiles = [];
  List<MultipartFile> multipartFiles = [];

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  @override
  void onInit() {
    update();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<File> compressFile(File file) async {
    File compressedFile = await FlutterNativeImage.compressImage(
      file.path,
      quality: 50,
    );
    return compressedFile;
  }

  changeCompany() async {
    var value = await Get.to(() => GeneralPageListCompany());
    if (value != null) {
      company.addAll(value['company']);
      warehouse.clear();
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
      update();
    }
  }

  changeCustomer() async {
    var value = await Get.to(() => GeneralPageListCustomerView());
    if (value != null) {
      customer.addAll(value['customer']);
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

  changeVehicle() async {
    var value = await Get.to(() => GeneralPageListVehicleView());
    if (value != null) {
      vehicle.addAll(value['vehicle']);
      update();
    }
  }

  addItems() async {
    var value = await Get.to(() => SupervisorAddItemReceiving(), arguments: {
      "warehouse_id": warehouse['id'],
    });
    update();
    if (value != null) {
      items.add(value['items']);
      update();
      print("Form add receiving : ${value['items']}");
    }
  }

  addNewSignature() async {
    var value = await Get.to(() => SupervisorSignaturePadView());
    if (value != null) {
      signatureImage = base64.decode(value['signature_image_encoded']);
      update();
    }
  }

  Future getImage({required ImageSource from}) async {
    Get.back();
    final pickedFile = await picker.pickImage(
      source: from,
    );
    print(pickedFile);
    if (pickedFile != null) {
      File compressedFile = await compressFile(File(pickedFile.path));
      attachmentFiles.add(compressedFile);
      update();  
    } else {
      print("image not found");
    }
  }

  // for testing
  Future getImageToFirebase({required ImageSource from, required String namePath}) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile(filePath: namePath);
      } else {
        print('No image selected.');
      }
  }

  // upload image with firebase storage
  Future uploadFile({required String filePath}) async {
    if (_photo == null) return;
    final destination = "image-attach";

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('$filePath/');
      await ref.putFile(_photo!);
    } catch (e) {
      print('error occured');
    }
  }

  Future getMultipleImages() async {
    Get.back();
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png'],
    );

    if (result != null) {
      for (var i = 0; i < result.files.length; i++) {
        attachmentFiles.add(File(result.files[i].path!));
        _photo = File(result.files[i].path!);
        uploadFile(filePath: result.files[i].name);

        // getImageToFirebase(from: ImageSource.gallery, namePath: result.files[i].name);
        print(result.files[i].name);
      }
      update();
      Get.snackbar(
        "Success", 
        "File berhasil di upload",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.2),
        colorText: Colors.green,
      );
    }
  }

  removeItem(int index) {
    items.removeAt(index);
    update();
  }

  removeAttachment(int index) {
    attachmentFiles.removeAt(index);
    update();
  }

  saveToDraft() async {
    if (company.isEmpty ||
        warehouse.isEmpty ||
        customer.isEmpty ||
        vehicle.isEmpty ||
        shipperControllerText.text.isEmpty ||
        consigneeControllerText.text.isEmpty) {
      Get.snackbar(
        "Oops!",
        "Make sure you have selected and fill the company, warehouse, shipper, consignee, customer and vehicle",
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
        "Dont't forget to add items",
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
    } else if (signatureImage == null) {
      Get.snackbar(
        "Oops!",
        "Dont't forget to add driver signature",
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
        multipartFiles.clear();
        for (var file in attachmentFiles) {
          multipartFiles.add(await MultipartFile.fromFile(file.path,
              filename: file.path.split('/').last));
          update();
        }
        Response response = await dio.post(
          ApiUrl.receiptAddNew,
          data: FormData.fromMap({
            "company_id": company['id'],
            "receipt_type_id": 14,
            "purchase_order_id": 39,
            "receive_date": DateFormat("dd-M-yyyy").format(receiveDate),
            "receive_time": DateFormat("HH:mm").format(receiveDate),
            "sender": shipperControllerText.text.toString(),
            "receiver": consigneeControllerText.text.toString(),
            "total": 0,
            "description": descriptionControllerText.text.toString(),
            "warehouse_id": warehouse['id'],
            "customer_id": customer['id'],
            "city_to": destinationControllerText.text.toString(),
            "reff_no": senderSJNumberControllerText.text.toString(),
            "driver": driverNameControllerText.text.toString(),
            "nopol": vehicleRegNumberControllerText.text.toString(),
            "phone_number": phoneNumberControllerText.text.toString(),
            // "package": packageControllerText.text.toString(),
            "vehicle_type_id": vehicle['id'],
            "detail": items.toList(),
            "status": 0,
            "files": multipartFiles,
            "ttd": signatureImage == null
                ? ""
                : "data:image/png;base64,${base64.encode(signatureImage!)}",
          }),
        );
        Get.find<SupervisorGoodReceivingController>().getGoodReceiveList();
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

  saveToFinal() async {
    if (company.isEmpty ||
        warehouse.isEmpty ||
        customer.isEmpty ||
        vehicle.isEmpty ||
        shipperControllerText.text.isEmpty ||
        consigneeControllerText.text.isEmpty) {
      Get.snackbar(
        "Oops!",
        "Make sure you have selected and fill the company, warehouse, shipper, consignee, customer and vehicle",
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
        "Dont't forget to add items",
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
    } else if (attachmentFiles.isEmpty) {
      Get.snackbar(
        "Oops!",
        "Dont't forget to add attachment files",
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
    } else if (signatureImage == null) {
      Get.snackbar(
        "Oops!",
        "Dont't forget to add driver signature",
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
        multipartFiles.clear();
        for (var file in attachmentFiles) {
          multipartFiles.add(await MultipartFile.fromFile(file.path,
              filename: file.path.split('/').last));
          update();
        }
        Response response = await dio.post(
          ApiUrl.receiptAddNew,
          data: FormData.fromMap({
            "company_id": company['id'],
            "receipt_type_id": 14,
            "purchase_order_id": 39,
            "receive_date": DateFormat("dd-M-yyyy").format(receiveDate),
            "receive_time": DateFormat("HH:mm").format(receiveDate),
            "sender": shipperControllerText.text.toString(),
            "receiver": consigneeControllerText.text.toString(),
            "total": 0,
            "description": descriptionControllerText.text.toString(),
            "warehouse_id": warehouse['id'],
            "customer_id": customer['id'],
            "city_to": destinationControllerText.text.toString(),
            "reff_no": senderSJNumberControllerText.text.toString(),
            "driver": driverNameControllerText.text.toString(),
            "nopol": vehicleRegNumberControllerText.text.toString(),
            "phone_number": phoneNumberControllerText.text.toString(),
            // "package": packageControllerText.text.toString(),
            "vehicle_type_id": vehicle['id'],
            "detail": items.toList(),
            "status": 1,
            // "files" : null,
            "files": multipartFiles.toList(),
            // "ttd" : null,
            "ttd": signatureImage == null
                ? ""
                : "data:image/png;base64,${base64.encode(signatureImage!)}",
          }),
        );
        Get.find<SupervisorGoodReceivingController>().getGoodReceiveList();
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
