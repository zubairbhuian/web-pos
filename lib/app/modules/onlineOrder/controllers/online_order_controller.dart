import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yogo_pos/app/modules/onlineOrder/models/order_model.dart';
import 'package:yogo_pos/app/modules/onlineOrder/repo/online_order_repo.dart';

import 'package:yogo_pos/app/services/controller/base_controller.dart';
import 'package:yogo_pos/app/utils/static_colors.dart';
import 'package:yogo_pos/app/widgets/popup_dialogs.dart';

class OnlineOrderController extends GetxController {
  static OnlineOrderController get to => Get.find();
  TextEditingController estDateController = TextEditingController();
  TextEditingController estTimeController = TextEditingController();
  List<String> tabs = ["Details", "Items"];
  int unseenOrders = 0;
  int selectedTabIndex = 0;
  List<String> orderType = ["unpaid", "paid", "canceled"];
  List<String> orderTypeForTimeLine = ["confirmed", "completed"];
  List<Color> orderTypeColor = [
    StaticColors.blueColor,
    StaticColors.greenColor,
    StaticColors.orangeColor
  ];

  List<OrderModel> orders = [];
  // List<OrderModel> pendingOrders = [];
  // List<OrderModel> confirmedOrders = [];
  // List<OrderModel> completedOrders = [];
  // List<OrderModel> canceledOrders = [];

  // get orders
  Future<void> getOrders() async {
    orders = await OnlineOrderRepo.getOnlineOrders();
    unseenOrders = orders.where((order) => order.orderSeen == false).length;
    update();
  }

  // filater with order status
  List<OrderModel> filterOrders(String orderStatus) {
    // for completed unpaid orders
    if (orderStatus == "unpaid") {
      return orders
          .where((element) =>
              element.orderStatus != "CANCELED" &&
              element.paymentStatus == "UNPAID")
          .toList();
      // for completed paid orders
    } else if (orderStatus == "paid") {
      return orders
          .where((element) => element.paymentStatus == "PAID")
          .toList();
    } else if (orderStatus == "canceled") {
      return orders
          .where((element) => element.orderStatus == orderStatus.toUpperCase())
          .toList();
    } else {
      return [];
    }
  }

  // uodate order
  Future<bool> updateOrder(
    String id, {
    String? orderStatus,
    String? estimatedTime,
    String? estimatedDate,
    String? paymentStatus,
    bool? orderSeen,
  }) async {
    PopupDialog.showLoadingDialog();
    bool res = await OnlineOrderRepo().onUpdateOrder(
      id,
      orderStatus: orderStatus?.toUpperCase(),
      estimatedTime: estimatedTime,
      estimatedDate: estimatedDate,
      paymentStatus: paymentStatus,
      orderSeen: orderSeen,
    );
    if (res) {
      // estDateController.clear();
      // estTimeController.clear();
      await getOrders();
      PopupDialog.closeLoadingDialog();
      Get.back();
      update();
      return res;
    } else {
      PopupDialog.closeLoadingDialog();
      return res;
    }
  }

  Future<bool> onOrderSeen(
    String id, {
    bool? orderSeen,
  }) async {
    bool res = await OnlineOrderRepo().onUpdateOrder(
      id,
      orderSeen: orderSeen,
    );
    if (res) {
      await getOrders();
      update();
      return res;
    } else {
      return res;
    }
  }

  void changeTabIndex(int index) {
    selectedTabIndex = index;
    update();
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "confirmed":
        return StaticColors.blueColor; // Example: Blue for confirmed
      case "completed":
        return StaticColors.greenColor; // Example: Green for completed
      case "canceled":
        return StaticColors.orangeColor; // Example: Red for canceled
      default:
        return StaticColors.blueColor; // Default color if status is unknown
    }
  }

  // @override
  // void onInit() {
  //   if (BaseController.to.restaurantDetails?.restaurant.pickup == true) {
  //     getOrders();
  //   }

  //   super.onInit();
  // }

  @override
  void onClose() {
    estDateController.dispose();
    estTimeController.dispose();
    super.onClose();
  }
  @override
  void onReady() {
    getOrders();
    super.onReady();
  }
}
