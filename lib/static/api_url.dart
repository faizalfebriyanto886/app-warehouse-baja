class ApiUrl {
  // static String baseUrl = "https://solog.karimunport.com/api/v4/";

  // API for demo https://demo.mybajatrans.com
  // API for Baja nyel "https://app.mybajatrans.com" akun yang tersedia Username = febri Password = 12345
  static String baseUrl = "https://demo.mybajatrans.com/api/v4/";

  static String signIn = baseUrl + "login";

  static String company = baseUrl + "list_company";
  static String customer = baseUrl + "list_customer";
  static String vehicle = baseUrl + "list_vehicle";
  static String items = baseUrl + "operational_warehouse/general_item_datatable";
  static String pallet = baseUrl + "operational_warehouse/master_pallet_datatable";
  static String rack = baseUrl + "list_rack";

  //===========

  //=========== Item barcode
  static String detailItem = baseUrl + "inventory/item/barcode";

  //=========== Receiving
  static String receiptAddNew = baseUrl + "operational_warehouse/receipt";
  static String receiptList =
      baseUrl + "operational_warehouse/warehouse_receipt_datatable";
  static String receiptDetail = baseUrl + "operational_warehouse/receipt";
  static String receiveApprove =
      baseUrl + "operational_warehouse/receipt/approve";

  //=========== Putaway
  static String putaway = baseUrl + "operational_warehouse/putaway_datatable";
  static String putawayAddNew = baseUrl + "operational_warehouse/putaway";
  static String itemListForNewPutawayByWarehouseId =
      baseUrl + "operational_warehouse/item_warehouse_datatable";
  static String putawayDetail = baseUrl + "operational_warehouse/putaway";
  static String putawayItemIn =
      baseUrl + "operational_warehouse/putaway/item_in";
  static String putawayItemOut =
      baseUrl + "operational_warehouse/putaway/item_out";

  //=========== Warehouse
  static String warehouseList = baseUrl + "list_warehouse";
  static String stockListByWarehouseId =
      baseUrl + "operational_warehouse/stocklist_datatable";

  //=========== Picking
  static String picking = baseUrl + "operational_warehouse/picking_datatable";
  static String pickingAddNew = baseUrl + "operational_warehouse/picking";
  static String pickingDetail = baseUrl + "operational_warehouse/picking";

  //=========== StockOpname
  static String stockOpnameAddNew =
      baseUrl + "operational_warehouse/stok_opname";
  static String stockOpname =
      baseUrl + "operational_warehouse/stok_opname_datatable";
  static String stockOpnameDetail =
      baseUrl + "operational_warehouse/stok_opname";

  //=========== Barcode
  static String barcode = baseUrl + "operational_warehouse/receipt/barcode";
}
