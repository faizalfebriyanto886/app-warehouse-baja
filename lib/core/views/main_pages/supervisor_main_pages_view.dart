import 'package:sologwarehouseapp/core/controllers/main_pages/supervisor_main_pages_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sologwarehouseapp/core/views/main_pages/supervisor/good_receiving/supervisor_good_receiving_view.dart';
import 'package:sologwarehouseapp/core/views/main_pages/supervisor/picking_order/supervisor_picking_order_view.dart';
import 'package:sologwarehouseapp/core/views/main_pages/supervisor/putaway/supervisor_putaway_view.dart';
import 'package:sologwarehouseapp/core/views/main_pages/supervisor/stock_opname/supervisor_stock_opname_view.dart';
import 'package:sologwarehouseapp/static/color_app.dart';
import 'package:sologwarehouseapp/widgets/app_bar.dart';

import 'supervisor/stock_overview/supervisor_stock_overview_view.dart';

class SupervisorMainPagesView extends StatelessWidget {
  final SupervisorMainPagesController controller =
      Get.put(SupervisorMainPagesController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupervisorMainPagesController>(
      init: controller,
      builder: (_) {
        return Scaffold(
          appBar: AppBarUI().appBar(
            // leading: Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     Container(
            //       margin: EdgeInsets.only(left: 10),
            //       child: CircleAvatar(
            //         backgroundColor: ColorApp.mainColorApp.withOpacity(0),
            //         radius: 20,
            //         child: Icon(
            //           Icons.supervised_user_circle_rounded,
            //           color: ColorApp.mainColorApp,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            actionButton: [
              Container(
                margin: EdgeInsets.only(right: 20),
                child: CircleAvatar(
                  backgroundColor: Colors.orange[300]!.withOpacity(0.1),
                  child: Icon(Icons.notifications, color: Colors.orange[300]),
                ),
              ),
            ],
            title: "Solog WMS",
          ),
          body: // !! menu grid begin
              Container(
            alignment: Alignment.topCenter,
            child: GridView(
              padding: EdgeInsets.only(
                top: 10,
                bottom: 10,
                left: 15,
                right: 15,
              ),
              physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 2,
                childAspectRatio: 0.9,
              ),
              children: [
                menuGrid(
                  color: ColorApp.mainColorApp,
                  icon: Icons.local_offer,
                  title: "Stock Overview",
                  action: () {
                    Get.to(() => SupervisorStockOverviewView());
                  },
                ),
                menuGrid(
                  color: ColorApp.mainColorApp,
                  icon: Icons.save_alt_rounded,
                  title: "Good Receiving",
                  action: () {
                    Get.to(() => SupervisorGoodReceivingView());
                  },
                ),
                menuGrid(
                  color: ColorApp.mainColorApp,
                  icon: Icons.send_rounded,
                  title: "Put Away",
                  action: () {
                    Get.to(() => SupervisorPutawayView());
                  },
                ),
                menuGrid(
                  color: ColorApp.mainColorApp,
                  icon: Icons.calculate_rounded,
                  title: "Stock Opname",
                  action: () {
                    Get.to(() => SupervisorStockOpnameView());
                  },
                ),
                menuGrid(
                  color: ColorApp.mainColorApp,
                  icon: Icons.qr_code_scanner_rounded,
                  title: "Scan Barcode",
                  action: () async {
                    controller.scan(context);
                  },
                ),
                menuGrid(
                  color: ColorApp.mainColorApp,
                  icon: Icons.inventory,
                  title: "Picking Order",
                  action: () {
                    Get.to(() => SupervisorPickingOrderView());
                  },
                ),
                menuGrid(
                  color: Colors.red[400]!,
                  icon: Icons.logout,
                  title: "Logout",
                  action: () {
                    controller.signOut();
                  },
                ),
                menuGrid(
                  color: ColorApp.mainColorApp,
                  icon: Icons.logout,
                  title: "TES Search",
                  action: () {
                   
                  },
                ),
              ],
            ),
          ),
          // !! menu grid end,
        );
      },
    );
  }

  Widget menuGrid(
      {required Color color,
      required IconData icon,
      required String title,
      required Function action}) {
    return Container(
      child: GestureDetector(
        onTap: () {
          action();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.1),
              radius: 28,
              child: Icon(
                icon,
                color: color,
                size: 32,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 10,
              ),
              padding: EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
