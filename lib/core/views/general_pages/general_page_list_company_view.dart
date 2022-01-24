import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sologwarehouseapp/core/controllers/general_pages/general_page_list_company_controller.dart';
import 'package:sologwarehouseapp/widgets/app_bar.dart';

class GeneralPageListCompany extends StatelessWidget {
  final controller = Get.put(GeneralPageListCompanyController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralPageListCompanyController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBarUI().appBarWithBackButton(
            actionBackButton: () {
              Get.back();
            },
            actionButton: [],
            title: "Companies",
          ),
          body: ListView(
            padding: EdgeInsets.only(),
            physics: BouncingScrollPhysics(),
            children: [
              ListView.builder(
                  padding: EdgeInsets.only(),
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.companyList.length,
                  itemBuilder: (ctx, index) {
                    return ListTile(
                      contentPadding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      onTap: () {
                        Get.back(
                          result: {
                            "company": controller.companyList[index],
                          },
                        );
                      },
                      dense: true,
                      title: Text(
                        controller.companyList[index]['name'],
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.black),
                      ),
                      subtitle: Text(
                        controller.companyList[index]['code'].toString(),
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
                    );
                  })
            ],
          ),
        );
      },
    );
  }
}
