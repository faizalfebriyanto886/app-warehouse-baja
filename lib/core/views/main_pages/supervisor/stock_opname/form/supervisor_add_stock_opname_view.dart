import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sologwarehouseapp/core/controllers/main_pages/supervisor/stock_opname/form/supervisor_add_stock_opname_controller.dart';
import 'package:sologwarehouseapp/static/color_app.dart';
import 'package:sologwarehouseapp/widgets/app_bar.dart';
import 'package:sologwarehouseapp/widgets/button.dart';

class SupervisorAddStockOpnameView extends StatelessWidget {
  final SupervisorAddStockOpnameController controller =
      Get.put(SupervisorAddStockOpnameController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupervisorAddStockOpnameController>(
      builder: (_) {
        return Scaffold(
          bottomNavigationBar: controller.isSaveRunning
            ? Container(
                alignment: Alignment.center,
                height: 70,
                margin: EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Text("Please wait",
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontWeight: FontWeight.bold,
                    )),
              )
            : Container(
                height: 60,
                margin: EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: AppButton().iconButton(
                  buttonColor: ColorApp.mainColorApp,
                  colorTextButton: Colors.white,
                  function: () {
                    controller.saveStockOpname();
                  },
                  icon: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                  textButton: "Save",
                ),
              ),
          appBar: AppBarUI().appBarWithBackButton(
              actionBackButton: () {
                Get.back();
              },
              actionButton: [],
              title: "Add Stock Opname"),
          body: ListView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.09,
            ),
            physics: BouncingScrollPhysics(),
            children: [
              Container(
                child: ListTile(
                  contentPadding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  onTap: () {
                    controller.changeCompany();
                  },
                  dense: true,
                  title: Text(
                    "Company",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                  subtitle: Text(
                    controller.company.isEmpty
                        ? "Choose company here"
                        : "${controller.company['code']}-${controller.company['name']}",
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
                ),
              ),
              controller.company.isEmpty
                  ? Opacity(
                      opacity: 0,
                    )
                  : Container(
                      child: ListTile(
                        contentPadding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        onTap: () {
                          controller.changeWarehouse();
                        },
                        dense: true,
                        title: Text(
                          "Warehouse",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.black),
                        ),
                        subtitle: Text(
                          controller.warehouse.isEmpty
                              ? "Choose warehouse"
                              : "${controller.warehouse['code']}-${controller.warehouse['name']}",
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
                      ),
                    ),
              controller.warehouse.isEmpty
                  ? Opacity(
                      opacity: 0,
                    )
                  : Container(
                      margin: EdgeInsets.only(top: 10),
                      child: ListTile(
                        contentPadding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        onTap: () async {
                          Get.bottomSheet(
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                ),
                              ),
                              padding: EdgeInsets.only(
                                top: 5,
                                bottom: 15,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    title: Text(
                                      "Choose type here",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 13,
                                          color: Colors.grey),
                                    ),
                                  ),
                                  ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: ColorApp.mainColorApp
                                          .withOpacity(0.1),
                                      child: Icon(
                                        Icons.star_rate_rounded,
                                        color: ColorApp.mainColorApp,
                                      ),
                                    ),
                                    onTap: () {
                                      controller.changeType(newType: "Full");
                                    },
                                    title: Text(
                                      "Full",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13,
                                          color: Colors.black),
                                    ),
                                  ),
                                  ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: ColorApp.mainColorApp
                                          .withOpacity(0.1),
                                      child: Icon(
                                        Icons.star_half_rounded,
                                        color: ColorApp.mainColorApp,
                                      ),
                                    ),
                                    onTap: () {
                                      controller.changeType(newType: "Partial");
                                    },
                                    title: Text(
                                      "Partial",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13,
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            backgroundColor: Colors.white,
                          );
                        },
                        dense: true,
                        title: Text(
                          "Type",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.black),
                        ),
                        subtitle: Text(
                          controller.type == ""
                              ? "Choose type here"
                              : controller.type.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 13,
                              color: Colors.grey),
                        ),
                      ),
                    ),
              Divider(),
              controller.warehouse.isEmpty || controller.type == ""
                  ? Opacity(
                      opacity: 0,
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: ListTile(
                            contentPadding: EdgeInsets.only(
                              left: 20,
                              right: 20,
                            ),
                            onTap: controller.type == "Full"
                                ? null
                                : () {
                                    controller.addNewItem();
                                  },
                            dense: true,
                            title: Text(
                              "Items",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                            subtitle: Text(
                              controller.type == "Full"
                                  ? "List Items"
                                  : "Add new item by tap + button",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 13,
                                  color: Colors.grey),
                            ),
                            trailing: controller.type == "Full"
                                ? null
                                : CircleAvatar(
                                    backgroundColor:
                                        ColorApp.mainColorApp.withOpacity(0.1),
                                    child: Icon(
                                      Icons.add,
                                      color: ColorApp.mainColorApp,
                                    ),
                                  ),
                          ),
                        ),
                        ListView.separated(
                            padding: EdgeInsets.only(
                              top: 10,
                            ),
                            separatorBuilder: (ctx, index) {
                              return Divider();
                            },
                            shrinkWrap: true,
                            itemCount: controller.items.length,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    dense: true,
                                    contentPadding: EdgeInsets.only(
                                      left: 20,
                                    ),
                                    title: Text(
                                      "From ${controller.items[index]['rack_code'].toString()}",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    trailing: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5.0, right: 20.0, left: 20.0),
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(5),
                                        onTap: () {
                                          controller.removeItem(
                                              indexItem: index);
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          child: Text(
                                            "Hapus",
                                            style: TextStyle(
                                              color: Colors.red[400],
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    dense: true,
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.grey[100],
                                      child: Text(
                                        "${index + 1}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 13,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      controller.items[index]['name']
                                          .toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 13,
                                        color: Colors.black,
                                      ),
                                    ),
                                    subtitle: Text(
                                      controller.items[index]
                                              ['warehouse_receipt_code']
                                          .toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 13,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    trailing: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: TextFormField(
                                        controller:
                                            controller.qtyController[index],
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        cursorColor: ColorApp.mainColorApp,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        onFieldSubmitted: (val) {
                                          controller.changeQtyEachItem(
                                              indexItem: index,
                                              newQty: int.parse(val));
                                        },
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          disabledBorder: UnderlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.transparent)),
                                          enabledBorder:
                                              new UnderlineInputBorder(
                                                  borderSide: new BorderSide(
                                                      color:
                                                          Colors.transparent)),
                                          focusedBorder:
                                              new UnderlineInputBorder(
                                                  borderSide: new BorderSide(
                                                      color:
                                                          Colors.transparent)),
                                          hintText: "Qty",
                                          hintStyle: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    margin: const EdgeInsets.only(
                                        top: 5.0, right: 20.0, left: 10.0),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      child: Text(
                                        "Qty on System : ${controller.items[index]['qty'].toString()}",
                                        style: TextStyle(
                                          color: ColorApp.mainColorApp,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ],
                    )
            ],
          ),
        );
      },
    );
  }
}
