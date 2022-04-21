import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sologwarehouseapp/DEBUG/items_model.dart';
import 'package:sologwarehouseapp/core/controllers/main_pages/supervisor_main_pages_controller.dart';
import 'package:sologwarehouseapp/services/api_services.dart';
import 'package:sologwarehouseapp/static/api_url.dart';
import  'package:string_similarity/string_similarity.dart';

class GeneralPageListItemsController extends GetxController {
  static GeneralPageListItemsController get controller =>
      Get.find<GeneralPageListItemsController>();

  List itemList = [];
  List daftarItems = [];
  bool isLoading = true;
  bool needReset = true;

  TextEditingController searchController = TextEditingController();


  List<Datum> searchResult = [];
  List<Datum> itemDetails = [];

  @override
  void onInit() {
    getSearch();
    //getItems();
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
      print(value);
      isLoading = false;
      update();
      print(value);
    }).catchError((err) {
      Get.find<SupervisorMainPagesController>().signOut();
      print(err);
    }); 
  }

  Future<Null> getSearch() async {
    ApiServices apiServices = ApiServices();
    final response = await apiServices.getData(
      url: ApiUrl.items,
      parameters: {},
    ).catchError((err) {
      Get.find<SupervisorMainPagesController>().signOut();
      print(err);
      update();
    });
     for (Map items in response.data["data"]) {
        itemDetails.add(Datum.fromJson(items as dynamic));
      }
      print(itemDetails);
      update();
  }
  
  onSearchTextChanged(String text) async {
    searchResult.clear();
    if (text.isEmpty) {
     update();
      return;
    }

    itemDetails.forEach((newItemDetail) {
      if (newItemDetail.name!.toLowerCase().contains(text.toLowerCase()))
        searchResult.add(newItemDetail);
      update();
    }); 
    update();
  }
}
