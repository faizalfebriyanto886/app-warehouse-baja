// ignore_for_file: unnecessary_statements

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sologwarehouseapp/core/controllers/main_pages/supervisor/good_receiving/form/supervisor_add_item_receiving_controller.dart';
import 'package:sologwarehouseapp/static/color_app.dart';
import 'package:sologwarehouseapp/widgets/app_bar.dart';

class SupervisorAddItemReceiving extends StatelessWidget {
  final controller = Get.put(SupervisorAddItemReceivingController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupervisorAddItemReceivingController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBarUI().appBarWithBackButton(
            actionBackButton: () {
              Get.back();
            },
            actionButton: [],
            title: "Add new item",
          ),
          floatingActionButton: 
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(
                  right: 15,
                  bottom: 15,
                ),
                child: FloatingActionButton(
                  backgroundColor: ColorApp.mainColorApp,
                  onPressed: () {
                    controller.saveItem();
                  },
                  elevation: 0.2,
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  right: 15,
                  bottom: 0,
                ),
                child: FloatingActionButton(
                  backgroundColor: ColorApp.mainColorApp,
                  onPressed: () {
                    controller.nextItems();
                    
                  },
                  elevation: 0.2,
                  child: Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                  ),
                ),
              ),  
            ],
          ),
          body: ListView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.09,
            ),
            physics: BouncingScrollPhysics(),
            children: [
              Container(
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
                                "Select imposition here",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 13,
                                    color: Colors.grey),
                              ),
                            ),
                            for (int i = 0;
                                i < controller.imposition.length;
                                i++)
                              ListTile(
                                leading: CircleAvatar(
                                  backgroundColor:
                                      ColorApp.mainColorApp.withOpacity(0.1),
                                  child: Icon(
                                    Icons.circle,
                                    color: ColorApp.mainColorApp,
                                  ),
                                ),
                                onTap: () {
                                  controller.changeSelectedImposition(i);
                                },
                                title: Text(
                                  controller.imposition[i]['name'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                      color: Colors.black),
                                ),
                              )
                          ],
                        ),
                      ),
                      backgroundColor: Colors.white,
                    );
                  },
                  dense: true,
                  title: Text(
                    "Imposition",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                  subtitle: Text(
                    controller.selectedImposition['name'],
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 13,
                        color: Colors.grey),
                  ),
                ),
              ),
              Container(
                child: ListTile(
                  contentPadding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  onTap: () {
                    controller.changeItems();
                  },
                  dense: true,
                  title: Text(
                    "Item",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                  subtitle: Text(
                    controller.item.isEmpty
                        ? "Choose item here"
                        : "${controller.item['code']}-${controller.item['name']}",
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
              Container(
                margin: EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(5),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 10,
                            right: 10,
                            top: 5,
                            bottom: 5,
                          ),
                          child: Text(
                            "or scan barcode item",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: ColorApp.mainColorApp,
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              Divider(),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: ListTile(
                  contentPadding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  dense: true,
                  title: Text(
                    "Quantity",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                  subtitle: Container(
                    transform: Matrix4.translationValues(0.0, -8.0, 0.0),
                    child: Theme(
                      child: TextFormField(
                        controller: controller.quantityItemControllerText,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        cursorColor: ColorApp.mainColorApp,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                        ),
                        obscureText: false,
                        decoration: InputDecoration(
                            disabledBorder: UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.transparent)),
                            enabledBorder: new UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.transparent)),
                            focusedBorder: new UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.transparent)),
                            hintText: "Type quantity here...",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                              fontWeight: FontWeight.normal,
                            )),
                      ),
                      data: Theme.of(context).copyWith(
                        primaryColor: ColorApp.mainColorApp,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child:controller.packageWrite ?
                   ListTile(
                  contentPadding: EdgeInsets.only(),
                  dense: true,
                  title: Text(
                    "Package",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                  subtitle: Container(
                    transform: Matrix4.translationValues(0.0, -8.0, 0.0),
                    child: Theme(
                      child: TextFormField(
                        controller: controller.packageControllerText,
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        cursorColor: ColorApp.mainColorApp,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                        ),
                        obscureText: false,
                        decoration: InputDecoration(
                            disabledBorder: UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.transparent)),
                            enabledBorder: new UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.transparent)),
                            focusedBorder: new UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.transparent)),
                            hintText: "Write here ...",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                              fontWeight: FontWeight.normal,
                            )),
                      ),
                      data: Theme.of(context).copyWith(
                        primaryColor: ColorApp.mainColorApp,
                      ),
                    ),
                  ),
                  trailing: CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.grey[200],
                    child: Icon(
                      Icons.archive,
                      color: Colors.grey,
                      size: 15,
                    ),
                  ),
                )
                 : 
                 Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Package",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.black),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                            value: controller.packgeValue[0], 
                            onChanged: (val){
                              print(controller.packgeValue[1]);
                              if(controller.packgeValue[1] == true || controller.packgeValue[2] == true ||controller.packgeValue[3] == true){
                                print("Tidak bisa diubah");
                              } else {
                                print("Bisa diubah");
                                print(val);
                                controller.packgeValue[0] = val;
                                controller.packageControllerText.text = "CASE";
                                controller.update();
                              }
                            }),
                            Text("CASE",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              )
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                            value: controller.packgeValue[1], 
                            onChanged: (val){
                              if(controller.packgeValue[0] == true || controller.packgeValue[2] == true ||controller.packgeValue[3] == true){
                                print("Tidak bisa diubah");
                              } else {
                                print("Bisa diubah");
                                print(val);
                                controller.packgeValue[1] = val;
                                controller.packageControllerText.text = "PETI";
                                controller.update();
                              }
                            }),
                            Text("PETI",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              )
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                            value: controller.packgeValue[2], 
                            onChanged: (val){
                                if(controller.packgeValue[0] == true || controller.packgeValue[1] == true ||controller.packgeValue[3] == true){
                                  print("Tidak bisa diubah");
                                } else {
                                  print("Bisa diubah");
                                  print(val);
                                  controller.packgeValue[2] = val;
                                  controller.packageControllerText.text = "PALLET";
                                  controller.update();
                                }
                            }),
                            Text("PALLET",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              )
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                            value: controller.packgeValue[3], 
                            onChanged: (val){
                                if(controller.packgeValue[0] == true || controller.packgeValue[1] == true ||controller.packgeValue[2] == true){
                                  print("Tidak bisa diubah");
                                } else {
                                  print("Bisa diubah");
                                  print(val);
                                  controller.packgeValue[3] = val;
                                  controller.packageControllerText.text = "BAG";
                                  controller.update();
                                }
                            }),
                            Text("BAG",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              )
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height:6,),
                    GestureDetector(
                      onTap: (){
                        controller.packageWrite = true;
                        controller.packageControllerText.text = "";
                        controller.update();
                      },
                      child: Row(
                        children: [
                          Icon(Icons.edit, color: Colors.grey,),
                          SizedBox(width: 4,),
                          Text("Write manually?",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          )
                        ),
                        ],
                      ),
                    ),
                    SizedBox(height:10,),
                    // ListTile(
                    //   title: Text("Write manually",
                    //     style: TextStyle(
                    //       color: Colors.grey,
                    //       fontSize: 14,
                    //       fontWeight: FontWeight.normal,
                    //     )
                    //   ),
                    //   onTap: (){
                    //     controller.packageWrite = true;
                    //     controller.packageControllerText.text = "";
                    //     controller.update();
                    //   },
                    //   trailing: Icon(Icons.edit)
                    // )
                  ],
                )
               
              ),
              Container(
                child: ListTile(
                  contentPadding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  dense: true,
                  title: Text(
                    "Weight",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                  subtitle: Container(
                    transform: Matrix4.translationValues(0.0, -8.0, 0.0),
                    child: Theme(
                      child: TextFormField(
                        controller: controller.weightControllerText,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        cursorColor: ColorApp.mainColorApp,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                        ),
                        obscureText: false,
                        decoration: InputDecoration(
                            disabledBorder: UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.transparent)),
                            enabledBorder: new UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.transparent)),
                            focusedBorder: new UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.transparent)),
                            hintText: "Type weight here...",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                              fontWeight: FontWeight.normal,
                            )),
                      ),
                      data: Theme.of(context).copyWith(
                        primaryColor: ColorApp.mainColorApp,
                      ),
                    ),
                  ),
                  trailing: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.grey[200],
                    child: Text(
                      "kg",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                child: ListTile(
                  contentPadding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  dense: true,
                  title: Text(
                    "Length",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                  subtitle: Container(
                    transform: Matrix4.translationValues(0.0, -8.0, 0.0),
                    child: Theme(
                      child: TextFormField(
                        controller: controller.lengthControllerText,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        cursorColor: ColorApp.mainColorApp,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                        ),
                        obscureText: false,
                        decoration: InputDecoration(
                            disabledBorder: UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.transparent)),
                            enabledBorder: new UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.transparent)),
                            focusedBorder: new UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.transparent)),
                            hintText: "Type quantity here...",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                              fontWeight: FontWeight.normal,
                            )),
                      ),
                      data: Theme.of(context).copyWith(
                        primaryColor: ColorApp.mainColorApp,
                      ),
                    ),
                  ),
                  trailing: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.grey[200],
                    child: Text(
                      "cm",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                child: ListTile(
                  contentPadding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  dense: true,
                  title: Text(
                    "Width",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                  subtitle: Container(
                    transform: Matrix4.translationValues(0.0, -8.0, 0.0),
                    child: Theme(
                      child: TextFormField(
                        controller: controller.widthControllerText,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        cursorColor: ColorApp.mainColorApp,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                        ),
                        obscureText: false,
                        decoration: InputDecoration(
                            disabledBorder: UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.transparent)),
                            enabledBorder: new UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.transparent)),
                            focusedBorder: new UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.transparent)),
                            hintText: "Type width here...",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                              fontWeight: FontWeight.normal,
                            )),
                      ),
                      data: Theme.of(context).copyWith(
                        primaryColor: ColorApp.mainColorApp,
                      ),
                    ),
                  ),
                  trailing: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.grey[200],
                    child: Text(
                      "cm",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                child: ListTile(
                  contentPadding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  dense: true,
                  title: Text(
                    "Height",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                  subtitle: Container(
                    transform: Matrix4.translationValues(0.0, -8.0, 0.0),
                    child: Theme(
                      child: TextFormField(
                        controller: controller.heightControllerText,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        cursorColor: ColorApp.mainColorApp,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                        ),
                        obscureText: false,
                        decoration: InputDecoration(
                            disabledBorder: UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.transparent)),
                            enabledBorder: new UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.transparent)),
                            focusedBorder: new UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.transparent)),
                            hintText: "Type height here...",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                              fontWeight: FontWeight.normal,
                            )),
                      ),
                      data: Theme.of(context).copyWith(
                        primaryColor: ColorApp.mainColorApp,
                      ),
                    ),
                  ),
                  trailing: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.grey[200],
                    child: Text(
                      "cm",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
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
                                "Select storage here",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 13,
                                    color: Colors.grey),
                              ),
                            ),
                            for (int i = 0; i < controller.storage.length; i++)
                              ListTile(
                                leading: CircleAvatar(
                                  backgroundColor:
                                      ColorApp.mainColorApp.withOpacity(0.1),
                                  child: Icon(
                                    Icons.circle,
                                    color: ColorApp.mainColorApp,
                                  ),
                                ),
                                onTap: () {
                                  controller.changeSelectedStorage(i);
                                },
                                title: Text(
                                  controller.storage[i]['title'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                      color: Colors.black),
                                ),
                              )
                          ],
                        ),
                      ),
                      backgroundColor: Colors.white,
                    );
                  },
                  dense: true,
                  title: Text(
                    "Storage Type",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                  subtitle: Text(
                    controller.selectedStorageTitle,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 13,
                        color: Colors.grey),
                  ),
                ),
              ),
              controller.selectedStorageTitle != controller.storage[0]['title']
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
                          controller.changeRack();
                        },
                        dense: true,
                        title: Text(
                          "Rack",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.black),
                        ),
                        subtitle: Text(
                          controller.rack.isEmpty
                              ? "Choose rack here"
                              : "${controller.rack['code']}",
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
              Container(
                transform: Matrix4.translationValues(0.0, -8.0, 0.0),
                margin: EdgeInsets.only(
                  left: 10,
                  right: 20,
                ),
                child: CheckboxListTile(
                  contentPadding: EdgeInsets.only(),
                  title: Text(
                    "Use pallet?",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 13,
                        color: Colors.black),
                  ),
                  value: controller.isUsePallet,
                  onChanged: (value) {
                    controller.changeStatusIsUsePallet(value!);
                  },
                  controlAffinity:
                      ListTileControlAffinity.leading, //  <-- leading Checkbox
                ),
              ),
              !controller.isUsePallet
                  ? Opacity(
                      opacity: 0,
                    )
                  : Column(
                      children: [
                        Container(
                          child: ListTile(
                            contentPadding: EdgeInsets.only(
                              left: 20,
                              right: 20,
                            ),
                            onTap: () {
                              controller.changePallet();
                            },
                            dense: true,
                            title: Text(
                              "Pallet",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                            subtitle: Text(
                              controller.pallet.isEmpty
                                  ? "Choose pallet"
                                  : "${controller.pallet['name']} - ${controller.pallet['category']}",
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
                        Container(
                          child: ListTile(
                            contentPadding: EdgeInsets.only(
                              left: 20,
                              right: 20,
                            ),
                            dense: true,
                            title: Text(
                              "Pallet Qty",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                            subtitle: Container(
                              transform:
                                  Matrix4.translationValues(0.0, -8.0, 0.0),
                              child: Theme(
                                child: TextFormField(
                                  controller:
                                      controller.palletQtyControllerText,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.left,
                                  maxLines: 1,
                                  cursorColor: ColorApp.mainColorApp,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  obscureText: false,
                                  decoration: InputDecoration(
                                      disabledBorder: UnderlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.transparent)),
                                      enabledBorder: new UnderlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.transparent)),
                                      focusedBorder: new UnderlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.transparent)),
                                      hintText: "Type pallet qty here...",
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 13,
                                        fontWeight: FontWeight.normal,
                                      )),
                                ),
                                data: Theme.of(context).copyWith(
                                  primaryColor: ColorApp.mainColorApp,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
              Container(
                child: ListTile(
                  contentPadding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  dense: true,
                  title: Text(
                    "Pallet id",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                  subtitle: Container(
                    transform: Matrix4.translationValues(0.0, -8.0, 0.0),
                    child: Theme(
                      child: TextFormField(
                        controller: controller.noSeriControllerText,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        cursorColor: ColorApp.mainColorApp,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                        ),
                        obscureText: false,
                        decoration: InputDecoration(
                            disabledBorder: UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.transparent)),
                            enabledBorder: new UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.transparent)),
                            focusedBorder: new UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.transparent)),
                            hintText: "Type palet id here...",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                              fontWeight: FontWeight.normal,
                            )),
                      ),
                      data: Theme.of(context).copyWith(
                        primaryColor: ColorApp.mainColorApp,
                      ),
                    ),
                  ),
                  trailing: GestureDetector(
                    onTap: ()=> controller.scan(context),
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.grey[200],
                      child: Icon(Icons.qr_code_scanner)
                    ),
                  ),
                ),
              ),
              Container(
                child: ListTile(
                  contentPadding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  dense: true,
                  title: Text(
                    "No Order",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                  subtitle: Container(
                    transform: Matrix4.translationValues(0.0, -8.0, 0.0),
                    child: Theme(
                      child: TextFormField(
                        controller: controller.orderNumberControllerText,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        cursorColor: ColorApp.mainColorApp,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                        ),
                        obscureText: false,
                        decoration: InputDecoration(
                            disabledBorder: UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.transparent)),
                            enabledBorder: new UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.transparent)),
                            focusedBorder: new UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.transparent)),
                            hintText: "Type no order here...",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                              fontWeight: FontWeight.normal,
                            )),
                      ),
                      data: Theme.of(context).copyWith(
                        primaryColor: ColorApp.mainColorApp,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                child: ListTile(
                  contentPadding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  dense: true,
                  title: Text(
                    "Batch",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                  subtitle: Container(
                    transform: Matrix4.translationValues(0.0, -8.0, 0.0),
                    child: Theme(
                      child: TextFormField(
                        controller: controller.batchControllerText,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        cursorColor: ColorApp.mainColorApp,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                        ),
                        obscureText: false,
                        decoration: InputDecoration(
                            disabledBorder: UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.transparent)),
                            enabledBorder: new UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.transparent)),
                            focusedBorder: new UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.transparent)),
                            hintText: "Type batch here...",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                              fontWeight: FontWeight.normal,
                            )),
                      ),
                      data: Theme.of(context).copyWith(
                        primaryColor: ColorApp.mainColorApp,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
