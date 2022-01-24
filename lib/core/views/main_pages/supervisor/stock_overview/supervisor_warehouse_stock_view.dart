import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sologwarehouseapp/core/controllers/main_pages/supervisor/stock_view/supervisor_warehouse_stock_controller.dart';
import 'package:sologwarehouseapp/static/color_app.dart';
import 'package:sologwarehouseapp/widgets/app_bar.dart';
import 'package:sologwarehouseapp/widgets/waiting_widget.dart';

class SupervisorWarehouseStockView extends StatelessWidget {
  final controller = Get.put(SupervisorWarehouseStockController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupervisorWarehouseStockController>(builder: (_) {
      return Scaffold(
        // floatingActionButton: Container(
        //   margin: EdgeInsets.only(
        //     right: 15,
        //     bottom: 15,
        //   ),
        //   child: FloatingActionButton(
        //     elevation: 0.5,
        //     onPressed: () {},
        //     backgroundColor: ColorApp.mainColorApp,
        //     child: Icon(
        //       Icons.filter_alt_rounded,
        //       color: Colors.white,
        //     ),
        //   ),
        // ),
        body: NestedScrollView(
          headerSliverBuilder: (ctx, _) {
            return <Widget>[
              AppBarUI().sliverAppBarWithBackButton(
                actionBackButton: () {
                  Get.back();
                },
                title: "Warehouse Stock",
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
          body: controller.isLoading && controller.stockList.isEmpty
              ? WaitingWidget()
              : !controller.isLoading && controller.stockList.isEmpty
                  ? EmptyWidget()
                  : ListView(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.only(),
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            right: 20.0,
                            left: 20.0,
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.only(),
                            leading: CircleAvatar(
                              backgroundColor:
                                  ColorApp.mainColorApp.withOpacity(0.1),
                              child: Icon(
                                Icons.store_mall_directory_rounded,
                                color: ColorApp.mainColorApp,
                              ),
                            ),
                            title: Text(
                              "Warehouse",
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                              ),
                            ),
                            subtitle: Text(
                              controller.warehouseName,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        // Container(
                        //   margin: const EdgeInsets.only(
                        //     right: 20.0,
                        //     left: 20.0,
                        //     top: 10,
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
                        //           hintText: "Search...",
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
                        ListView.builder(
                          padding: EdgeInsets.only(
                            top: 10,
                            bottom: MediaQuery.of(context).size.height * 0.1,
                          ),
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: controller.stockList.length,
                          itemBuilder: (context, index) {
                            if (controller.stockList[index]['qty']
                                .toString()
                                .contains("(")) {
                              return Opacity(
                                opacity: 0,
                              );
                            } else {
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
                                      title: Text(
                                        controller.stockList[index]['name'],
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      subtitle: Text(
                                        controller.stockList[index]
                                            ['customer_name'],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      trailing: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          // color: Colors.black,
                                        ),
                                        padding: EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            top: 5,
                                            bottom: 5),
                                        child: Text(
                                          controller.stockList[index]['qty']
                                              .toString(),
                                          style: TextStyle(
                                              color: ColorApp.mainColorApp,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                      ),
                                      child: Text(
                                        controller.stockList[index]
                                            ['no_surat_jalan'],
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                        )
                      ],
                    ),
        ),
      );
    });
  }
}
