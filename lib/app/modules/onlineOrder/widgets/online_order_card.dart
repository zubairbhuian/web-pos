import 'package:flutter/material.dart';
import 'package:yogo_pos/app/modules/onlineOrder/models/order_model.dart';
import 'package:yogo_pos/app/modules/onlineOrder/widgets/online_order_details.dart';
import 'package:yogo_pos/app/utils/extension/my_extension.dart';
import 'package:yogo_pos/app/utils/int_extensions.dart';
import 'package:yogo_pos/app/utils/static_colors.dart';
import 'package:yogo_pos/app/widgets/popup_dialogs.dart';

import '../controllers/online_order_controller.dart';

import 'package:get/get.dart';

import '../views/order_details_view.dart';

class OnlineOrderCard extends GetView<OnlineOrderController> {
  final OrderModel order;
  const OnlineOrderCard(this.order, {super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return InkWell(
      onTap: () {
        controller.changeTabIndex(0);
        PopupDialog.customDialog(width: 550, child: OnlineOrderDetails(order));
        // orderSeen
        if (order.orderSeen == false) {
          controller.onOrderSeen(order.id, orderSeen: true);
        }
      },
      // Double Tap and Long Press feature should be same
      onDoubleTap: () {

        Get.to(() =>  OrderDetailsView(
          order
        ));
        // orderSeen
        if (order.orderSeen == false) {
          controller.onOrderSeen(order.id, orderSeen: true);
        }

        // PopupDialog.customDialog(width: 300, child: OnlineOrderStatus(order));
      },
      onLongPress: () {

        Get.to(() =>  OrderDetailsView(order));
        // orderSeen
        if (order.orderSeen == false) {
          controller.onOrderSeen(order.id, orderSeen: true);
        }
      },
      child: Container(
          height: 100,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          margin: const EdgeInsets.only(bottom: 6),
          decoration: BoxDecoration(
              color: order.orderSeen != false
                  ? const Color.fromARGB(48, 107, 107, 107)
                  : StaticColors.blueColor.withAlpha(50),
              border: Border(
                  bottom: BorderSide(color: theme.dividerColor, width: 1))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // icon area
              CircleAvatar(
                backgroundColor: controller.getStatusColor(order.orderStatus),
                radius: 15,
                child: const Icon(
                  Icons.business_center,
                  color: Colors.white,
                  size: 15,
                ),
              ),
              12.width,
              //leading area
              Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '# ${order.orderId}',
                        style: theme.textTheme.titleSmall,
                        maxLines: 1,
                      ),
                      Text(
                        'Token: ${order.tokenId}',
                        style: theme.textTheme.bodyMedium,
                        maxLines: 1,
                      ),
                      Text(
                        'Placed: ${order.createdAt.daysDifferenceFromNow()}',
                        style: theme.textTheme.bodyMedium,
                        maxLines: 1,
                      ),
                      Text(
                        'Updated: ${order.updatedAt.daysDifferenceFromNow()}',
                        style: theme.textTheme.bodyMedium,
                        maxLines: 1,
                      ),
                    ],
                  )),
              Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'CA\$${order.totalOrderAmount.toStringAsFixed(2)}',
                        style: theme.textTheme.titleSmall,
                        maxLines: 1,
                      ),
                      const Spacer(),
                      //todo: need to dynamic
                      Text(
                        order.oloPaymentType == "PAY LOCATION"
                            ? "PAY AT LOCATION"
                            : order.oloPaymentType,
                        style: theme.textTheme.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  )),
            ],
          )),
    );
  }
}
