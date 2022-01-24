import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sologwarehouseapp/core/controllers/main_pages/supervisor/good_receiving/form/edit/supervisor_edit_receiving_controller.dart';
import 'package:sologwarehouseapp/static/color_app.dart';
import 'package:sologwarehouseapp/widgets/app_bar.dart';
import 'package:sologwarehouseapp/widgets/waiting_widget.dart';

class SupervisorEditReceivingView extends StatelessWidget {
  final controller = Get.put(SupervisorEditReceivingController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupervisorEditReceivingController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBarUI().appBarWithBackButton(
              actionButton: [],
              title: "Update items",
              actionBackButton: () {
                Get.back();
              }),
          floatingActionButton: Container(
            margin: EdgeInsets.only(
              right: 15,
              bottom: 15,
            ),
            child: FloatingActionButton(
              backgroundColor: ColorApp.mainColorApp,
              onPressed: () {
                controller.addItems();
              },
              elevation: 0.2,
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
          body: controller.isLoading && controller.goodReceivingDetail.isEmpty
              ? WaitingWidget()
              : !controller.isLoading && controller.goodReceivingDetail.isEmpty
                  ? EmptyWidget()
                  : ListView(
                      padding: EdgeInsets.only(),
                      physics: BouncingScrollPhysics(),
                      children: [
                        ListView.builder(
                            itemCount:
                                controller.goodReceivingDetail['detail'].length,
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.only(),
                            itemBuilder: (ctx, index) {
                              return GestureDetector(
                                onTap: () {
                                  controller.changeItem(
                                    itemIndex: index,
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
                                          controller
                                              .goodReceivingDetail['detail']
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
                                          controller
                                              .goodReceivingDetail['detail']
                                                  [index]['imposition_name']
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        trailing: Text(
                                          controller
                                              .goodReceivingDetail['detail']
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
                                                "Storage type : ${controller.goodReceivingDetail['detail'][index]['rack'] == null ? '-' : controller.goodReceivingDetail['detail'][index]['rack']['code']}",
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                            controller.goodReceivingDetail[
                                                            'detail'][index]
                                                        ['pallet'] ==
                                                    null
                                                ? WidgetSpan(
                                                    child: Opacity(
                                                    opacity: 0,
                                                  ))
                                                : WidgetSpan(
                                                    child: Text(
                                                      " · Pallet : ${controller.goodReceivingDetail['detail'][index]['pallet'] == null ? '' : controller.goodReceivingDetail['detail'][index]['pallet']['name']} ",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                          ]),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        margin: const EdgeInsets.only(
                                            top: 5, right: 20.0, left: 10.0),
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          onTap: () {
                                            controller.removeItem(index);
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 10),
                                            child: Text(
                                              "Hapus",
                                              style: TextStyle(
                                                  color: Colors.red[400],
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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
