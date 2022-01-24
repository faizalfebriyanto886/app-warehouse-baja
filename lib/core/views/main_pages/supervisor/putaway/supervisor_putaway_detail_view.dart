import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sologwarehouseapp/core/controllers/main_pages/supervisor/putaway/supervisor_putaway_detail_controller.dart';
import 'package:sologwarehouseapp/static/color_app.dart';
import 'package:sologwarehouseapp/widgets/app_bar.dart';
import 'package:sologwarehouseapp/widgets/button.dart';
import 'package:sologwarehouseapp/widgets/waiting_widget.dart';

class SupervisorPutawayDetailView extends StatelessWidget {
  final controller = Get.put(SupervisorPutawayDetailController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupervisorPutawayDetailController>(builder: (_) {
      return Scaffold(
        appBar: AppBarUI().appBarWithBackButton(
            actionButton: [],
            title: "Putaway Detail",
            actionBackButton: () {
              Get.back();
            }),
        bottomNavigationBar: controller.isLoading &&
                controller.putAwayDetail.isEmpty
            ? null
            : !controller.isLoading && controller.putAwayDetail.isEmpty
                ? null
                : controller.putAwayDetail['item']['status'].toString() != "3"
                    ? Container(
                        height: 60,
                        margin: EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        child: controller.isLoadingChangeStatus
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
                                icon: controller.putAwayDetail['item']['status']
                                            .toString() ==
                                        "1"
                                    ? Icon(
                                        Icons.keyboard_arrow_up_rounded,
                                        color: Colors.white,
                                      )
                                    : Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: Colors.white,
                                      ),
                                buttonColor: ColorApp.mainColorApp,
                                colorTextButton: Colors.white,
                                function: () {
                                  if (controller.putAwayDetail['item']['status']
                                          .toString() ==
                                      "1") {
                                    // from draft to item out
                                    controller.changeStatusToItemOut();
                                  } else if (controller.putAwayDetail['item']
                                              ['status']
                                          .toString() ==
                                      "2") {
                                    // from item out to item in
                                    controller.changeStatusToItemIn();
                                  }
                                },
                                textButton: controller.putAwayDetail['item']
                                                ['status']
                                            .toString() ==
                                        "1"
                                    ? "Item Out"
                                    : "Item In",
                              ),
                      )
                    : null,
        body: controller.isLoading && controller.putAwayDetail.isEmpty
            ? WaitingWidget()
            : !controller.isLoading && controller.putAwayDetail.isEmpty
                ? EmptyWidget()
                : ListView(
                    padding: EdgeInsets.only(),
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
                          controller.putAwayDetail['item']['code'],
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
                          controller.putAwayDetail['item']['status_name'],
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
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
                          controller.putAwayDetail['item']['warehouse_name'],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      // ListTile(
                      //   dense: true,
                      //   leading: CircleAvatar(
                      //     backgroundColor: Colors.green.withOpacity(0.2),
                      //     child: Icon(
                      //       Icons.receipt,
                      //       color: Colors.green,
                      //     ),
                      //   ),
                      //   title: Text(
                      //     "Warehouse Receipt Code",
                      //     style: TextStyle(
                      //       color: Colors.grey,
                      //       fontSize: 12,
                      //     ),
                      //   ),
                      //   subtitle: Text(
                      //     controller.putAwayDetail['item']
                      //                 ['warehouse_receipt_code'] ==
                      //             null
                      //         ? "-"
                      //         : controller.putAwayDetail['item']
                      //                 ['warehouse_receipt_code']
                      //             .toString(),
                      //     style: TextStyle(
                      //       color: Colors.black,
                      //       fontSize: 13,
                      //     ),
                      //   ),
                      // ),
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
                          "Transaction Date",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        subtitle: Text(
                          controller.putAwayDetail['item']
                                      ['date_transaction'] ==
                                  null
                              ? "-"
                              : DateFormat("dd MMM yyyy").format(DateTime.parse(
                                  controller.putAwayDetail['item']
                                      ['date_transaction'])),
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
                          "Approval Date",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        subtitle: Text(
                          controller.putAwayDetail['item']['date_approve'] ==
                                  null
                              ? "-"
                              : DateFormat("dd MMM yyyy").format(DateTime.parse(
                                  controller.putAwayDetail['item']
                                      ['date_approve'])),
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
                          top: 15,
                          bottom: 5,
                        ),
                        child: Text(
                          "Items",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      ListView.builder(
                          itemCount: controller.putAwayDetail['detail'].length,
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
                                    leading: CircleAvatar(
                                      backgroundColor:
                                          Colors.grey.withOpacity(0.2),
                                      child: Text(
                                        "${index + 1}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    title: Text(
                                      controller.putAwayDetail['detail'][index]
                                              ['item_name']
                                          .toString(),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    subtitle: Text(
                                      controller.putAwayDetail['detail'][index]
                                              ['item_code']
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    trailing: Text(
                                      controller.putAwayDetail['detail'][index]
                                              ['qty']
                                          .toString(),
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
                                            controller.putAwayDetail['detail']
                                                    [index]
                                                    ['warehouse_receipt_code']
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        WidgetSpan(
                                          child: Text(
                                            " · ${controller.putAwayDetail['detail'][index]['category_name'].toString()} ",
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
                          })
                    ],
                  ),
      );
    });
  }
}
