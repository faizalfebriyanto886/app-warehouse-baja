import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sologwarehouseapp/core/controllers/general_pages/general_page_list_items_controller.dart';
import 'package:sologwarehouseapp/static/color_app.dart';
import 'package:sologwarehouseapp/widgets/app_bar.dart';

class GeneralPageListItemsView extends StatelessWidget {
  final controller = Get.put(GeneralPageListItemsController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralPageListItemsController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBarUI().appBarWithBackButton(
            actionBackButton: () {
              Get.back();
            },
            actionButton: [],
            title: "Choose item",
          ),
          body: Column(
          children: <Widget>[
             Container(
              color: Colors.white,
              child:  Padding(
                padding: const EdgeInsets.all(8.0),
                child:  Card(
                  child:  ListTile(
                    leading:  Icon(Icons.search),
                    title:  TextField(
                      controller: controller.searchController,
                      decoration:  InputDecoration(
                          hintText: 'Search', border: InputBorder.none),
                      onChanged: controller.onSearchTextChanged,
                    ),
                    trailing:  IconButton(icon:  Icon(Icons.cancel), 
                    onPressed: () {
                      controller.searchController.clear();
                      controller.onSearchTextChanged('');
                    },),
                  ),
                ),
              ),
            ),
            controller.itemDetails.isEmpty ? Center(child: CircularProgressIndicator(),) :  Expanded(
              child: controller.searchResult.length != 0 || controller.searchController.text.isNotEmpty
                  ?  ListView.builder(
                itemCount: controller.searchResult.length,
                itemBuilder: (context, i) {
                  return  Card(
                    child:  ListTile(
                      dense: true,
                      title: Text(
                        controller.searchResult[i].name.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.black),
                      ),
                      subtitle: Text(
                        controller.searchResult[i].code.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 13,
                            color: Colors.grey),
                      ),
                      trailing: CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.grey[200],
                        child: Icon(
                          Icons.chevron_right_rounded,
                          color: Colors.grey,
                          size: 14,
                        ),
                      ),
                      onTap: () {
                         print(controller.searchResult[i].toJson());
                        Get.back(
                          result: {
                            "items": controller.searchResult[i].toJson(),
                          },
                        );
                      },
                    ),
                    margin: const EdgeInsets.all(0.0),
                  );
                },
              )
                  :  ListView.builder(
                itemCount: controller.itemDetails.length,
                itemBuilder: (context, index) {
                  return  Card(
                    child:  ListTile(
                      dense: true,
                      title: Text(
                        controller.itemDetails[index].name.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.black),
                      ),
                      subtitle: Text(
                        controller.itemDetails[index].code.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 13,
                            color: Colors.grey),
                      ),
                      trailing: CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.grey[200],
                        child: Icon(
                          Icons.chevron_right_rounded,
                          color: Colors.grey,
                          size: 14,
                        ),
                      ),
                      onTap: () {
                         print(controller.itemDetails[index].toJson());
                        Get.back(
                          result: {
                            "items": controller.itemDetails[index].toJson(),
                          },
                        );
                      },
                    ),
                    // child:  ListTile(
                    //   title:  Text( controller.itemDetails[index].name.toString()),
                    //   subtitle:  Text( controller.itemDetails[index].code.toString()),
                    //   onTap: () {
                    //     print(controller.itemDetails[index].toJson());
                    //     Get.back(
                    //       result: {
                    //         "items":controller.itemDetails[index].toJson(),
                    //       },
                    //     );
                    //   },
                    // ),
                    margin: const EdgeInsets.all(0.0),
                  );
                },
              ),
            ),
          ],
        ),
      );
      },
    );
  }
}
