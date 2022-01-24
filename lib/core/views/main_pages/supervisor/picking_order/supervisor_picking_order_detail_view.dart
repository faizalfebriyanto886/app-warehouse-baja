import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:sologwarehouseapp/core/controllers/main_pages/supervisor/picking_order/supervisor_picking_order_detail_controller.dart';
import 'package:sologwarehouseapp/static/color_app.dart';
import 'package:sologwarehouseapp/widgets/app_bar.dart';
import 'package:sologwarehouseapp/widgets/button.dart';
import 'package:sologwarehouseapp/widgets/waiting_widget.dart';

class SupervisorPickingOrderDetailView extends StatelessWidget {
  final controller = Get.put(SupervisorPickingOrderDetailController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupervisorPickingOrderDetailController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBarUI().appBarWithBackButton(
              actionButton: [],
              title: "Picking Order Detail",
              actionBackButton: () {
                Get.back();
              }),
          bottomNavigationBar:
              controller.isLoading && controller.pickingDetail.isEmpty
                  ? null
                  : !controller.isLoading && controller.pickingDetail.isEmpty
                      ? null
                      : controller.pickingDetail['item']['status'] != 2
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
                                      child: LoadingIndicator(
                                        color: ColorApp.mainColorApp,
                                        indicatorType: Indicator.ballPulse,
                                      ),
                                    )
                                  : AppButton().iconButton(
                                      icon: Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      ),
                                      buttonColor: ColorApp.mainColorApp,
                                      colorTextButton: Colors.white,
                                      function: () {
                                        controller.approvePickingOrder();
                                      },
                                      textButton: "Approve Picking Order",
                                    ),
                            )
                          : null,
          body: controller.isLoading && controller.pickingDetail.isEmpty
              ? WaitingWidget()
              : !controller.isLoading && controller.pickingDetail.isEmpty
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
                            controller.pickingDetail['item']['code'],
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
                            controller.pickingDetail['item']['status_name']
                                .toString(),
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
                            backgroundColor: Colors.grey.withOpacity(0.2),
                            child: Icon(
                              Icons.description,
                              color: Colors.brown,
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
                            controller.pickingDetail['item']['description'] ==
                                    null
                                ? "-"
                                : controller.pickingDetail['item']
                                        ['description']
                                    .toString(),
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
                            controller.pickingDetail['item']['warehouse_name'],
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
                              Icons.business,
                              color: Colors.green,
                            ),
                          ),
                          title: Text(
                            "Company",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                          subtitle: Text(
                            controller.pickingDetail['item']['company_name'],
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
                            controller.pickingDetail['item']
                                        ['date_transaction'] ==
                                    null
                                ? "-"
                                : DateFormat("dd MMM yyyy").format(
                                    DateTime.parse(
                                        controller.pickingDetail['item']
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
                            controller.pickingDetail['item']['date_approve'] ==
                                    null
                                ? "-"
                                : DateFormat("dd MMM yyyy").format(
                                    DateTime.parse(
                                        controller.pickingDetail['item']
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
                            itemCount:
                                controller.pickingDetail['detail'].length,
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
                                        controller.pickingDetail['detail']
                                                [index]['name']
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
                                        controller.pickingDetail['detail']
                                                [index]['code']
                                            .toString(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      trailing: Text(
                                        controller.pickingDetail['detail']
                                                [index]['qty']
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
                                              controller.pickingDetail['detail']
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
                                              " · ${controller.pickingDetail['detail'][index]['rack_code'].toString()} ",
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
      },
    );
  }
}
