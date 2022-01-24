import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sologwarehouseapp/core/controllers/main_pages/supervisor/stock_opname/supervisor_stock_opname_detail_controller.dart';
import 'package:sologwarehouseapp/static/color_app.dart';
import 'package:sologwarehouseapp/widgets/app_bar.dart';
import 'package:sologwarehouseapp/widgets/button.dart';
import 'package:sologwarehouseapp/widgets/waiting_widget.dart';

class SupervisorStockOpnameDetailView extends StatelessWidget {
  final controller = Get.put(SupervisorStockOpnameDetailController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupervisorStockOpnameDetailController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBarUI().appBarWithBackButton(
              actionButton: [],
              title: "Picking Order Detail",
              actionBackButton: () {
                Get.back();
              }),
          bottomNavigationBar: controller.isLoading &&
                  controller.stockOpnameDetail.isEmpty
              ? null
              : !controller.isLoading && controller.stockOpnameDetail.isEmpty
                  ? null
                  : controller.stockOpnameDetail['item']['status'] != 2
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
                                  icon: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  ),
                                  buttonColor: ColorApp.mainColorApp,
                                  colorTextButton: Colors.white,
                                  function: () {
                                    controller.approve();
                                  },
                                  textButton: "Approve",
                                ),
                        )
                      : null,
          body: controller.isLoading && controller.stockOpnameDetail.isEmpty
              ? WaitingWidget()
              : !controller.isLoading && controller.stockOpnameDetail.isEmpty
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
                            controller.stockOpnameDetail['item']['code'],
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
                            controller.stockOpnameDetail['item']['status_name']
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
                            backgroundColor: Colors.cyan.withOpacity(0.2),
                            child: Icon(
                              Icons.merge_type_rounded,
                              color: Colors.cyan,
                            ),
                          ),
                          title: Text(
                            "Type",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                          subtitle: Text(
                            controller.stockOpnameDetail['item']['type'] == 1
                                ? "Full"
                                : "Partial",
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
                            controller.stockOpnameDetail['item']['warehouse']
                                ['name'],
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
                            "Date Created",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                          subtitle: Text(
                            controller.stockOpnameDetail['item']
                                        ['created_at'] ==
                                    null
                                ? "-"
                                : DateFormat("dd MMM yyyy").format(
                                    DateTime.parse(
                                        controller.stockOpnameDetail['item']
                                            ['created_at'])),
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
                                controller.stockOpnameDetail['detail'].length,
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
                                        controller.stockOpnameDetail['detail']
                                                [index]['item_name']
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
                                        controller.stockOpnameDetail['detail']
                                                [index]
                                                ['warehouse_receipt_code']
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      trailing: Text(
                                        controller.stockOpnameDetail['detail']
                                                [index]['rack_code']
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
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
                                              "Stock System : ${controller.stockOpnameDetail['detail'][index]['stock_sistem'].toString()}",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                          WidgetSpan(
                                            child: Text(
                                              " · Stock Real : ${controller.stockOpnameDetail['detail'][index]['stock_riil'].toString()}",
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
