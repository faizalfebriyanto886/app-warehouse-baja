import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sologwarehouseapp/core/controllers/main_pages/supervisor/stock_view/supervisor_stock_overview_controller.dart';
import 'package:sologwarehouseapp/static/color_app.dart';
import 'package:sologwarehouseapp/widgets/app_bar.dart';
import 'package:sologwarehouseapp/widgets/waiting_widget.dart';

import 'supervisor_warehouse_stock_view.dart';

class SupervisorStockOverviewView extends StatelessWidget {
  final controller = Get.put(SupervisorStockOverviewController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupervisorStockOverviewController>(builder: (_) {
      return Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (ctx, _) {
            return <Widget>[
              AppBarUI().sliverAppBarWithBackButton(
                actionBackButton: () {
                  Get.back();
                },
                title: "Stock Overview",
                actionButton: [
                  // Container(
                  //   margin: EdgeInsets.only(right: 20),
                  //   child: CircleAvatar(
                  //     backgroundColor: Colors.orange[300].withOpacity(0.1),
                  //     child:
                  //         Icon(Icons.notifications, color: Colors.orange[300]),
                  //   ),
                  // ),
                ],
              )
            ];
          },
          body: controller.isLoading && controller.warehouseList.isEmpty
              ? WaitingWidget()
              : !controller.isLoading && controller.warehouseList.isEmpty
                  ? EmptyWidget()
                  : ListView(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.only(
                        top: 15,
                      ),
                      children: [
                        // Container(
                        //   margin: const EdgeInsets.only(
                        //     right: 20.0,
                        //     left: 20.0,
                        //   ),
                        //   child: Container(
                        //     padding: EdgeInsets.only(
                        //       left: 10,
                        //       right: 10,
                        //     ),
                        //     decoration: BoxDecoration(
                        //       color: Colors.grey[100],
                        //       borderRadius: BorderRadius.circular(8),
                        //     ),
                        //     child: Theme(
                        //       child: TextFormField(
                        //         // controller:
                        //         //     forgotPasswordController.usernameController,
                        //         keyboardType: TextInputType.text,
                        //         textAlign: TextAlign.left,
                        //         maxLines: 1,
                        //         cursorColor: ColorApp.mainColorApp,
                        //         style: TextStyle(
                        //           color: Colors.black,
                        //           fontSize: 14,
                        //         ),
                        //         obscureText: false,
                        //         decoration: InputDecoration(
                        //           disabledBorder: UnderlineInputBorder(
                        //             borderSide: new BorderSide(
                        //               color: Colors.transparent,
                        //             ),
                        //           ),
                        //           enabledBorder: new UnderlineInputBorder(
                        //             borderSide: new BorderSide(
                        //               color: Colors.transparent,
                        //             ),
                        //           ),
                        //           focusedBorder: new UnderlineInputBorder(
                        //             borderSide: new BorderSide(
                        //               color: Colors.transparent,
                        //             ),
                        //           ),
                        //           hintText: "Search warehouse...",
                        //           hintStyle: TextStyle(
                        //             color: Colors.grey,
                        //           ),
                        //         ),
                        //       ),
                        //       data: Theme.of(context).copyWith(
                        //         primaryColor: ColorApp.mainColorApp,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Container(
                          margin: EdgeInsets.only(
                            left: 20,
                            right: 20,
                            // top: 30,
                          ),
                          child: Text(
                            "Warehouse List",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
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
                          physics: BouncingScrollPhysics(),
                          itemCount: controller.warehouseList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor:
                                    ColorApp.mainColorApp.withOpacity(0.1),
                                child: Icon(
                                  Icons.store_mall_directory_rounded,
                                  color: ColorApp.mainColorApp,
                                ),
                              ),
                              onTap: () {
                                Get.to(
                                  () => SupervisorWarehouseStockView(),
                                  arguments: {
                                    "warehouse_id":
                                        controller.warehouseList[index]['id'],
                                    "warehouse_name":
                                        controller.warehouseList[index]['name']
                                  },
                                );
                              },
                              title: Text(
                                "${controller.warehouseList[index]['code']} - ${controller.warehouseList[index]['name']}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    ),
        ),
      );
    });
  }
}
