import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sologwarehouseapp/core/controllers/main_pages/supervisor/scanner/supervisor_detail_item_scan_controller.dart';
import 'package:sologwarehouseapp/static/color_app.dart';
import 'package:sologwarehouseapp/widgets/app_bar.dart';
import 'package:sologwarehouseapp/widgets/button.dart';
import 'package:sologwarehouseapp/widgets/waiting_widget.dart';

class SupervisorDetailItemScanView extends StatelessWidget {
  final controller = Get.put(SupervisorDetailItemScanController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupervisorDetailItemScanController>(builder: (_) {
      return Scaffold(
        bottomNavigationBar: Container(
          height: 60,
          margin: EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: AppButton().iconButton(
            buttonColor: ColorApp.mainColorApp,
            colorTextButton: Colors.white,
            function: () {
              Get.back();
            },
            icon: Icon(
              Icons.close,
              color: Colors.white,
            ),
            textButton: "Close",
          ),
        ),
        appBar: AppBarUI().appBarWithBackButton(
            actionButton: [],
            title: controller.itemCode,
            actionBackButton: () {
              Get.back();
            }),
        body: controller.isLoading && controller.detailItem.isEmpty
            ? WaitingWidget()
            : !controller.isLoading && controller.detailItem.isEmpty
                ? EmptyWidget()
                : ListView(
                    padding: EdgeInsets.only(),
                    physics: BouncingScrollPhysics(),
                    children: [
                      ListTile(
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
                          controller.detailItem['code'].toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.brown.withOpacity(0.2),
                          child: Icon(
                            Icons.business_rounded,
                            color: Colors.brown,
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
                          controller.detailItem['customer_name'] == null
                              ? "-"
                              : controller.detailItem['customer_name']
                                  .toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      // ListTile(
                      //   leading: CircleAvatar(
                      //     backgroundColor: Colors.red.withOpacity(0.2),
                      //     child: Icon(
                      //       Icons.location_on,
                      //       color: Colors.red,
                      //     ),
                      //   ),
                      //   title: Text(
                      //     "Bin Location",
                      //     style: TextStyle(
                      //       color: Colors.grey,
                      //       fontSize: 12,
                      //     ),
                      //   ),
                      //   subtitle: Text(
                      //     controller.detailItem['rack_code'].toString(),
                      //     style: TextStyle(
                      //       color: Colors.black,
                      //       fontSize: 15,
                      //     ),
                      //   ),
                      // ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.lightBlue.withOpacity(0.2),
                          child: Icon(
                            Icons.compass_calibration_rounded,
                            color: Colors.lightBlue,
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
                          controller.detailItem['status_name'].toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.pink.withOpacity(0.2),
                          child: Icon(
                            Icons.car_repair,
                            color: Colors.pink,
                          ),
                        ),
                        title: Text(
                          "Vehicle Type",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        subtitle: Text(
                          controller.detailItem['vehicle_type_name'] == null
                              ? "-"
                              : controller.detailItem['vehicle_type_name']
                                  .toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Divider(),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.green.withOpacity(0.2),
                          child: Icon(
                            Icons.date_range,
                            color: Colors.green,
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
                          controller.detailItem['receive_date'] == null
                              ? ""
                              : DateFormat("dd MMM yyyy").format(DateTime.parse(
                                  controller.detailItem['receive_date'])),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.orange.withOpacity(0.2),
                          child: Icon(
                            Icons.date_range,
                            color: Colors.orange,
                          ),
                        ),
                        title: Text(
                          "Stripping Done at",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        subtitle: Text(
                          controller.detailItem['stripping_done'] == null
                              ? ""
                              : DateFormat("dd MMM yyyy").format(DateTime.parse(
                                  controller.detailItem['stripping_done'])),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Divider(),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              ColorApp.mainColorApp.withOpacity(0.2),
                          child: Icon(
                            Icons.design_services_rounded,
                            color: ColorApp.mainColorApp,
                          ),
                        ),
                        title: Text(
                          "Item Name",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        subtitle: Text(
                          controller.detailItem['item_name'],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      // ListTile(
                      //   leading: CircleAvatar(
                      //     backgroundColor: Colors.green.withOpacity(0.2),
                      //     child: Text(
                      //       "Le",
                      //       style: TextStyle(
                      //         color: Colors.green,
                      //         fontSize: 13,
                      //         fontWeight: FontWeight.bold,
                      //       ),
                      //     ),
                      //   ),
                      //   title: Text(
                      //     "Length",
                      //     style: TextStyle(
                      //       color: Colors.grey,
                      //       fontSize: 12,
                      //     ),
                      //   ),
                      //   subtitle: Text(
                      //     controller.detailItem['long'].toString(),
                      //     style: TextStyle(
                      //       color: Colors.black,
                      //       fontSize: 15,
                      //     ),
                      //   ),
                      // ),
                      // ListTile(
                      //   leading: CircleAvatar(
                      //     backgroundColor: Colors.orange.withOpacity(0.2),
                      //     child: Text(
                      //       "Wi",
                      //       style: TextStyle(
                      //         color: Colors.orange,
                      //         fontSize: 13,
                      //         fontWeight: FontWeight.bold,
                      //       ),
                      //     ),
                      //   ),
                      //   title: Text(
                      //     "Width",
                      //     style: TextStyle(
                      //       color: Colors.grey,
                      //       fontSize: 12,
                      //     ),
                      //   ),
                      //   subtitle: Text(
                      //     controller.detailItem['wide'].toString(),
                      //     style: TextStyle(
                      //       color: Colors.black,
                      //       fontSize: 15,
                      //     ),
                      //   ),
                      // ),
                      // ListTile(
                      //   leading: CircleAvatar(
                      //     backgroundColor: Colors.lightBlue.withOpacity(0.2),
                      //     child: Text(
                      //       "He",
                      //       style: TextStyle(
                      //         color: Colors.lightBlue,
                      //         fontSize: 13,
                      //         fontWeight: FontWeight.bold,
                      //       ),
                      //     ),
                      //   ),
                      //   title: Text(
                      //     "Height",
                      //     style: TextStyle(
                      //       color: Colors.grey,
                      //       fontSize: 12,
                      //     ),
                      //   ),
                      //   subtitle: Text(
                      //     controller.detailItem['height'].toString(),
                      //     style: TextStyle(
                      //       color: Colors.black,
                      //       fontSize: 15,
                      //     ),
                      //   ),
                      // ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.pink.withOpacity(0.2),
                          child: Text(
                            "St",
                            style: TextStyle(
                              color: Colors.pink,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(
                          "Stock",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        subtitle: Text(
                          controller.detailItem['stock'].toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      // ListTile(
                      //   leading: CircleAvatar(
                      //     backgroundColor: Colors.teal.withOpacity(0.2),
                      //     child: Icon(
                      //       Icons.pie_chart,
                      //       color: Colors.teal,
                      //     ),
                      //   ),
                      //   title: Text(
                      //     "Piece name",
                      //     style: TextStyle(
                      //       color: Colors.grey,
                      //       fontSize: 12,
                      //     ),
                      //   ),
                      //   subtitle: Text(
                      //     controller.detailItem['piece_name'].toString(),
                      //     style: TextStyle(
                      //       color: Colors.black,
                      //       fontSize: 15,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
      );
    });
  }
}
