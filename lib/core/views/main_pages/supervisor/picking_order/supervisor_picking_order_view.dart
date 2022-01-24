import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sologwarehouseapp/core/controllers/main_pages/supervisor/picking_order/supervisor_picking_order_controller.dart';
import 'package:sologwarehouseapp/core/views/main_pages/supervisor/picking_order/form/supervisor_add_picking_order_view.dart';
import 'package:sologwarehouseapp/core/views/main_pages/supervisor/picking_order/supervisor_picking_order_detail_view.dart';
import 'package:sologwarehouseapp/static/color_app.dart';
import 'package:sologwarehouseapp/widgets/app_bar.dart';
import 'package:sologwarehouseapp/widgets/waiting_widget.dart';

class SupervisorPickingOrderView extends StatelessWidget {
  final controller = Get.put(SupervisorPickingOrderController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupervisorPickingOrderController>(builder: (_) {
      return Scaffold(
          floatingActionButton: Container(
            margin: EdgeInsets.only(
              right: 15,
              bottom: 15,
            ),
            child: FloatingActionButton(
              backgroundColor: ColorApp.mainColorApp,
              onPressed: () {
                Get.to(() => SupervisorAddPickingOrderView());
              },
              elevation: 0.2,
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
          body: NestedScrollView(
            headerSliverBuilder: (ctx, _) {
              return <Widget>[
                AppBarUI().sliverAppBarWithBackButton(
                    actionBackButton: () {
                      Get.back();
                    },
                    actionButton: [],
                    title: "Picking Orders")
              ];
            },
            body: controller.isLoading && controller.pickingList.isEmpty
                  ? WaitingWidget()
                  : !controller.isLoading && controller.pickingList.isEmpty
                      ? EmptyWidget()
                      : ListView(
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.only(
                            top: 10,
                            bottom: MediaQuery.of(context).size.height * 0.09),
                        children: [
                          ListView.builder(
                            padding: EdgeInsets.only(
                              top: 5,
                              bottom: MediaQuery.of(context).size.height * 0.1,
                            ),
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: controller.pickingList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Get.to(
                                    () => SupervisorPickingOrderDetailView(),
                                    arguments: {
                                      "picking_order_id":
                                          controller.pickingList[index]['id'],
                                    },
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                    bottom: 20,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ListTile(
                                        contentPadding: EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                        ),
                                        dense: true,
                                        leading: CircleAvatar(
                                          backgroundColor: ColorApp.mainColorApp
                                              .withOpacity(0.2),
                                          child: Icon(
                                            Icons.inventory,
                                            color: ColorApp.mainColorApp,
                                          ),
                                        ),
                                        title: Text(
                                          "${controller.pickingList[index]['code'].toString()}",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        // subtitle: Text(
                                        //   "${controller.pickingList[index]['description'].toString()}",
                                        //   style: TextStyle(
                                        //       color: Colors.grey,
                                        //       fontSize: 12,
                                        //       fontWeight: FontWeight.normal),
                                        // ),
                                        trailing: Text(
                                         controller.pickingList[index]['created_at'] == null ? "-" : "${DateFormat("dd MMM yyyy").format(DateTime.parse(controller.pickingList[index]['created_at']))}",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
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
                                                "${controller.pickingList[index]['company']['name'].toString()}",
                                                style: TextStyle(
                                                    color:
                                                        ColorApp.mainColorApp,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ),
                                            WidgetSpan(
                                              child: Text(
                                                " · ${controller.pickingList[index]['warehouse']['name'].toString()}",
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
                                ),
                              );
                            },
                          )
                        ],
                      ),
          ));
    });
  }
}
