import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sologwarehouseapp/core/controllers/general_pages/general_page_list_items_controller.dart';
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
          body: ListView(
            padding: EdgeInsets.only(),
            physics: BouncingScrollPhysics(),
            children: [
              ListView.builder(
                  padding: EdgeInsets.only(),
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.itemList.length,
                  itemBuilder: (ctx, index) {
                    return ListTile(
                      contentPadding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      onTap: () {
                        Get.back(
                          result: {
                            "items": controller.itemList[index],
                          },
                        );
                      },
                      dense: true,
                      title: Text(
                        controller.itemList[index]['name'],
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.black),
                      ),
                      subtitle: Text(
                        controller.itemList[index]['code'],
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
                    );
                  })
            ],
          ),
        );
      },
    );
  }
}
