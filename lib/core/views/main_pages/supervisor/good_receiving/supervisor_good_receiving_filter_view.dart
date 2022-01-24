import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sologwarehouseapp/core/controllers/main_pages/supervisor/good_receiving/supervisor_good_receiving_filter_controller.dart';
import 'package:sologwarehouseapp/static/color_app.dart';
import 'package:sologwarehouseapp/widgets/app_bar.dart';

class SupervisorGoodReceivingFilterView extends StatelessWidget {
  final controller = Get.put(SupervisorGoodReceivingFilterController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupervisorGoodReceivingFilterController>(
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
                controller.saveFilter();
              },
              backgroundColor: ColorApp.mainColorApp,
              child: Icon(
                Icons.check,
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
                    title: "Filter")
              ];
            },
            body: ListView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(
                  top: 10, bottom: MediaQuery.of(context).size.height * 0.09),
              children: [
                Container(
                  child: ListTile(
                    contentPadding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    onTap: () {
                      controller.changeCompany();
                    },
                    dense: true,
                    title: Text(
                      "Company",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.black),
                    ),
                    subtitle: Text(
                      controller.company.isEmpty
                          ? "Choose company here"
                          : "${controller.company['code']}-${controller.company['name']}",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 13,
                          color: Colors.grey),
                    ),
                    trailing: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.grey[200],
                      child: Icon(
                        Icons.chevron_right_rounded,
                        color: Colors.grey,
                        size: 14,
                      ),
                    ),
                  ),
                ),
                controller.company.isEmpty
                    ? Opacity(
                        opacity: 0,
                      )
                    : Container(
                        child: ListTile(
                          contentPadding: EdgeInsets.only(
                            left: 20,
                            right: 20,
                          ),
                          onTap: () {
                            controller.changeWarehouse();
                          },
                          dense: true,
                          title: Text(
                            "Warehouse",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.black),
                          ),
                          subtitle: Text(
                            controller.warehouse.isEmpty
                                ? "Choose warehouse"
                                : "${controller.warehouse['code']}-${controller.warehouse['name']}",
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 13,
                                color: Colors.grey),
                          ),
                          trailing: CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.grey[200],
                            child: Icon(
                              Icons.chevron_right_rounded,
                              color: Colors.grey,
                              size: 14,
                            ),
                          ),
                        ),
                      ),
                Container(
                  child: ListTile(
                    contentPadding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    onTap: () {
                      controller.changeCustomer();
                    },
                    dense: true,
                    title: Text(
                      "Customer",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.black),
                    ),
                    subtitle: Text(
                      controller.customer.isEmpty
                          ? "Choose customer"
                          : "${controller.customer['name']}",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 13,
                          color: Colors.grey),
                    ),
                    trailing: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.grey[200],
                      child: Icon(
                        Icons.chevron_right_rounded,
                        color: Colors.grey,
                        size: 14,
                      ),
                    ),
                  ),
                ),
                Container(
                  child: ListTile(
                    contentPadding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    onTap: () {
                      controller.changeDateRange(context);
                    },
                    dense: true,
                    title: Text(
                      "Receive Date",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.black),
                    ),
                    subtitle: Text(
                      "${DateFormat("dd MMM yyyy").format(controller.startDate)} - ${DateFormat("dd MMM yyyy").format(controller.endDate)}",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 13,
                          color: Colors.grey),
                    ),
                    trailing: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.grey[200],
                      child: Icon(
                        Icons.chevron_right_rounded,
                        color: Colors.grey,
                        size: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
