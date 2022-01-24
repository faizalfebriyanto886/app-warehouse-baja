import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sologwarehouseapp/core/controllers/main_pages/supervisor/putaway/supervisor_putaway_controller.dart';
import 'package:sologwarehouseapp/core/views/main_pages/supervisor/putaway/form/supervisor_add_putaway_view.dart';
import 'package:sologwarehouseapp/core/views/main_pages/supervisor/putaway/supervisor_putaway_detail_view.dart';
import 'package:sologwarehouseapp/static/color_app.dart';
import 'package:sologwarehouseapp/widgets/app_bar.dart';
import 'package:sologwarehouseapp/widgets/waiting_widget.dart';

class SupervisorPutawayView extends StatelessWidget {
  final controller = Get.put(SupervisorPutawayController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupervisorPutawayController>(builder: (_) {
      return Scaffold(
        floatingActionButton: Container(
          margin: EdgeInsets.only(
            right: 15,
            bottom: 15,
          ),
          child: FloatingActionButton(
            elevation: 0.5,
            onPressed: () {
              Get.to(() => SupervisorAddPutawayView());
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
                title: "Putaway",
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
          body: controller.isLoading && controller.putAwayList.isEmpty
              ? WaitingWidget()
              : !controller.isLoading && controller.putAwayList.isEmpty
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
                          itemCount: controller.putAwayList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Get.to(() => SupervisorPutawayDetailView(),
                                    arguments: {
                                      "putaway_id":
                                          controller.putAwayList[index]['id'],
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
                                      title: Text(
                                        controller.putAwayList[index]
                                            ['code'],
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      subtitle: controller.putAwayList[index]
                                                      ['storage_from'] ==
                                                  null &&
                                              controller.putAwayList[index]
                                                      ['storage_to'] ==
                                                  null
                                          ? null
                                          : RichText(
                                              text: TextSpan(
                                                children: <WidgetSpan>[
                                                  controller.putAwayList[index][
                                                              'storage_from'] ==
                                                          null
                                                      ? WidgetSpan(
                                                          child: Opacity(
                                                            opacity: 0,
                                                          ),
                                                        )
                                                      : WidgetSpan(
                                                          child: Text(
                                                            controller.putAwayList[
                                                                    index][
                                                                'storage_from'],
                                                            style: TextStyle(
                                                              color: ColorApp
                                                                  .mainColorApp,
                                                            ),
                                                          ),
                                                        ),
                                                  controller.putAwayList[index]
                                                              ['storage_to'] ==
                                                          null
                                                      ? WidgetSpan(
                                                          child: Opacity(
                                                            opacity: 0,
                                                          ),
                                                        )
                                                      : WidgetSpan(
                                                          alignment:
                                                              PlaceholderAlignment
                                                                  .bottom,
                                                          child: Text(
                                                            " to ",
                                                          ),
                                                        ),
                                                  controller.putAwayList[index]
                                                              ['storage_to'] ==
                                                          null
                                                      ? WidgetSpan(
                                                          child: Opacity(
                                                            opacity: 0,
                                                          ),
                                                        )
                                                      : WidgetSpan(
                                                          child: Text(
                                                            controller.putAwayList[
                                                                    index]
                                                                ['storage_to'],
                                                            style: TextStyle(
                                                              color: ColorApp
                                                                  .mainColorApp,
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
                                              DateTime.parse(
                                                  controller.putAwayList[index]
                                                      ['date_transaction'])),
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
                                      ),
                                      child: Text(
                                        controller.putAwayList[index]
                                            ['status_name'],
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
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
        ),
      );
    });
  }
}
