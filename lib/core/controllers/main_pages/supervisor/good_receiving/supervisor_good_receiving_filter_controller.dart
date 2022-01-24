import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sologwarehouseapp/core/views/general_pages/general_page_list_company_view.dart';
import 'package:sologwarehouseapp/core/views/general_pages/general_page_list_customer_view.dart';
import 'package:sologwarehouseapp/core/views/general_pages/general_page_list_warehouse_by_company_view.dart';

class SupervisorGoodReceivingFilterController extends GetxController {
  static SupervisorGoodReceivingFilterController get controller =>
      Get.find<SupervisorGoodReceivingFilterController>();

  Map company = {};
  Map warehouse = {};
  Map customer = {};
  DateTime startDate = DateTime.now().add(Duration(days: -7));
  DateTime endDate = DateTime.now();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  changeCompany() async {
    var value = await Get.to(() => GeneralPageListCompany());
    if (value != null) {
      company.addAll(value['company']);
      warehouse.clear();
      update();
    }
  }

  changeWarehouse() async {
    var value = await Get.to(
      () => GeneralPageListWarehouseByCompanyView(),
      arguments: {
        "company_id": company['id'],
      },
    );
    if (value != null) {
      warehouse.addAll(value['warehouse']);
      update();
    }
  }

  changeCustomer() async {
    var value = await Get.to(() => GeneralPageListCustomerView());
    if (value != null) {
      customer.addAll(value['customer']);
      update();
    }
  }

  changeDateRange(BuildContext context) async {
    final picked = await showDateRangePicker(
      context: context,
      confirmText: "Confirm",
      cancelText: "Cancel",
      saveText: "Save",
      lastDate: DateTime.now(),
      firstDate: DateTime(2019),
      initialDateRange: DateTimeRange(
          start: DateTime.now().add(Duration(days: -7)), end: DateTime.now()),
    );
    if (picked != null) {
      startDate = picked.start;
      endDate = picked.end;
      update();
    }
  }

  saveFilter() {
    Map dataToSendBack = {
      "company": company,
      "warehouse": warehouse,
      "customer": customer,
      "start_date": startDate,
      "end_date": endDate,
    };
    update();
    Get.back(result: dataToSendBack);
  }
}
