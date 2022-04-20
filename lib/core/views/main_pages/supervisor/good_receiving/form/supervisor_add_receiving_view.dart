import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:sologwarehouseapp/core/controllers/main_pages/supervisor/good_receiving/form/supervisor_add_receiving_controller.dart';
import 'package:sologwarehouseapp/static/color_app.dart';
import 'package:sologwarehouseapp/static/hexa_color.dart';
import 'package:sologwarehouseapp/widgets/button.dart';

class SupervisorAddReceivingView extends StatefulWidget {
  @override
  _SupervisorAddReceivingViewState createState() =>
      _SupervisorAddReceivingViewState(); 
}

class _SupervisorAddReceivingViewState extends State<SupervisorAddReceivingView>
    with AutomaticKeepAliveClientMixin {
  final controller = Get.put(SupervisorAddReceivingController());
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<SupervisorAddReceivingController>(builder: (_) {
      return DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: Scaffold(
          bottomNavigationBar: controller.isSaveRunning
              ? Container(
                  alignment: Alignment.center,
                  height: 70,
                  margin: EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: LoadingIndicator(
                    color: ColorApp.mainColorApp,
                    indicatorType: Indicator.ballPulse,
                  ),
                )
              : Container(
                  alignment: Alignment.center,
                  height: 70,
                  margin: EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(
                              right: 5,
                            ),
                            child: AppButton().iconButton(
                              buttonColor: ColorApp.mainColorApp,
                              colorTextButton: Colors.white,
                              function: () {
                                controller.saveToDraft();
                              },
                              icon: Icon(
                                Icons.drafts_rounded,
                                color: Colors.white,
                              ),
                              textButton: "Save to Draft",
                            ),
                          ),
                        ),
                        // Expanded(
                        //   child: Container(
                        //     margin: EdgeInsets.only(
                        //       left: 5,
                        //     ),
                        //     child: AppButton().iconButton(
                        //       buttonColor: ColorApp.mainColorApp,
                        //       colorTextButton: Colors.white,
                        //       function: () {
                        //         controller.saveToFinal();
                        //       },
                        //       icon: Icon(
                        //         Icons.check,
                        //         color: Colors.white,
                        //       ),
                        //       textButton: "Save",
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
          body: NestedScrollView(
            headerSliverBuilder: (ctx, _) {
              return <Widget>[
                SliverAppBar(
                  elevation: 1,
                  backgroundColor: HexaColor("#fbfbfb"),
                  automaticallyImplyLeading: true,
                  forceElevated: false,
                  snap: false,
                  floating: false,
                  pinned: true,
                  leading: Container(
                    margin: EdgeInsets.only(left: 20.0),
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        Get.back();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.keyboard_backspace_rounded,
                          size: 22,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  bottom: TabBar(
                    unselectedLabelColor: Colors.grey,
                    labelColor: ColorApp.mainColorApp,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorWeight: 2,
                    isScrollable: true,
                    tabs: [
                      Tab(
                        text: "Basic Data",
                      ),
                      Tab(
                        text: "Items",
                      ),
                      Tab(
                        text: "Driver Info",
                      ),
                    ],
                  ),
                  title: Text(
                    "Add Receiving",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.5,
                        color: Colors.black),
                  ),
                  actions: [],
                )
              ];
            },
            body: TabBarView(
              physics: BouncingScrollPhysics(),
              children: [
                // !! begin tab basic data
                ListView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.only(
                      top: 10,
                      bottom: MediaQuery.of(context).size.height * 0.09),
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
                    Container(
                      child: ListTile(
                        contentPadding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        onTap: () {
                          controller.changeReceiveDate(context);
                        },
                        dense: true,
                        title: Text(
                          "Receive Date",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.black),
                        ),
                        subtitle: Text(
                          "${DateFormat("dd MMM yyyy - HH:mm").format(controller.receiveDate)}",
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
                        onTap: () {
                          controller.changeCustomer();
                        },
                        dense: true,
                        title: Text(
                          "Customer",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.black),
                        ),
                        subtitle: Text(
                          controller.customer.isEmpty
                              ? "Choose customer"
                              : "${controller.customer['name']}",
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
                      margin: EdgeInsets.only(top: 10),
                      child: ListTile(
                        contentPadding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        dense: true,
                        title: Text(
                          "Shipper",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.black),
                        ),
                        subtitle: Container(
                          transform: Matrix4.translationValues(0.0, -8.0, 0.0),
                          child: Theme(
                            child: TextFormField(
                              controller: controller.shipperControllerText,
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
                                      borderSide: new BorderSide(
                                          color: Colors.transparent)),
                                  enabledBorder: new UnderlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.transparent)),
                                  focusedBorder: new UnderlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.transparent)),
                                  hintText: "Type shipper here...",
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
                            Icons.person,
                            color: Colors.grey,
                            size: 15,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.only(),
                        dense: true,
                        title: Text(
                          "Consignee",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.black),
                        ),
                        subtitle: Container(
                          transform: Matrix4.translationValues(0.0, -8.0, 0.0),
                          child: Theme(
                            child: TextFormField(
                              controller: controller.consigneeControllerText,
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
                                      borderSide: new BorderSide(
                                          color: Colors.transparent)),
                                  enabledBorder: new UnderlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.transparent)),
                                  focusedBorder: new UnderlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.transparent)),
                                  hintText: "Type consignee here...",
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
                            Icons.person,
                            color: Colors.grey,
                            size: 15,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.only(),
                        dense: true,
                        title: Text(
                          "Destination",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.black),
                        ),
                        subtitle: Container(
                          transform: Matrix4.translationValues(0.0, -8.0, 0.0),
                          child: Theme(
                            child: TextFormField(
                              controller: controller.destinationControllerText,
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
                                      borderSide: new BorderSide(
                                          color: Colors.transparent)),
                                  enabledBorder: new UnderlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.transparent)),
                                  focusedBorder: new UnderlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.transparent)),
                                  hintText: "Type destination here...",
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
                            Icons.location_on_rounded,
                            color: Colors.grey,
                            size: 15,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.only(),
                        dense: true,
                        title: Text(
                          "Sender SJ Number",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.black),
                        ),
                        subtitle: Container(
                          transform: Matrix4.translationValues(0.0, -8.0, 0.0),
                          child: Theme(
                            child: TextFormField(
                              controller:
                                  controller.senderSJNumberControllerText,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.characters,
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
                                  hintText: "Type sender here...",
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
                            Icons.send_rounded,
                            color: Colors.grey,
                            size: 15,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      transform: Matrix4.translationValues(0.0, -8.0, 0.0),
                      child: ListTile(
                        contentPadding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        onTap: () {
                          controller.changeVehicle();
                        },
                        dense: true,
                        title: Text(
                          "Vehicle",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.black),
                        ),
                        subtitle: Text(
                          controller.vehicle.isEmpty
                              ? "Choose vehicle"
                              : "${controller.vehicle['name']}",
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
                    //
                    Container(
                      padding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.only(),
                        dense: true,
                        title: Text(
                          "Description",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.black),
                        ),
                        subtitle: Container(
                          transform: Matrix4.translationValues(0.0, -8.0, 0.0),
                          child: Theme(
                            child: TextFormField(
                              controller: controller.descriptionControllerText,
                              keyboardType: TextInputType.multiline,
                              textAlign: TextAlign.left,
                              maxLines: null,
                              minLines: 4,
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
                                  hintText: "Type description here...",
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
                // !! end tab basic data

                //==============================

                // !! begin tab items
                ListView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.only(
                      top: 10,
                      bottom: MediaQuery.of(context).size.height * 0.09),
                  children: [
                    Container(
                      child: ListTile(
                        contentPadding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        onTap: () {
                          if (controller.warehouse.isEmpty) {
                            Get.snackbar(
                              "Oops!",
                              // errorValue.toString(),
                              "Please choose warehouse",
                              backgroundColor: Colors.orange[400],
                              colorText: Colors.white,
                              snackPosition: SnackPosition.BOTTOM,
                              snackStyle: SnackStyle.FLOATING,
                              icon: Icon(
                                Icons.warning,
                                color: Colors.white,
                              ),
                              isDismissible: true,
                              margin: EdgeInsets.only(
                                  bottom: 10, right: 10, left: 10),
                            );
                          } else {
                            controller.addItems();
                          }
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
                          "Tap here or + button to add new item",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 13,
                              color: Colors.grey),
                        ),
                        trailing: CircleAvatar(
                          backgroundColor:
                              ColorApp.mainColorApp.withOpacity(0.1),
                          child: Icon(
                            Icons.add,
                            color: ColorApp.mainColorApp,
                          ),
                        ),
                      ),
                    ),
                    Divider(),
                    ListView.builder(
                        padding: EdgeInsets.only(),
                        shrinkWrap: true,
                        itemCount: controller.items.length,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Dismissible(
                            background: Container(
                              padding: EdgeInsets.only(right: 20),
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              child: CircleAvatar(
                                backgroundColor: Colors.white30,
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            confirmDismiss: (direction) {
                              return Future.value(
                                  direction == DismissDirection.endToStart);
                            },
                            direction: DismissDirection.endToStart,
                            key: UniqueKey(),
                            onDismissed: (direction) async {
                              controller.removeItem(index);
                            },
                            child: ListTile(
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
                                controller.items[index]['item_name'],
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${controller.items[index]['storage_type']}  ${controller.items[index]['is_use_pallet'] == 1 ? 'using Pallet' : ''}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 11,
                                          color: Colors.grey,
                                        ),
                                      ),
                                       controller.items[index]['rack']["code"] != null ?Text(
                                        ": ${controller.items[index]['rack']["code"]}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 11,
                                          color: Colors.grey,
                                        ),
                                      ) : SizedBox(),
                                    ],
                                  ),
                                  controller.items[index]['serial_number'] != null ? Text(
                                    "Pallet id : ${controller.items[index]['serial_number']} | No. Order : ${controller.items[index]['order_number']} | Batch : ${controller.items[index]['batch']}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 11,   
                                      color: Colors.grey,
                                    ),
                                  ) : SizedBox(),
                                ],
                              ),
                              trailing: Text(
                                controller.items[index]['qty'].toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: ColorApp.mainColorApp,
                                ),
                              ),
                              isThreeLine: true,
                            ),
                          );
                        }),
                  ],
                ),
                // !! end tab items

                //==============================

                // !! begin tab driver info
                ListView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.only(
                      top: 10,
                      bottom: MediaQuery.of(context).size.height * 0.09),
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.only(),
                        dense: true,
                        title: Text(
                          "Driver Name",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.black),
                        ),
                        subtitle: Container(
                          transform: Matrix4.translationValues(0.0, -8.0, 0.0),
                          child: Theme(
                            child: TextFormField(
                              controller: controller.driverNameControllerText,
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
                                      borderSide: new BorderSide(
                                          color: Colors.transparent)),
                                  enabledBorder: new UnderlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.transparent)),
                                  focusedBorder: new UnderlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.transparent)),
                                  hintText: "Type driver name here...",
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
                            Icons.person,
                            color: Colors.grey,
                            size: 15,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.only(),
                        dense: true,
                        title: Text(
                          "Vehicle Registration Number",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.black),
                        ),
                        subtitle: Container(
                          transform: Matrix4.translationValues(0.0, -8.0, 0.0),
                          child: Theme(
                            child: TextFormField(
                              controller:
                                  controller.vehicleRegNumberControllerText,
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
                                      borderSide: new BorderSide(
                                          color: Colors.transparent)),
                                  enabledBorder: new UnderlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.transparent)),
                                  focusedBorder: new UnderlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.transparent)),
                                  hintText:
                                      "Type vehicle registration number here...",
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
                            Icons.confirmation_number_rounded,
                            color: Colors.grey,
                            size: 15,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.only(),
                        dense: true,
                        title: Text(
                          "Phone Number",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.black),
                        ),
                        subtitle: Container(
                          transform: Matrix4.translationValues(0.0, -8.0, 0.0),
                          child: Theme(
                            child: TextFormField(
                              controller: controller.phoneNumberControllerText,
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
                                  hintText: "Type phone number here...",
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
                            Icons.phone,
                            color: Colors.grey,
                            size: 15,
                          ),
                        ),
                      ),
                    ),
                    Divider(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: ListTile(
                            contentPadding: EdgeInsets.only(
                              left: 20,
                              right: 20,
                            ),
                            onTap: () async {
                              controller.addNewSignature();
                            },
                            dense: true,
                            title: Text(
                              "Driver's Signature",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                            subtitle: Text(
                              "Add new signature by tap + button",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 13,
                                  color: Colors.grey),
                            ),
                            trailing: CircleAvatar(
                              backgroundColor:
                                  ColorApp.mainColorApp.withOpacity(0.1),
                              child: Icon(
                                Icons.add,
                                color: ColorApp.mainColorApp,
                              ),
                            ),
                          ),
                        ),
                        controller.signatureImage == null
                            ? Opacity(
                                opacity: 0,
                              )
                            : Container(
                                margin: EdgeInsets.only(
                                  top: 10,
                                ),
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: MediaQuery.of(context).size.width * 0.6,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      width: 0.2, color: Colors.grey),
                                ),
                                child: Image.memory(
                                  controller.signatureImage!,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  height:
                                      MediaQuery.of(context).size.width * 0.6,
                                  fit: BoxFit.contain,
                                ),
                              )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                          "Select source from where do you want to pick file. You can select multiple files",
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
                                            Icons.camera_alt,
                                            color: ColorApp.mainColorApp,
                                          ),
                                        ),
                                        onTap: () {
                                          controller.getImage(
                                              from: ImageSource.camera);
                                          // controller.getImageToFirebase(from: ImageSource.gallery);
                                        },
                                        title: Text(
                                          "Camera",
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
                                            Icons.collections,
                                            color: ColorApp.mainColorApp,
                                          ),
                                        ),
                                        onTap: () {
                                          controller.getMultipleImages();
                                        },
                                        title: Text(
                                          "Gallery",
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
                              "Attach files",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                            subtitle: Text(
                              "You can add multiple files here (images)",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 13,
                                  color: Colors.grey),
                            ),
                            trailing: CircleAvatar(
                              backgroundColor:
                                  ColorApp.mainColorApp.withOpacity(0.1),
                              child: Icon(
                                Icons.add,
                                color: ColorApp.mainColorApp,
                              ),
                            ),
                          ),
                        ),
                        ListView.builder(
                            padding: EdgeInsets.only(
                              top: 10,
                            ),
                            shrinkWrap: true,
                            itemCount: controller.attachmentFiles.length,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return Dismissible(
                                background: Container(
                                  padding: EdgeInsets.only(right: 20),
                                  color: Colors.red,
                                  alignment: Alignment.centerRight,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white30,
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                confirmDismiss: (direction) {
                                  return Future.value(
                                      direction == DismissDirection.endToStart);
                                },
                                direction: DismissDirection.endToStart,
                                key: UniqueKey(),
                                onDismissed: (direction) async {
                                  controller.removeAttachment(index);
                                },
                                child: ListTile(
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
                                    controller.attachmentFiles[index].path
                                        .split('/')
                                        .last,
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 13,
                                      color: Colors.black,
                                    ),
                                  ),
                                  trailing: Image.file(
                                    controller.attachmentFiles[index],
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            }),
                      ],
                    ),
                  ],
                ),
                // !! end tab driver info
              ],
            ),
          ),
        ),
      );
    });
  }

  @override
  bool get wantKeepAlive => true;
}
