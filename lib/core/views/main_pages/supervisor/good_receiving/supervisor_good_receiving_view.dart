import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sologwarehouseapp/core/controllers/main_pages/supervisor/good_receiving/supervisor_good_receiving_controller.dart';
import 'package:sologwarehouseapp/core/views/main_pages/supervisor/good_receiving/supervisor_good_receiving_detail_view.dart';
import 'package:sologwarehouseapp/static/color_app.dart';
import 'package:sologwarehouseapp/widgets/app_bar.dart';
import 'package:sologwarehouseapp/widgets/waiting_widget.dart';

import 'form/supervisor_add_receiving_view.dart';

class SupervisorGoodReceivingView extends StatelessWidget {
  final controller = Get.put(SupervisorGoodReceivingController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupervisorGoodReceivingController>(builder: (_) {
      return Scaffold(
        floatingActionButton: Container(
          margin: EdgeInsets.only(
            right: 15,
            bottom: 15,
          ),
          child: FloatingActionButton(
            elevation: 0.5,
            onPressed: () {
              Get.to(() => SupervisorAddReceivingView());
            },
            backgroundColor: ColorApp.mainColorApp,
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
                title: "Good Receiving",
                actionButton: [
                  Container(
                    alignment: Alignment.centerRight,
                    margin: const EdgeInsets.only(
                        top: 0.0, right: 20.0, left: 20.0),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        controller.reset();
                      },
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: Text(
                          "Reset",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ];
          },
          body: ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(),
            children: [
              Container(
                margin: const EdgeInsets.only(
                  right: 20.0,
                  left: 20.0,
                  top: 10,
                ),
                child: Row(
                  children: [
                    // Expanded(
                    //   child: Container(
                    //     margin: EdgeInsets.only(
                    //       right: 10,
                    //     ),
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
                    GestureDetector(
                      onTap: () {
                        controller.changeFilter();
                      },
                      child: Container(
                        child: CircleAvatar(
                          backgroundColor:
                              ColorApp.mainColorApp.withOpacity(0.1),
                          child: Icon(
                            Icons.filter_alt_rounded,
                            color: ColorApp.mainColorApp,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.07,
                margin: EdgeInsets.only(
                  top: 10,
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  physics: BouncingScrollPhysics(),
                  itemCount: controller.category.length,
                  itemBuilder: (ctx, index) {
                    return Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Chip(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        backgroundColor: controller.selectedCategory ==
                                controller.category[index]
                            ? ColorApp.mainColorApp
                            : Colors.white,
                        label: InkWell(
                          onTap: () {
                            controller.changeCategory(index);
                          },
                          child: Text(
                            controller.category[index],
                            style: TextStyle(
                              color: controller.selectedCategory ==
                                      controller.category[index]
                                  ? Colors.white
                                  : Colors.black.withOpacity(0.8),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              controller.isLoading && controller.goodReceiveList.isEmpty
                  ? WaitingWidget()
                  : !controller.isLoading && controller.goodReceiveList.isEmpty
                      ? EmptyWidget()
                      : ListView.builder(
                          padding: EdgeInsets.only(
                            top: 5,
                            bottom: MediaQuery.of(context).size.height * 0.1,
                          ),
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: controller.goodReceiveList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                print( controller.goodReceiveList[index]['id'] + "ID GR COK");
                                Get.to(
                                
                                    () => SupervisorGoodReceivingDetailView(),
                                    arguments: {
                                      "good_receiving_id": controller
                                          .goodReceiveList[index]['id']
                                          .toString()
                                    });
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
                                      leading: CircleAvatar(
                                        backgroundColor: ColorApp.mainColorApp
                                            .withOpacity(0.2),
                                        child: Icon(
                                          Icons.save_alt_rounded,
                                          color: ColorApp.mainColorApp,
                                        ),
                                      ),
                                      title: Text(
                                        "${controller.goodReceiveList[index]['code'].toString()}",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      subtitle: Text(
                                        "${controller.goodReceiveList[index]['purchase_order_code'].toString()}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal),
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
                                              "${DateFormat("dd MMM yyyy").format(DateTime.parse(controller.goodReceiveList[index]['receive_date']))}",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                          WidgetSpan(
                                            child: Text(
                                              " · ${controller.goodReceiveList[index]['total_item'].toString()} items",
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
        ),
      );
    });
  }
}
