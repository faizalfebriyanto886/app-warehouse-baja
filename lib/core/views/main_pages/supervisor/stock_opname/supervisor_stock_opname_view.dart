import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sologwarehouseapp/core/controllers/main_pages/supervisor/stock_opname/supervisor_stock_opname_controller.dart';
import 'package:sologwarehouseapp/core/views/main_pages/supervisor/stock_opname/form/supervisor_add_stock_opname_view.dart';
import 'package:sologwarehouseapp/core/views/main_pages/supervisor/stock_opname/supervisor_stock_opname_detail_view.dart';
import 'package:sologwarehouseapp/static/color_app.dart';
import 'package:sologwarehouseapp/widgets/app_bar.dart';
import 'package:sologwarehouseapp/widgets/waiting_widget.dart';

class SupervisorStockOpnameView extends StatelessWidget {
  final SupervisorStockOpnameController controller =
      Get.put(SupervisorStockOpnameController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupervisorStockOpnameController>(
      builder: (_) {
        return Scaffold(
          floatingActionButton: Container(
            margin: EdgeInsets.only(
              right: 15,
              bottom: 15,
            ),
            child: FloatingActionButton(
              elevation: 0.5,
              onPressed: () {
                Get.to(() => SupervisorAddStockOpnameView());
              },
              backgroundColor: ColorApp.mainColorApp,
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
          appBar: AppBarUI().appBarWithBackButton(
              actionBackButton: () {
                Get.back();
              },
              actionButton: [],
              title: "Stock Opname"),
          body: controller.isLoading && controller.stockOpnameList.isEmpty
              ? WaitingWidget()
              : !controller.isLoading && controller.stockOpnameList.isEmpty
                  ? EmptyWidget()
                  : ListView(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.only(),
                      children: [
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
                          itemCount: controller.stockOpnameList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Get.to(() => SupervisorStockOpnameDetailView(),
                                    arguments: {
                                      "stock_opname_id": controller
                                          .stockOpnameList[index]['id'],
                                    });
                                print(controller.stockOpnameList[index]['id']);
                              },
                              child: Container(
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
                                        controller.stockOpnameList[index]
                                            ['code'],
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      subtitle: RichText(
                                        text: TextSpan(
                                          children: <WidgetSpan>[
                                            WidgetSpan(
                                              child: Text(
                                                controller
                                                        .stockOpnameList[index]
                                                    ['warehouse_name'].toString(),
                                                style: TextStyle(
                                                  color: ColorApp.mainColorApp,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
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
                                          DateFormat("dd MMM yyyy").format(
                                              DateTime.parse(controller
                                                      .stockOpnameList[index]
                                                  ['created_at'])),
                                          style: TextStyle(
                                            color: ColorApp.mainColorApp,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 5,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 3,
                                        horizontal: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: controller.stockOpnameList[index]
                                                    ['type'] ==
                                                "1"
                                            ? ColorApp.mainColorApp
                                            : Colors.orange[300],
                                      ),
                                      child: Text(
                                        controller.stockOpnameList[index]
                                                    ['type'] ==
                                                "1"
                                            ? "Full"
                                            : "Partial",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
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
        );
      },
    );
  }
}
