import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sologwarehouseapp/core/controllers/main_pages/supervisor/good_receiving/supervisor_good_receiving_detail_controller.dart';
import 'package:sologwarehouseapp/static/color_app.dart';
import 'package:sologwarehouseapp/widgets/app_bar.dart';
import 'package:sologwarehouseapp/widgets/button.dart';
import 'package:sologwarehouseapp/widgets/waiting_widget.dart';

class SupervisorGoodReceivingDetailView extends StatefulWidget {
  @override
  State<SupervisorGoodReceivingDetailView> createState() => _SupervisorGoodReceivingDetailViewState();
}

class _SupervisorGoodReceivingDetailViewState extends State<SupervisorGoodReceivingDetailView> {
  final controller = Get.put(SupervisorGoodReceivingDetailController());

  bool isChecked = false;
  var selectedIndex = [];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupervisorGoodReceivingDetailController>(builder: (_) {
      return Scaffold(
        appBar: AppBarUI().appBarWithBackButton(
            actionButton: [],
            title: "Good Receive Detail",
            actionBackButton: () {
              Get.back();
            }),
        bottomNavigationBar: controller.isLoading &&
                controller.goodReceivingDetail.isEmpty
            ? null
            : !controller.isLoading && controller.goodReceivingDetail.isEmpty
                ? null
                : controller.goodReceivingDetail['item']['status'].toString() ==
                        "0"
                    ? Container(
                        height: 60,
                        margin: EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        child: controller.isLoadingApprove
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
                            : AppButton().iconButton(
                                icon: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                ),
                                buttonColor: ColorApp.mainColorApp,
                                colorTextButton: Colors.white,
                                function: () {
                                  controller.approveReceipt();
                                },
                                textButton: "Approve",
                              ),
                      )
                    : null,
        body: controller.isLoading && controller.goodReceivingDetail.isEmpty
            ? WaitingWidget()
            : !controller.isLoading && controller.goodReceivingDetail.isEmpty
                ? EmptyWidget()
                : ListView(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.09,
                    ),
                    physics: BouncingScrollPhysics(),
                    children: [
                      ListTile(
                        dense: true,
                        leading: CircleAvatar(
                          backgroundColor:
                              ColorApp.mainColorApp.withOpacity(0.2),
                          child: Icon(
                            Icons.tag,
                            color: ColorApp.mainColorApp,
                          ),
                        ),
                        title: Text(
                          "Code",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        subtitle: Text(
                          controller.goodReceivingDetail['item']['code'],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      ListTile(
                        dense: true,
                        leading: CircleAvatar(
                          backgroundColor: Colors.brown.withOpacity(0.2),
                          child: Icon(
                            Icons.picture_in_picture_rounded,
                            color: Colors.brown,
                          ),
                        ),
                        title: Text(
                          "Purchase Order Code",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        subtitle: Text(
                          controller.goodReceivingDetail['item']
                              ['purchase_order_code'],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      ListTile(
                        dense: true,
                        leading: CircleAvatar(
                          backgroundColor: Colors.indigo.withOpacity(0.2),
                          child: Icon(
                            Icons.ac_unit_sharp,
                            color: Colors.indigo,
                          ),
                        ),
                        title: Text(
                          "Status",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        subtitle: Text(
                          controller.goodReceivingDetail['item']['status_name'],
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      ListTile(
                        dense: true,
                        leading: CircleAvatar(
                          backgroundColor: Colors.lightGreen.withOpacity(0.2),
                          child: Icon(
                            Icons.description,
                            color: Colors.lightGreen,
                          ),
                        ),
                        title: Text(
                          "Description",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        subtitle: Text(
                          controller.goodReceivingDetail['item']
                                      ['description'] ==
                                  null
                              ? "-"
                              : controller.goodReceivingDetail['item']
                                  ['description'],
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      Divider(),
                      Container(
                        margin: EdgeInsets.only(
                          left: 20,
                          top: 15,
                          bottom: 5,
                        ),
                        child: Text(
                          "Warehouse",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      ListTile(
                        dense: true,
                        leading: CircleAvatar(
                          backgroundColor: Colors.pink.withOpacity(0.2),
                          child: Icon(
                            Icons.location_on,
                            color: Colors.pink,
                          ),
                        ),
                        title: Text(
                          "Warehouse",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        subtitle: Text(
                          controller.goodReceivingDetail['item']['warehouse']
                              ['name'],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      ListTile(
                        dense: true,
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue.withOpacity(0.2),
                          child: Icon(
                            Icons.person,
                            color: Colors.blue,
                          ),
                        ),
                        title: Text(
                          "Warehouse Staff",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        subtitle: Text(
                          controller.goodReceivingDetail['item']
                              ['warehouse_staff']['name'],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      ListTile(
                        dense: true,
                        leading: CircleAvatar(
                          backgroundColor: Colors.green.withOpacity(0.2),
                          child: Icon(
                            Icons.person_pin_rounded,
                            color: Colors.green,
                          ),
                        ),
                        title: Text(
                          "Customer",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        subtitle: Text(
                          controller.goodReceivingDetail['item']['customer'] ==
                                  null
                              ? "-"
                              : controller.goodReceivingDetail['item']
                                      ['customer']['name']
                                  .toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      Divider(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              left: 20,
                              top: 15,
                              bottom: 5,
                            ),
                            child: Text(
                              "Vehicle",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          ListTile(
                            dense: true,
                            leading: CircleAvatar(
                              backgroundColor:
                                  Colors.deepPurple.withOpacity(0.2),
                              child: Icon(
                                Icons.car_repair,
                                color: Colors.deepPurple,
                              ),
                            ),
                            title: Text(
                              "Vehicle Type Name",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            subtitle: Text(
                              controller.goodReceivingDetail['item']
                                          ['vehicle_type_name'] ==
                                      null
                                  ? "-"
                                  : controller.goodReceivingDetail['item']
                                      ['vehicle_type_name'],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      Container(
                        margin: EdgeInsets.only(
                          left: 20,
                          top: 15,
                          bottom: 5,
                        ),
                        child: Text(
                          "Date",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      ListTile(
                        dense: true,
                        leading: CircleAvatar(
                          backgroundColor: Colors.blueGrey.withOpacity(0.2),
                          child: Icon(
                            Icons.date_range,
                            color: Colors.blueGrey,
                          ),
                        ),
                        title: Text(
                          "Receive Date",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        subtitle: Text(
                          DateFormat("dd MMM yyyy - HH:mm").format(
                              DateTime.parse(
                                  controller.goodReceivingDetail['item']
                                      ['receive_date'])),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      ListTile(
                        dense: true,
                        leading: CircleAvatar(
                          backgroundColor: Colors.orange.withOpacity(0.2),
                          child: Icon(
                            Icons.date_range,
                            color: Colors.orange,
                          ),
                        ),
                        title: Text(
                          "Stripping Done",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        subtitle: Text(
                          controller.goodReceivingDetail['item']
                                      ['stripping_done'] ==
                                  null
                              ? "-"
                              : DateFormat("dd MMM yyyy - HH:mm").format(
                                  DateTime.parse(
                                      controller.goodReceivingDetail['item']
                                          ['stripping_done'])),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      Divider(),
                      Container(
                        margin: EdgeInsets.only(
                          left: 20,
                          right: 20,
                          // top: 15,
                          // bottom: 5,
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.only(),
                          title: Text(
                            "Items",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                          trailing: GestureDetector(
                            onTap: ()=> controller.scan(context),
                            child: Icon(
                              Icons.qr_code_scanner,
                              color: Colors.blue,
                            ),
                          )
                          // trailing: controller.goodReceivingDetail['item']
                          //                 ['status']
                          //             .toString() ==
                          //         "1"
                          //     ? null
                          //     : GestureDetector(
                          //         onTap: () {
                          //           Get.to(
                          //             () => SupervisorEditReceivingView(),
                          //             arguments: {
                          //               "receipt_id": controller
                          //                   .goodReceivingDetail['item']['id'],
                          //             },
                          //           );
                          //         },
                          //         child: CircleAvatar(
                          //           backgroundColor:
                          //               ColorApp.mainColorApp.withOpacity(0.2),
                          //           child: Icon(
                          //             Icons.edit,
                          //             color: ColorApp.mainColorApp,
                          //           ),
                          //         ),
                          //       ),
                        ),
                      ),
                      ListView.builder(
                        itemCount: controller.goodReceivingDetail['detail'].length,
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.only(),
                        itemBuilder: (ctx, index) {
                          return Container(
                            margin: EdgeInsets.only(
                              bottom: 20,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  contentPadding: EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  dense: true,
                                  leading: Checkbox(
                                    value: controller.isChecked[index],
                                    onChanged: (bool? value) {
                                      controller.isChecked[index] = value!;
                                      controller.update();
                                      setState(() {
                                      });
                                    },
                                  ),
                                  // GestureDetector(
                                  //   onTap: null,
                                  //   child: Icon(Icons.check_box_outline_blank)
                                  // ),
                                  //  CircleAvatar(
                                  //   backgroundColor:
                                  //       Colors.grey.withOpacity(0.2),
                                  //   child: Text(
                                  //     "${index + 1}",
                                  //     style: TextStyle(
                                  //         color: Colors.black,
                                  //         fontSize: 12,
                                  //         fontWeight: FontWeight.normal),
                                  //   ),
                                  // ),
                                  title: Text(
                                    controller.goodReceivingDetail['detail'][index]['item_name'].toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  subtitle: Text(
                                    controller.goodReceivingDetail['detail'][index]['imposition_name'].toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  trailing: Text(
                                    controller.goodReceivingDetail['detail'][index]['qty'].toString() + " Pallet",
                                    style: TextStyle(
                                      color: ColorApp.mainColorApp,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  child: RichText(
                                    text: TextSpan(children: <WidgetSpan>[
                                      WidgetSpan(
                                        child: Text(
                                          "Storage type : ${controller.goodReceivingDetail['detail'][index]['rack'] == null ? '-' : controller.goodReceivingDetail['detail'][index]['rack']['code']}",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      controller.goodReceivingDetail['detail']
                                                  [index]['pallet'] ==
                                              null
                                          ? WidgetSpan(
                                              child: Opacity(
                                              opacity: 0,
                                            ))
                                          : WidgetSpan(
                                              child: Text(
                                                " · Pallet : ${controller.goodReceivingDetail['detail'][index]['pallet'] == null ? '' : controller.goodReceivingDetail['detail'][index]['pallet']['name']} ",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                    ]),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      controller.goodReceivingDetail['surat_jalan'].isEmpty
                          ? Opacity(
                              opacity: 0,
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Divider(),
                                Container(
                                  margin: EdgeInsets.only(
                                    left: 20,
                                    top: 15,
                                    bottom: 5,
                                  ),
                                  child: Text(
                                    "Attachment files",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 300,
                                  child: ListView.builder(
                                      itemCount: controller.goodReceivingDetail['surat_jalan'].length,
                                      physics: BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      padding: EdgeInsets.only(
                                        left: 20,
                                        top: 10,
                                      ),
                                      itemBuilder: (ctx, index) {
                                        return Container(
                                          margin: EdgeInsets.only(
                                            right: 15,
                                          ),
                                          child: Image.network(
                                              controller.goodReceivingDetail[
                                                  'surat_jalan'][index]),
                                        );
                                      }),
                                )
                              ],
                            ),
                    ],
                  ),
      );
    });
  }
}
