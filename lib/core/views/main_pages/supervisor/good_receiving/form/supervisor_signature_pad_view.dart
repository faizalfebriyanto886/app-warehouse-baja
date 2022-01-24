import 'package:flutter/material.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'package:get/get.dart';
import 'package:sologwarehouseapp/core/controllers/main_pages/supervisor/good_receiving/form/supervisor_signature_pad_controller.dart';
import 'package:sologwarehouseapp/static/color_app.dart';
import 'package:sologwarehouseapp/widgets/app_bar.dart';

class SupervisorSignaturePadView extends StatelessWidget {
  final controller = Get.put(SupervisorSignaturePadController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupervisorSignaturePadController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBarUI().appBarWithBackButton(
              actionBackButton: () {
                Get.back();
              },
              actionButton: [
                Container(
                  alignment: Alignment.centerRight,
                  margin:
                      const EdgeInsets.only(top: 0.0, right: 20.0, left: 20.0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      controller.resetSignaturePad();
                    },
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: Text(
                        "Clear",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                )
              ],
              title: "Add new Signature"),
          floatingActionButton: Container(
            margin: EdgeInsets.only(
              right: 15,
              bottom: 15,
            ),
            child: FloatingActionButton(
              onPressed: () {
                controller.saveFromSignaturePadToImage();
              },
              elevation: 0.2,
              backgroundColor: ColorApp.mainColorApp,
              child: Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 2,
                      color: Colors.grey.withOpacity(0.1),
                    ),
                  ),
                ),
                child: Signature(
                  color: Colors.black, // Color of the drawing path
                  strokeWidth: 5.0, // with
                  backgroundPainter:
                      null, // Additional custom painter to draw stuff like watermark
                  onSign: () {}, // Callback called on user pan drawing
                  key: controller
                      .signatureKey, // key that allow you to provide a GlobalKey that'll let you retrieve the image once user has signed
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 10,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: ColorApp.mainColorApp.withOpacity(0.2),
                    child: Icon(
                      Icons.edit,
                      color: ColorApp.mainColorApp,
                    ),
                  ),
                  title: Text(
                    "Draw you signature!",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "Draw a signature inside the box above",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
