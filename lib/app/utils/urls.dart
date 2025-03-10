class URLS {
  URLS._();
  // ***** Base URL
  // static String baseURL =
  //     'https://yogo-pos-admin.vercel.app/api/v1'; //for L3
  static String baseURL = 'https://test-node-rosy.vercel.app/api/v1';// nabil
  // static String baseURL = 'https://test.yogoeats.com/api/v1'; // aws test server

  // static String baseURL = 'https://5577.yogoeats.com/api/v1'; //for Line 1

  // static String baseURL = 'https://server2.yogoeats.com/api/v1';//For Line 2

  //** end popint **
  static String login = '$baseURL/restaurants';
  static String employeeLogin = '$baseURL/employees/login';
  static String employees = '$baseURL/employees/pos';
  static String clockIn = '$baseURL/clocks/clock-in';
  static String clockOut = '$baseURL/clocks/clock-out';
  static String categories = '$baseURL/categories';
  // static String mainCategories = '$baseURL/main-categories';
  static String orderStatus = '$baseURL/orders/order-status';
  static String orders = '$baseURL/orders';
  static String posCategories = '$baseURL/categories/pos';

  static String items = '$baseURL/items/pos';
  static String transferItems = '$baseURL/orders/transfer-items';
  static String placeOrder = '$baseURL/orders/place-order';

  static String tableCategory = '$baseURL/table-categories';
  static String tableHold = '$baseURL/tables';
  static String barList = '$baseURL/bars/list';
  static String allBarList = '$baseURL/bars/area';
  static String hallList = '$baseURL/table/hall-area';

  static String ordersList = '$baseURL/table/order/list';
  static String orderOfBookedTable(int tableId) =>
      '$baseURL/table/$tableId/current-order';
  static String updateOrder(String orderId) => '$baseURL/orders/$orderId';
  //split
  static String splitAmount(String orderId) =>
      '$baseURL/orders/split-amount/$orderId';
  static String splitOrder(String orderId) =>
      '$baseURL/orders/split-order/$orderId';
  // cashout and summary
  static String allCashout = '$baseURL/orders/cashout/all';
  static String dineInCashout = '$baseURL/orders/cashout/dine-in';
  static String takeoutCashout = '$baseURL/orders/cashout/takeout';
  static String dineInSummary = '$baseURL/orders/summary/dine-in';
  static String takeoutSummary = '$baseURL/orders/summary/takeout';

  // modifiers
  static String modifiers = '$baseURL/modifiers/pos';
  static String restaurantsDetails = '$baseURL/restaurants/details';
  // table reservations
  static String tableBooks = '$baseURL/olo/table-books/pos';

  // ******* Terminal URL ********
  // Moneris
  static String monerisUtl =
      'https://ippostest.moneris.com/v3/terminal'; // for test
  // static String monerisUtl = 'https://ippos.moneris.com/v3/terminal';  for production
  static String monerisPostBackURL =
      'https://test-node-rosy.vercel.app/moneris/postback';
  // ******* socket server ********
  // socket server
  static String socketServer = 'https://test.yogoeats.com';
  // static String socketServer =
  // 'https://test-node-4z52.onrender.com'; // for test
}
